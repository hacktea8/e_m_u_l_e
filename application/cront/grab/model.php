<?php

include_once($APPPATH.'db.class.php');

class Model{
  protected $db;
  
  function __construct(){
    $this->db=new DB_MYSQL();
  }
  
  function addCateByname($cname,$pid=0,$ourl=''){
    if(!$cname)
       return false;

    $sql=sprintf('',mysql_real_escape_string($cname),$pid,mysql_real_escape_string($ourl));
    
  }
  
}

?>
