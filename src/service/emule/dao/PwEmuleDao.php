<?php
Wind::import('SRC:library.base.PwBaseDao');
/**
 * the last known user to change this file in the repository  <$LastChangedBy: gao.wanggao $>
 * @author $Author: gao.wanggao $ Foxsee@aliyun.com
 * @copyright ?2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id: PwSpaceDao.php 6219 2012-03-19 08:39:40Z gao.wanggao $ 
 * @package 
 */
class PwEmuleDao extends PwBaseDao {
	protected $_table = 'emule_article';
	protected $_dataStruct = '`id`, `cid`, `uid`, `name`, `relatdata`, `collectcount`, `keyword`, `downurl`, `vipdwurl`, `ptime`, `utime`, `intro`, `thum`, `hits`';
	
	
	public function getEmule($aid) {
		$sql = $this->_bindTable('SELECT '.$this->_dataStruct.' FROM %s WHERE id = ? ');
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->getOne(array($aid));
	}


        public function getHotTopic($order=0,$limit=15){
                $order=$order?' `ptime` DESC ':' `hits` DESC ';
                $sql='SELECT `id`, `name`, `thum` FROM '.$this->getTable('emule_article').' WHERE `flag`=1 ORDER BY '.$order.' LIMIT '.$limit;            
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->queryAll();
        }

        public function getCateByCid($sub=0){
                if($sub){
                   $sql='SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->getTable('emule_cate').' WHERE `flag` = 1';
                   $smt = $this->getConnection()->createStatement($sql);
                   $list= $smt->queryAll();
                   $res=array();
                   foreach($list as $val){
                      if($val['pid']==0){
                         $res[$val['id']]['id']=$val['id'];
                         $res[$val['id']]['name']=$val['name'];
                         $res[$val['id']]['atotal']=$val['atotal'];
                      }else{
                         $res[$val['pid']]['subcate'][]=$val;
                      }
                   }
                   return $res;
                }

                $sql='SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->getTable('emule_cate').' WHERE `pid` = 0 AND `flag` = 1';
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->queryAll();
        }

        public function getArticleListBycid($cid='',$order=0,$page=1,$limit=25){
                switch($order){
                case 1:
                $order=' ORDER BY a.hits ASC ';
                break;
                case 2:
                $order=' ORDER BY a.hits DESC ';
                break;
                default:
                $order=' ORDER BY a.ptime DESC ';
                }
                $page=intval($page)-1;
                $page=$page>-1?$page:0;
                $limit=intval($limit);
                $page*=$limit;
                if($cid){
                  $cids=$this->getAllCateidsByCid($cid);
                  $cids=implode(',',$cids);
                  $where=' AND `cid` in ('.$cids.')  ';
                }
                $sql=$this->_bindSql("SELECT a.`id`, `cid`, `uid`,c.`name` as cname,c.atotal, a.`name`, `keyword`, `description`, `ptime`, `utime`, `thum`, `hits` FROM ".$this->getTable('emule_article')." as a INNER JOIN ".$this->getTable('emule_cate')." as c WHERE a.cid=c.id %s AND a.`flag`=1 AND c.flag=1 %s LIMIT %d,$limit",$where,$order,$page);
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->queryAll();
        }

        public function getrootCate(){
                $sql=$this->_bindSql('SELECT `id`,`name` FROM '.$this->getTable('emule_cate').' WHERE `pid`=0 AND `flag`=1');
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->queryAll(array($cid));
        }

        public function getAllCateidsByCid($cid){
                $sql=$this->_bindSql('SELECT `id` FROM '.$this->getTable('emule_cate').' WHERE `pid`=? AND `flag`=1');
                $smt = $this->getConnection()->createStatement($sql);
                $cate=$smt->queryAll(array($cid));
                $res=array();
                foreach($cate as $val){
                   $res[]=$val['id'];
                }
                $res=count($res)?$res:array($cid);
                return $res;
        }

