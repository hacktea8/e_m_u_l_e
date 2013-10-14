#!/usr/local/php/bin/php -q
<?php

define('WEKIT_VERSION',1);
$root=dirname(__FILE__).'/';
//echo $root;exit;
require_once($root.'../grab/db.class.php');
require_once($root.'../../src/library/base/PwBaseMemcache.php');

$model=new model();
$model->getIndexData();

class model{
  protected $db;
  public $emuleIndex=array();
  protected $mem;

  function __construct(){
    $this->db=new DB_MYSQL();
    $this->mem=new PwBaseMemcache();

  }
  function getArticleListByCid($cid,$order,$page,$limit){
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
   $sql=sprintf("SELECT a.`id`, `cid`, `uid`,c.`name` as cname,c.atotal, a.`name`, `keyword`, `description`, `ptime`, `utime`, `thum`, `hits` FROM ".$this->db->getTable('emule_article')." as a INNER JOIN ".$this->db->getTable('emule_cate')." as c WHERE a.cid=c.id %s AND a.`flag`=1 AND c.flag=1 %s LIMIT %d,$limit",$where,$order,$page);
   return $this->db->result_array($sql);
  }
  function getAllCateidsByCid($cid){
    $sql=sprintf('SELECT `id` FROM '.$this->db->getTable('emule_cate').' WHERE `pid`=%d AND `flag`=1',$cid);
    $cate=$this->db->result_array($sql);
    $res=array();
    if(is_array($cate)){
      foreach($cate as $val){
        $res[]=$val['id'];
      }
    }
    $res=count($res)?$res:array($cid);
    return $res;
  }
  function getrootCate(){
    $sql=sprintf('SELECT `id`,`name` FROM '.$this->db->getTable('emule_cate').' WHERE `pid`=0 AND `flag`=1');
    return $this->db->result_array($sql);
  }
  function getAllSubcateByCid($cid,$limit=0){
    $sql=sprintf('SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->db->getTable('emule_cate').' WHERE `id`=%d AND `flag`=1',$cid);
    $subinfo=$this->db->row_array($sql);
    if($subinfo['pid']){
       $cid=$subinfo['pid'];
    }
    $limit=intval($limit);
    $limit=$limit?' ORDER BY atotal DESC LIMIT '.$limit:'';
    $sql=sprintf('SELECT `id`, `pid`, `name`, `atotal` FROM '.$this->db->getTable('emule_cate').' WHERE `pid`=%d AND `flag`=1 %s',$cid,$limit);
    return $this->db->result_array($sql);
  }
  function getIndexData(){
    $this->emuleIndex['new']=$this->getArticleListByCid(0,0,1,15);
sleep(2);
    $this->emuleIndex['hot']=$this->getArticleListByCid(0,2,1,15);
sleep(2);
    $this->emuleIndex['rand']=$this->getArticleListByCid(0,1,1,15);
sleep(2);

    $rootCate=$this->getrootCate();
    $list=array();
    foreach($rootCate as $cate){
sleep(2);
      $list=$this->getArticleListByCid($cate['id'],2,1,10);
//echo '<pre>';var_dump($list);exit;
      $this->emuleIndex['catehot'][]=array('name'=>$cate['name'],'id'=>$cate['id'],'list'=>$list);
        //List article
sleep(2);
        $subcate=$this->getAllSubcateByCid($cate['id'],13);
        $list=array();
        foreach($subcate as $val){
sleep(2);
          $list[]=$this->getArticleListByCid($val['id'],0,1,15);
        }
        $this->emuleIndex['topiclist'][]=array('rand'=>$this->getArticleListByCid($cate['id'],1,1,20),'subcate'=>array('cate'=>$subcate,'list'=>$list));

    }

$this->mem->set('emu-emuleIndexinfo',$this->emuleIndex,259200);

  }
  
}
