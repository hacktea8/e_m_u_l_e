<?php
error_reporting(E_ERROR | E_PARSE);
$mode=isset($_GET['m'])?$_GET['m']:'';
$allowMode=array('emule','u','space');
if(!in_array($mode,$allowMode)){
   header('Location: /index.php?m=emule&c=index&a=run');
}
require './src/wekit.php';
Wekit::run('phpwind');
