<?php

define('WEKIT_VERSION',1);
$root=dirname(__FILE__).'/';
//echo $root;exit;
require_once($root.'../grab/db.class.php');
require_once($root.'../../src/library/base/PwBaseRediscache.php');

$model=new model();
//$model->getIndexData();

class model{
  protected $db;
  public $emuleIndex=array();
  protected $mem;

  function __construct(){
    $this->db=new DB_MYSQL();
    $this->mem=new PwBaseRediscache();

  }

}
