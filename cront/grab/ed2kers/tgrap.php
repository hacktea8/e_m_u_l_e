<?php

$APPPATH=dirname(__FILE__).'/';
$psize=10;
include_once($APPPATH.'../function.php');
include_once($APPPATH.'config.php');

/*
$url='http://www.ed2kers.com/图书/生活/435006.html';
$name='《DK目击者旅游指南：英国》全彩版[PDF]';
$ainfo=array('url'=>$url,'name'=>$name);
getinfodetail($ainfo);

*/

/*=========== Update Cate Article Total =========*/
updateCateatotal();//exit;
/*=========== Get All Cate Info =================*/

//getAllcate();

/*============ Get Cate article =================*/

$lastgrab=basename(__FILE__);
$path=$APPPATH.'config/';

//$rootcate=$model->getCateInfoBypid(0);
getsubcatelist($subcate);
$i=0;
$num=11;
foreach($subcate as $_cate){
$i++;
//30
//2,5,8,11,14,17,20,23,26 is ok
if($i>$num){
break;
}
if($i!=$num){
continue;
}
   $lastgrab=$path.$_cate['id'].'_'.$lastgrab;
//   getCatearticle($_cate['id']);
   getSubCatearticle($_cate);
echo "cate id $_cate[id] 已抓取完毕!\r\n";
sleep(10);
}



?>
