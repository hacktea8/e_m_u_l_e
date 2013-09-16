<?php
/**
 * the last known user to change this file in the repository  <$LastChangedBy: gao.wanggao $>
 * @author $Author: gao.wanggao $ Foxsee@aliyun.com
 * @copyright ?2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id: PwSpace.php 6270 2012-03-20 02:09:11Z gao.wanggao $ 
 * @package 
 */

class PwEmule {
	
	/**
	 * 获取一条记录
	 * 
	 * @param int $uid
	 */
	public function getArticle($aid) {
		$aid = intval($aid);
		if ($aid < 1) return array();
		return $this->_getDao()->getEmule($aid);
	}
        /**
         *
         */
        public function getArticleListByCid($cid=0,$order=0,$page=1,$limit=25){
               $cid = intval($cid);
                return $this->_getDao()->getArticleListBycid($cid,$order,$page,$limit);
        }
        /**
         *
         */
        public function getsubparentCate($cid){
               $cid=intval($cid);
               if($cid<1) return array();
               return $this->_getDao()->getsubparentCate($cid);
        }
        /**
         *
         */
        public function getCateByCid($sub=0){
               
               return $this->_getDao()->getCateByCid($sub);
        }
        /**
         *
         */
        public function getHotTopic($order=0,$limit=15){
               return $this->_getDao()->getHotTopic($order,$limit);
        }
        /**
         *
         *
         */
        public function getAllSubcateByCid($cid,$limit=0){
               return $this->_getDao()->getAllSubcateByCid($cid,$limit);
        }
        /**
         *
         */
        public function getCateAtotal($cid){
               return $this->_getDao()->getCateAtotal($cid);
        }
        /**
         *
         *
         */
        public function getrootCate(){
               return $this->_getDao()->getrootCate();
        }	
	/**
	 * 获取多条记录
	 * 
	 * @param array $uids
	 */
	public function fetchSpace($aids) {
		if (!is_array($aids) || count($aids) < 1 ) return array();
		return $this->_getDao()-> fetchEmule($aids);	
	}
	
	public function getEmuleByDomain($domian) {
		if (empty($domian)) return false;
		return $this->_getDao()->getEmuleByDomain($domian);
	}
	
	public function addInfo($dm) {
		if (!$dm instanceof PwSpaceDm) return new PwError('EMULE:info.error');
		$resource=$dm->beforeAdd();
		if ($resource instanceof PwError) return $resource;
		$data = $dm->getData();
		$data['aid'] = $dm->aid;
		return $this->_getDao()->addInfo($data);
	}
	
	public function updateInfo($dm) {
		if (!$dm instanceof PwSpaceDm) return new PwError('EMULE:info.error');
		$resource=$dm->beforeUpdate();
		if ($resource instanceof PwError) return $resource;
		return $this->_getDao()->updateInfo($dm->aid, $dm->getData());
	}


	public function updateNumber($aid) {
		$aid = (int)$aid;
		return $this->_getDao()->updateNumber($aid);
	}
	
	public function deleteInfo($uid,$aid) {
		$uid = (int)$uid;
                $aid = intval($aid);
		if ($uid < 1 ||$aid<1) return false;
		return $this->_getDao()->deleteInfo($uid,$aid);
	}
	
	private function _getDao() {
		return Wekit::loadDao('emule.dao.PwEmuleDao');
	}
}
?>
