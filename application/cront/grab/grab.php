<?php

$APPPATH='/Users/jason/project/picture/grabroom/emule/';
include_once($APPPATH.'config.php');
include_once($APPPATH.'model.php');

$model=new Model();

$url='http://www.ed2kers.com/%E5%9B%BE%E4%B9%A6/%E7%94%9F%E6%B4%BB';
getinfolist($url);


function getAllcate(){
  global $model,$_root,$subcatelistPattern,$catelistPattern;
  $html=getHtml($_root);
  preg_match_all($catelistPattern,$html,$match,PREG_SET_ORDER);
  $pcate=$match;
  foreach($pcate as $pc){
    //$pid=$model->addCateByname($pc[2],0,$pc[1]);
    $html=getHtml($_root.$pc[1]);
    preg_match_all($subcatelistPattern,$html,$match,PREG_SET_ORDER);
    foreach($match as $cate){
//      $sid=$model->addCateByname($cate[2],$pid,$cate[1]);
      echo "cate id $sid\r\n";
    }

  }
  
}

function getinfolist(&$cateurl){
  global $model,$action,$_root,$listPattern,$pagesizePattern;
  $html=getHtml($cateurl);
  preg_match_all($listPattern,$html,$match,PREG_SET_ORDER);
  
  var_dump($match);exit;
}

function getHtml($url){
  $curl = curl_init();
  curl_setopt($curl, CURLOPT_URL, $url);
  curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.3 (Windows; U; Windows NT 5.3; zh-TW; rv:1.9.3.25) Gecko/20110419 Firefox/3.7.12');
  // curl_setopt($curl, CURLOPT_PROXY ,"http://189.89.170.182:8080");
  curl_setopt($curl,CURLOPT_FOLLOWLOCATION,true);
  curl_setopt($curl, CURLOPT_AUTOREFERER, 1);
  curl_setopt($curl, CURLOPT_HEADER, 0);
  curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
  $tmpInfo = curl_exec($curl);
  if(curl_errno($curl)){
    echo 'error';
    return false;
  }
  curl_close($curl);
  return $tmpInfo;
}

?>
