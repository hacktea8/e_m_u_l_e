<?php


class Model{
  protected $db;
  
  function __construct(){
    $this->db=new DB_MYSQL();
  }

  function getsubcatelist(){
    $sql=sprintf('SELECT `id`, `pid`, `name`,`url` FROM %s WHERE `flag`=1 AND `pid`>0',$this->db->getTable('emule_cate'));
    $res=$this->db->result_array($sql);
     return $res;
  }

  function geticiliemusubcate(){
    $sql=sprintf('SELECT * FROM %s WHERE `flag`=1 AND `iciliemu` IS NOT NULL AND `pid`>0',$this->db->getTable('emule_cate'));
    $res=$this->db->result_array($sql);
     return $res;
  }

  function geticiliParcate(){
     $sql='SELECT `id`, `pid`, `iciliemu` FROM '.$this->db->getTable('emule_cate').' WHERE  `iciliemu` is not null AND pid=0';
     return $this->db->result_array($sql);
  }

  function updateCateUrlByname($data=array()){
    if(!$data){
        return false;
    }
    $where=isset($data['pid'])?' AND pid='.$data['pid']:'';
    $sql=sprintf('SELECT `id`,`pid` FROM '.$this->db->getTable('emule_cate').' WHERE `name`=\'%s\' %s LIMIT 1',mysql_real_escape_string($data['name']),$where);
    $row=$this->db->row_array($sql);
    if($row['id']){
       unset($data['name']);
       $vals='';
       foreach($data as $k=>$v){
          $vals.=','."`$k`='".mysql_real_escape_string($v)."'";
       }
       $vals=trim($vals,',');
       $sql=sprintf('UPDATE '.$this->db->getTable('emule_cate').' SET %s WHERE `id`=%d LIMIT 1',$vals,$row['id']);
       $this->db->query($sql);
       return $row['id'];
    }
    $keys=$vals='';
    foreach($data as $k=>$v){
       $keys.=','."`$k`";
       $vals.=','."'".mysql_real_escape_string($v)."'";
    }
    $keys=trim($keys,',');
    $vals=trim($vals,',');
    $sql=sprintf('INSERT INTO '.$this->db->getTable('emule_cate').'(%s) VALUES (%s)',$keys,$vals);
    $this->db->query($sql);
    
  }
  
  function addCateByname($cname,$pid=0,$ourl=''){
    if(!$cname)
       return false;

    $sql=sprintf("SELECT `id` FROM `%s` WHERE `name`='%s' AND `pid`=%d LIMIT 1",$this->db->getTable('emule_cate'),mysql_real_escape_string($cname),$pid);
    $row=$this->db->row_array($sql);
    if($row['id']){
       return $row['id'];
    }
    $sql=sprintf("INSERT INTO `%s`(`pid`, `name`, `url`) VALUES (%d,'%s','%s')",$this->db->getTable('emule_cate'),$pid,mysql_real_escape_string($cname),mysql_real_escape_string($ourl));
    $this->db->query($sql);
    $sql=sprintf("SELECT `id` FROM `%s` WHERE `name`='%s' AND `pid`=%d LIMIT 1",$this->db->getTable('emule_cate'),mysql_real_escape_string($cname),$pid);
    $row=$this->db->row_array($sql);
    if($row['id']){
       return $row['id'];
    }
    return false;
  }
  function getCateInfoBypid($pid=0){
     $sql=sprintf("SELECT `id`, `oid`, `pid`, `name`, `url` FROM `%s` WHERE `pid`=%d ",$this->db->getTable('emule_cate'),$pid);
     $res=$this->db->result_array($sql);
     return $res;
  }
  function checkArticleByOid($oid,$utime){
    if(!$oid ||!$utime){
       return false;
    }
    $sql=sprintf("SELECT `id` FROM `%s` WHERE  `oid`=%d AND `utime`=%d LIMIT 1",$this->db->getTable('emule_article'),$oid,$utime);
    $row=$this->db->row_array($sql);
    return $row['id'];
  } 
  function checkArticleByOname($oname){
    if(!$oname){
       return false;
    }
    $sql=sprintf("SELECT `id` FROM `%s` WHERE  `name`='%s' LIMIT 1",$this->db->getTable('emule_article'),mysql_real_escape_string($oname));
    $row=$this->db->row_array($sql);
    return $row['id'];
  } 
  function addArticle($data){
    if(!$data){
       return false;
    }
    $sql=$this->db->insert_string($this->db->getTable('emule_article'),$data);
    $this->db->query($sql);
    return $this->checkArticleByOname($data['name']);
  }
  function updateCateatotal(){
    $sql='SELECT `id` FROM '.$this->db->getTable('emule_cate').' WHERE `pid`!=0';
    $res=$this->db->result_array($sql);
    foreach($res as $val){
       $sql='UPDATE '.$this->db->getTable('emule_cate').' SET `atotal`= (SELECT count(`id`) FROM '.$this->db->getTable('emule_article').' WHERE `cid`='.$val['id'].') WHERE `id`='.$val['id'];
       $this->db->query($sql);
sleep(0.5);
    }
return true;
  }
}

?>
