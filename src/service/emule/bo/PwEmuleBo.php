<?php
/**
 * the last known user to change this file in the repository  <$LastChangedBy: gao.wanggao $>
 * @author $Author: gao.wanggao $ Foxsee@aliyun.com
 * @copyright ©2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id: PwSpaceBo.php 25545 2013-03-19 05:51:44Z gao.wanggao $ 
 * @package 
 */
 class PwEmuleBo {
 	public $emuleIndex = array(); 	//电驴资源首页信息
 	public $emule      = array();
        public $rootCate   =array();
        public $hotTopic   =array();
        public $emulelist  =array();	
        public $postion    =array();
        public $subcatelist=array();
        public $atotal     =0;
	
        public function getrootCateinfo(){
          $this->rootCate=$this->_getEmuleDs()->getCateByCid(0);
        }
        public function gethotTopicinfo(){
          $this->hotTopic=$this->_getEmuleDs()->getHotTopic(1,15);
        }
        /**
         *
         *
         */
         function getIndexData(){
               $this->emuleIndex['new']=$this->_getEmuleDs()->getArticleListByCid(0,0,1,15);
               $this->emuleIndex['hot']=$this->_getEmuleDs()->getArticleListByCid(0,2,1,15);
               $this->emuleIndex['rand']=$this->_getEmuleDs()->getArticleListByCid(0,1,1,15);
               $rootCate=$this->_getEmuleDs()->getrootCate();
               $list=array();
               foreach($rootCate as $cate){
                  $list=$this->_getEmuleDs()->getArticleListByCid($cate['id'],2,1,10);
                  $this->emuleIndex['catehot'][]=array('name'=>$cate['name'],'id'=>$cate['id'],'list'=>$list);
               //List article
                  $subcate=$this->_getEmuleDs()->getAllSubcateByCid($cate['id'],13);
                  $list=array();
                  foreach($subcate as $val){
                      $list[]=$this->_getEmuleDs()->getArticleListByCid($val['id'],0,1,15);
                  }
                  $this->emuleIndex['topiclist'][]=array('rand'=>$this->_getEmuleDs()->getArticleListByCid($cate['id'],1,1,20),'subcate'=>array('cate'=>$subcate,'list'=>$list));
                  
               }
               
               
         }	
	/**
	 * 设置访问用户
	 * Enter description here ...
	 * @param unknown_type $visitUid
	 */
	public function getArticleListByCid($cid='',$order=0,$page){
                     
		$this->emulelist=$this->_getEmuleDs()->getArticleListByCid($cid,$order,$page);
                foreach($this->emulelist as $key=>$val){
                   $this->emulelist[$key]['ptime']=date('Y-m-d',$val['ptime']);
                   $this->emulelist[$key]['utime']=date('Y/m/d',$val['utime']);
                }
                $this->postion = $this->_getEmuleDs()->getsubparentCate($cid);
                $this->subcatelist = $this->_getEmuleDs()->getAllSubcateByCid($cid);
                $this->atotal   = $this->_getEmuleDs()->getCateAtotal($cid);
	}
	
	/**
	 * 
	 * Enter description here ...
	 */
	public function getAllSubcateByCids($cid) {
		$this->subcatelist = $this->_getEmuleDs()->getAllSubcateByCid($cid);
	}
	
 	/**
 	 * 判断某个key显示权限
 	 * 
 	 * @param string $key 
 	 */
	public function allowView($key = 'space') {
		if ($this->tome == self::MYSELF) return true;
		if (!isset($this->spaceUser['secret'][$key])) {
			//手机号码默认仅对自己开放
			if ($key == 'mobile') {
				$this->spaceUser['secret'][$key] = self::MYSELF;
			} else {
				$this->spaceUser['secret'][$key] = self::VISITOR;
			}
		}
		switch ($this->spaceUser['secret'][$key]) {
			case 0://完全开放
				return true;
			case 1://对自已开放
				if ($this->tome == self::MYSELF) return true;
				break;
			case 2://对关注的人开放
				if ($this->tome == self::ATTENTION)	return true;
				break;
		}
		return false;
	}
	
 	private function _getSpaceUser() {
		$this->spaceUser = Wekit::load('user.PwUser')->getUserByUid($this->spaceUid, PwUser::FETCH_ALL);
		$this->spaceUser['secret'] = unserialize($this->spaceUser['secret']);
		!isset($this->spaceUser['secret']['mobile']) && $this->spaceUser['secret']['mobile'] = self::MYSELF;
	}
	
	private function _getSpace() {
		$this->space =  $this->_getSpaceDs()->getSpace($this->spaceUid);
		empty($this->space['space_name']) && $this->space['space_name'] = $this->spaceUser['username'] . '的个人空间';
		empty($this->space['space_privacy']) && $this->space['space_privacy'] = array();
		$this->space['domain'] = $this->_getDomain();

		list($image, $repeat, $fixed, $align) =  unserialize($this->space['back_image']);
		empty($repeat) && $repeat = 'no-repeat';
		empty($fixed) && $fixed = 'scroll';
		empty($align) && $align = 'center';
		$this->space['back_image'] = array($image, $repeat, $fixed, $align);
		$this->space['backbround'] = '';
		if (empty($image)) return;
		$image = Pw::getPath(''). $image;
		$this->space['backbround'] = 'style="';
		$this->space['backbround'] .= 'background-image: url( ' . $image . ');';
		$this->space['backbround'] .= 'background-repeat:' . $repeat . ';' ;
		$this->space['backbround'] .= 'background-attachment:' .$fixed . ';' ;
		$this->space['backbround'] .= 'background-position:top ' . $align . ';';
		$this->space['backbround'] .= '"';
		return;
	}
	
 	private function _getDomain() {
 		if ($this->space['space_domain']) {
 			$root = Wekit::C('domain', 'space.root');
 			if ($root) return 'http://' . $this->space['space_domain'] . '.' . $root;
 		}
 		return WindUrlHelper::createUrl('space/index/run', array('uid' => $this->spaceUid));
 	}
	
	/**
	 * 获取访问者和空间的关系
	 * 0未登录,1未关注,2本人,3主人关注的, 4,关注主人的 5互相关注
	 */
 	private function _getTome($spaceUid, $visitUid) {
 		$attention = $followed = false;
 		if ($visitUid == 0) return self::VISITOR;  
 		if ($visitUid == $spaceUid) return self::MYSELF; 
 		if (Wekit::load('attention.PwAttention')->isFollowed($spaceUid, $visitUid)) {
 			$attention = true; //self::ATTENTION; 
 		}
 		if (Wekit::load('attention.PwAttention')->isFollowed($visitUid, $spaceUid)) {
 			$followed = true; //self::FOLLOWED; 
 		}
 		if ($attention && $followed) return self::FRIEND;
 		if ($attention) return self::ATTENTION;
 		if ($followed) return self::FOLLOWED;
 		return self::STRANGER;
 	}
 	
 	protected function _getEmuleDs() {
 		return Wekit::load('emule.PwEmule');
 	}
 }
?>
