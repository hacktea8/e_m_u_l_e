<?php

$APPPATH=dirname(__FILE__).'/';
include_once($APPPATH.'config.php');
include_once($APPPATH.'model.php');

$model=new Model();

$url='http://www.ed2kers.com/图书/生活/435006.html';
$name='《DK目击者旅游指南：英国》全彩版[PDF]';
$ainfo=array('url'=>$url,'name'=>$name);
getinfodetail($ainfo);

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
  $psize=1;
  for($i=1;$i<=$psize;$i++){
    $html=getHtml($cateurl);
    preg_match_all($listPattern,$html,$matchs,PREG_SET_ORDER);
    foreach($matchs as $list){
      $oid=preg_replace('#[^\d]+#','',$list[1]);
      $utime=strtotime(trim($list[4]));
      $aid=$model->checkArticleByOid($oid,$utime);
      if($aid){
         echo "$aid已存在未更新!\r\n";
         continue;
      }
      $purl=$_root.$list[1];
      $ptime=strtotime(trim($list[3]));
      $ainfo=array('url'=>$purl,'name'=>trim($list[2]),'ptime'=>$ptime,'utime'=>$utime);
      getinfodetail($ainfo);
    }
    if($psize==1){
       preg_match($pagesizePattern,$html,$matchs);
       $psize=isset($matches[1])?$matches[1]:1;
       
    }
  }
}

function getinfodetail(&$data){
  global $model,$bookimg,$bookdownPattern,$strreplace,$pregreplace,$bookdesPattern;
  
  $html=getHtml($data['url']);
  //kw
  preg_match('#<meta name="keywords" content="(.+)" />#U',$html,$match);
  $$data['ketwords']=$match[1];
  //description
  preg_match('#<meta name="description" content="(.+)" />#U',$html,$match);
  $data['description']=$match[1];
  //
  preg_match($bookimg,$html,$match);
  $data['thum']=$match[1];
  //
  preg_match($bookdownPattern,$html,$match);
  $data['downurl']=$match[1];
  foreach($strreplace as $val){
    $data['downurl']=str_replace($val['from'],$val['to'],$data['downurl']);
  }
  foreach($pregreplace as $val){
    $data['downurl']=preg_replace($val['from'],$val['to'],$data['downurl']);
  }
  $data['downurl']=trim($data['downurl']);
  //
  preg_match($bookdesPattern,$html,$match);
  $data['intro']=$match[1];
  foreach($strreplace as $val){
    $data['intro']=str_replace($val['from'],$val['to'],$data['intro']);
  }
  foreach($pregreplace as $val){
    $data['intro']=preg_replace($val['from'],$val['to'],$data['intro']);
  }
  $data['intro']=trim($data['intro']);
  if(!$data['name'] || !$data['intro']){
     echo "抓取失败 $ainfo[url] \r\n";
     return false;
  }
  $data['intro']='<table>'.$data['intro'].'</table>';
  echo '<pre>';var_dump($data);exit;
  $aid=$mode->addArticle($data);
  if(!$aid){
    echo "添加失败! $ainfo[url] \r\n";
    return false;
  }
  echo "添加成功! $aid \r\n";
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
