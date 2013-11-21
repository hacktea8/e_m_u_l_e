<?php

$APPPATH=dirname(__FILE__).'/../';
$psize=10;
include_once($APPPATH.'emule/function.php');
include_once($APPPATH.'emule/config.php');



/*=========== Update Cate Article Total =========*/
//updateCateatotal();//exit;
/*=========== Get All Cate Info =================*/


/*============ Get Cate article =================*/
$lastgrab=basename(__FILE__);
$path=$APPPATH.'config/';

$subcate = '';
getsubcatelist($subcate);
//var_dump($subcate);exit;
$i=0;
$num=1;
foreach($subcate as $_cate){
$i++;
//1,4,7,10,13,16,19,22,25, isok
if($i>$num){
  break;
}
if($i < $num){
continue;
}
   $lastgrab=$path.$_cate['id'].'_'.$lastgrab;
   //getCatearticle($_cate['id']);
   $_cate['url']=$_cate['iciliemu'];
   getSubCatearticle($_cate);
echo "cate id $_cate[id] 已抓取完毕!\r\n";
sleep(10);
}



?>
