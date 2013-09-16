<?php
Wind::import('LIB:base.PwBaseController');
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
	public $postion=array();
	public $emule='';
	
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

	}

	
	/**
	 * (non-PHPdoc)
	 * @see src/library/base/PwBaseController::afterAction()
	 */
	public function afterAction($handlerAdapter) {
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
	
}
?>