        public function getAllSubcateByCid($cid,$limit=0){
                $sql=$this->_bindSql('SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->getTable('emule_cate').' WHERE `id`=%d AND `flag`=1',$cid);
                $smt = $this->getConnection()->createStatement($sql);
                $subinfo=$smt->getOne(array($cid));
                if($subinfo['pid']){
                   $cid=$subinfo['pid'];
                }
                $limit=intval($limit);
                $limit=$limit?' ORDER BY atotal DESC LIMIT '.$limit:'';
                $sql=$this->_bindSql('SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->getTable('emule_cate').' WHERE `pid`=%d AND `flag`=1 %s',$cid,$limit);
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->queryAll(array($cid));
        }
        public function getCateAtotal($cid){
                $sql = $this->_bindSql('SELECT `pid`, `atotal` FROM '.$this->getTable('emule_cate').' WHERE `id`=? AND `flag`=1 LIMIT 1');
                $smt = $this->getConnection()->createStatement($sql);
                $subinfo=$smt->getOne(array($cid));

                if(!$subinfo['pid']){
                    $sql=$this->_bindSql('SELECT sum(`atotal`) as atotal FROM '.$this->getTable('emule_cate').' WHERE `pid`=? AND `flag`=1');
                    $smt = $this->getConnection()->createStatement($sql);
                    $subinfo=$smt->getOne(array($cid));
                }
                return $subinfo['atotal'];
                
        } 
        public function getsubparentCate($cid){
                $sql = $this->_bindSql('SELECT `id`, `pid`, `name` FROM '.$this->getTable('emule_cate').' WHERE `id`=? AND `flag`=1 LIMIT 1');
                $smt = $this->getConnection()->createStatement($sql);
                $subinfo=$smt->getOne(array($cid));
                if($subinfo['pid']){
                    $parinfo=$this->getsubparentCate($subinfo['pid']);
                }else{
                    return array($subinfo);
                }
                return $res=array(array('id'=>$parinfo[0]['id'],'name'=>$parinfo[0]['name']),array('id'=>$subinfo['id'],'name'=>$subinfo['name']));
        }
	
	public function fetchEmule($aids) {
		$sql = $this->_bindSql('SELECT * FROM %s WHERE id IN %s', $this->getTable(), $this->sqlImplode($aids));
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->queryAll(array(), 'id');
	}
	
	public function getEmuleByDomain($domain) {
		$sql = $this->_bindTable('SELECT * FROM %s WHERE emule_domain = ? LIMIT 1');
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->getOne(array($domain));
	}

	public function addInfo($data) {
		if (!$data = $this->_filterStruct($data)) return false;
		$sql = $this->_bindSql('INSERT INTO %s SET %s', $this->getTable(),  $this->sqlSingle($data));
		return $this->getConnection()->execute($sql);
	}
	
	public function updateInfo($uid, $data,$isadmin=false) {
                if(!isset($data['id'])) return false;
		if (!$data = $this->_filterStruct($data)) return false;
                $aid=intval($data['id']);unset($data['id']);
                if($isadmin){
                   $sql = $this->_bindSql('UPDATE %s SET %s WHERE id = ?',$this->getTable(), $this->sqlSingle($data));
                $smt = $this->getConnection()->createStatement($sql);
                return $smt->update(array($aid));
                }
		$sql = $this->_bindSql('UPDATE %s SET %s WHERE uid = ? AND id =%d',$this->getTable(), $this->sqlSingle($data),$aid);
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->update(array($uid));
	}
	
	public function updateNumber($aid) {
		$sql = $this->_bindSql('UPDATE %s SET %s WHERE id = ?', $this->getTable(), $this->sqlSingleIncrease(array('hits'=>1)));
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->update(array($id));
	}
	
	public function deleteInfo($uid,$aid) {
		$sql = $this->_bindTable('DELETE FROM %s  WHERE uid = ? AND id = ? ');
		$smt = $this->getConnection()->createStatement($sql);
		return $smt->update(array($uid,$aid));
	}

}
?>
