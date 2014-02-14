<?php
Wind::import('LIB:base.PwBaseController');
Wind::import('LIB:base.PwBaseRediscache');
Wind::import('LIB:base.PwBaseMemcache');
Wind::import('SRV:emule.bo.PwEmuleModel');

/**
 * the last known user to change this file in the repository  <$LastChangedBy$>
 * @author $Author$ Foxsee@aliyun.com
 * @copyright ?2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id$ 
 * @package 
 */
class EmuleBaseController extends PwBaseController {
        public $showimgapi = 'http://img.hacktea8.com/showpic.php?key=';
	public $postion = array();
	public $emule = '';
        protected $mem = '';
        protected $redis = '';
        protected $admingroup = array(3);
        public $keywords = '电驴资源,电驴资源网站,电驴资源下载,电驴资源搜索,电驴资源网,电驴资源网站,电驴下载,电骡资源,ed2k,eMule,电骡下载,emule 资源,电驴资源库,电驴共享';
        public $description = '是一个综合的电驴资源网站，提供包含电影、电视剧、音乐、游戏、动漫、综艺、软件、资料、图书、教育等栏目电驴资源搜索、电驴下载服务。';
        public $siteinfo = '';

	public $expirettl=array('5m'=>300,'15m'=>900,'30m'=>1800,'1h'=>3600,'3h'=>10800,'6h'=>21600,'9h'=>32400,'12h'=>43200,'1d'=>86400,'3d'=>253200,'5d'=>432000,'7d'=>604800);
	/**
	 * (non-PHPdoc)
	 * @see src/library/base/PwBaseController::beforeAction()
	 */
	public  function beforeAction($handlerAdapter) {
		parent::beforeAction($handlerAdapter);
/*/获取空间Uid
		$spaceUid = $this->getInput('uid','get');
//Uid=0 是游客
		if ($spaceUid === '0') {
			$this->showError('SPACE:space.guest');
		}
		$spaceUid = intval($spaceUid);
//Uid 小于1
		if ($spaceUid < 1) {
//获取名字
			if ($userName = $this->getInput('username','get')) {
//通过名字获取用户信息
				$user = Wekit::load('user.PwUser')->getUserByName($userName);
//初始化空间Uid
				$spaceUid = isset($user['uid'])? $user['uid'] : 0;
			} elseif ($this->loginUser->uid > 0) {
//获取登录的用户Uid
				$spaceUid = $this->loginUser->uid;
			} else {
//空间不存在
				$this->showError('SPACE:space.not.exist');
			}
		}
*///创建空间Model	
    $this->emule = new PwEmuleModel();
    $this->mem=new PwBaseMemcache();
    $this->redis=new PwBaseRediscache();
    $this->checkadmin();
    $this->siteinfo = Wekit::C('site');
    $this->setOutput($this->showimgapi, 'showimgapi');
    $this->setOutput($this->showimgapi.'3958009_0000671092.jpg', 'error_img');
  }

	
	/**
	 * (non-PHPdoc)
	 * @see src/library/base/PwBaseController::afterAction()
	 */
  public function afterAction($handlerAdapter) {
    $this->emule->hotTopic=$this->mem->get('emu-hotTopic');
    if(empty($this->emule->hotTopic)){
//die($this->expirettl['12h'].'empty');
      $this->emule->gethotTopicinfo();
//echo '<pre>';var_dump($this->emule->hotTopic);exit;
      $this->mem->set('emu-hotTopic',$this->emule->hotTopic,$this->expirettl['12h']);
    }
    $this->emule->rootCate=$this->mem->get('emu-rootCate');
    if(empty($this->emule->rootCate)){
       $this->emule->getrootCateinfo();
       $this->mem->set('emu-rootCate',$this->emule->rootCate,$this->expirettl['1d']);
    }
    $this->setOutput($this->emule->hotTopic, 'hotTopic');
    $this->setOutput($this->emule->rootCate, 'rootCate');
    $this->setOutput('http://www.ed2kers.com/', 'thumhost');
    $this->setOutput($this->emule->postion, 'postion');

//更新资源点击量
/*
		$this->setTheme('space', $this->space->space['space_style']);
		//$this->addCompileDir($this->space->space['space_style'] ? $this->space->space['space_style'] : Wekit::C('site', 'theme.space.default'));
		$host = $this->space->tome == PwSpaceModel::MYSELF ? '我' : 'Ta';
		$this->setOutput($this->space, 'space');
		$this->setOutput($host, 'host');
		$this->updateSpaceOnline();
*/
		parent::afterAction($handlerAdapter);
	}
	
	/**
	 * 更新在线状态
	 */
	protected function updateSpaceOnline() {
		if ($this->loginUser->uid < 1) return false;
		$online = Wekit::load('online.srv.PwOnlineService');
		$createdTime = $online->spaceOnline($this->space->spaceUid);
		if (!$createdTime) return false;
		$dm = Wekit::load('online.dm.PwOnlineDm');
		$time = Pw::getTime();
		$dm->setUid($this->loginUser->uid)->setUsername($this->loginUser->username)->setModifytime($time)->setCreatedtime($createdTime)->setGid($this->loginUser->gid)->setRequest($this->_mca);
		Wekit::load('online.PwUserOnline')->replaceInfo($dm);
		
		//脚印
		$service = Wekit::load('space.srv.PwSpaceService');
		$service->signVisitor($this->space->spaceUid, $this->loginUser->uid);
		$service->signToVisitor($this->space->spaceUid, $this->loginUser->uid);	
	}
       protected function checkadmin(){
                foreach($this->admingroup as $admin){
                   foreach($this->loginUser->groups as $adm){
                      if($admin == $adm){
                         $this->loginUser->isadmin = true;
                         return true;
                      }
                   }
                }
                $this->loginUser->isadmin = false;
                return false;
       }
       protected function checkVerify(){
                $root = dirname(__FILE__);
                echo $root;exit;require_once $root.'/Verify/YinXiangMaLibConfig.php';
                
       }
}
?>
