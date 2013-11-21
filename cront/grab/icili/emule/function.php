<?php

include_once($APPPATH.'../db.class.php');
include_once($APPPATH.'../model.php');

$model=new Model();

/*
获取配对的标签的内容
*/
function getTagpair(&$str,&$string,$head,$end,$same){
  $str='';
  $start=stripos($string, $head);
  if($start===false){
    return false;
  }
//第一个包含head标签位置的剩下字符串
  $string=substr($string,$start);
//第一次结尾的end标签的位置
  $start=stripos($string, $end)+strlen($end);
  if($start===false){
    return false;
  }
  $str=substr($string,0,$start);
  $others=substr($string, $start+1);
//开始标签出现的次数
  $count_head=substr_count($str,$same);
//结束标签出息的次数
  $count_tail=substr_count($str, $end);
//echo $others,exit;
  while($count_head!=$count_tail &&$count_tail){
    //$start=stripos($others, $same);
    $length=stripos($others, $end)+strlen($end);
    $str.=substr($others, 0,$length);
    $others=substr($others, $length);
    $count_head=substr_count($str,$same);
    $count_tail=substr_count($str, $end);	
  }
}

function updateCateatotal(){
 global $model;
  return $model->updateCateatotal();
}

function getsubcatelist(&$subcate){
  global $model;
  $subcate=$model->geticiliemusubcate();
}


function getlastgrabinfo($mode=1,$config=array()){
  global $lastgrab,$cateid,$pageno;
  if($mode){
     if(!file_exists($lastgrab)){
        return false;
     }
     include($lastgrab);
     return true;
  }
  $text="<?php\r\n";
  $text.="\$cateid=$config[cateid];\r\n";
  $text.="\$pageno=$config[pageno];\r\n";
  
  file_put_contents($lastgrab,$text);
  return true;
}

function getCatearticle($pid=0){
  if(!$pid){
    return false;
  }
  global $model,$_root,$cid;
  $flag=getlastgrabinfo();
  
  $cateList=$model->getCateInfoBypid($pid);
  foreach($cateList as $cate){
    if($cate['id']!=$cateid &&$flag){
         continue;
    }
    if($cate['id']==$cateid){
       $flag=false;
    }
    $cateurl=$_root.$cate['url'];
    $cid=$cate['id'];
    getinfolist($cateurl);
sleep(30);
  }
}

function getSubCatearticle($cate){
   global $model,$_root,$cid;
   $cateurl=$_root.$cate['url'];
   $cid=$cate['id'];
   getinfolist($cateurl);
}

function getAllcate(){
  global $model,$_root,$subcatelistPattern,$catelistPattern;
  $html=getHtml($_root);
  preg_match_all($catelistPattern,$html,$match,PREG_SET_ORDER);
  $pcate=$match;
  foreach($pcate as $pc){
    $pid=$model->addCateByname(trim($pc[2]),0,trim($pc[1]));
    if(!$pid){
      continue;
    }
    echo "Parent Cate id $pid\r\n";
    $html=getHtml($_root.$pc[1]);
    preg_match_all($subcatelistPattern,$html,$match,PREG_SET_ORDER);
    foreach($match as $cate){
      $sid=$model->addCateByname(trim($cate[2]),$pid,trim($cate[1]));
      echo "cate id $sid\r\n";
    }
sleep(2);
  }
  
}
function getAllParcateicili($url){
  global $model,$_root;
  $url=$_root.$url;
  $html=getHtml($url);
  preg_match_all('#<a class="menu" href="(.+)"><h2>(.+)</h2> （\d+）</a>#Us',$html,$match,PREG_SET_ORDER);
  $data=array();
  foreach($match as $val){
     $data['name']=trim($val[2]);
     $data['iciliemu']=trim($val[1]);
     $model->updateCateUrlByname($data);
  } 

//  echo '<pre>';var_dump($match);exit;
}
function getAllSubcateicili(){
  global $model,$_root;
  $rootcate=$model->geticiliParcate();
  $data=array();
  foreach($rootcate as $val){
     $url=$_root.$val['iciliemu'];
     $html=getHtml($url);
     preg_match_all('#<li>\s*<a class="menu" href="(.+)"><h3>(.+)</h3>（\d+）</a></li>#Us',$html,$match,PREG_SET_ORDER);
     foreach($match as $v){
        $data['name']=trim($v[2]);
        $data['iciliemu']=trim($v[1]);
        $data['pid']=$val['id'];
        $model->updateCateUrlByname($data);
       // echo '<pre>';var_dump($match);exit;
     }
  }
}
function getinfolist(&$cateurl){
  global $model,$psize,$pageno,$action,$listinfoPattern,$_root,$listPattern,$listPatterntwo,$pagesizePattern,$cid;
  $psize=isset($psize)?$psize:1;
  $flag=getlastgrabinfo();
  $getpsize=true;

  for($i=1;$i<=$psize;$i++){
    if($flag){
       $i=$psize=$pageno;
       $flag=false;
    }
//通过 atotal计算i的值
    $html=getHtml($cateurl."/{$i}");

    preg_match_all($listPattern,$html,$matchs,PREG_SET_ORDER);
//echo '<pre>';var_dump($matchs);exit;
    if(empty($matchs)){
       preg_match_all($listPatterntwo,$html,$matchs,PREG_SET_ORDER);
      // echo '<pre>';var_dump($matchs);exit;
    }
    if(empty($matchs)){
      die('Cate list Failed '.$cateurl."/{$i}\r\n");
    }
//匹配日期
      preg_match_all($listinfoPattern,$html,$match,PREG_SET_ORDER);
//      echo '<pre>';var_dump($match);exit;

    foreach($matchs as $ky=>$list){
      $oid=preg_replace('#[^\d]+#','',$list[1]);
      $oname=trim($list[3]);

//先判断名字是否按月份更新 《《Sweet》日本时尚杂志甜美性感系列》(Sweet)更新至2013年11月号
      if(false != $pos = strpos($oname,'更新至')){
         $title = substr($oname,$pos);
         preg_match('#《《.+》.+》#Uis',$oname,$match);
         $oname = isset($match[0]) ? $match[0] : substr($oname,0,$pos);
      }

//在判断是否更新
      $aid=$model->checkArticleByOname($oname);
      if($aid){
         echo "{$aid}已存在未更新!\r\n";
         continue;
      }

      //$thum=trim($list[2]);
      $thum=$oid;
      $purl=$_root.$list[1];
 
      $utime=strtotime(trim($match[$ky][2]));
      $ptime=strtotime(trim($match[$ky][1]));
      $ainfo=array('ourl'=>$oid,'name'=>$oname,'utime'=>$utime,'ptime'=>$ptime,'thum'=>$thum,'oid'=>$oid,'cid'=>$cid);
//var_dump($ainfo);exit;
      getinfodetail($ainfo);
sleep(10);
    }


//test data
//if($i>3)
//break;
    $config=array('cateid'=>$cid,'pageno'=>$i);
    getlastgrabinfo(0,$config);

    if($getpsize){
       preg_match($pagesizePattern,$html,$matches);
       $psize=isset($matches[1])?$matches[1]:1;
       $getpsize=false;
//echo $cateurl,"\n",$psize,"\n",var_dump($matches);exit;
    }
sleep(30);
  }
}

function getinfodetail(&$data){
  global $model,$cid,$bookimg,$detailPattern,$bookdownPattern,$strreplace,$str,$head,$end,$same,$pregreplace,$bookdesPattern;
  
  $html=getHtml($data['ourl']);
  if(!$html){
    echo "获取html失败";exit;
  }
  //kw
 // preg_match('#<meta name="keywords" content="(.+)" />#U',$html,$match);
  $data['keyword']='';//mysql_real_escape_string(trim($match[1]));
  //description
 // preg_match('#<meta name="description" content="(.+)" />#U',$html,$match);
  $data['description']= '';//mysql_real_escape_string(trim($match[1]));
  //
//  preg_match($bookimg,$html,$match);
  $data['thum']=mysql_real_escape_string($data['thum']);
  /*
  preg_match($detailPattern,$html,$match);
  $data['ptime']=strtotime(trim($match[1]));
  $data['utime']=strtotime(trim($match[2]));
//  var_dump($match);exit;
*/  
    preg_match($bookdownPattern,$html,$str);
//  getTagpair($str,$html,$head,$end,$same);
  $data['downurl']=$str[0];
  foreach($strreplace as $val){
    $data['downurl']=str_replace($val['from'],$val['to'],$data['downurl']);
  }
  foreach($pregreplace as $val){
    $data['downurl']=preg_replace($val['from'],$val['to'],$data['downurl']);
  }
  $data['downurl']=mysql_real_escape_string(trim($data['downurl']));
  //
//  preg_match($bookdesPattern,$html,$match);
  getTagpair($str,$html,$head,$end,$same);
  $data['intro']=$str;
//echo $str;exit;
  foreach($strreplace as $val){
    $data['intro']=str_replace($val['from'],$val['to'],$data['intro']);
  }
  foreach($pregreplace as $val){
    $data['intro']=preg_replace($val['from'],$val['to'],$data['intro']);
  }
  $data['intro']=mysql_real_escape_string(trim($data['intro']));
  if(!$data['name'] || !$data['downurl']){
     echo "抓取失败 $data[ourl] \r\n";
     return false;
  }
 // $data['intro']=mysql_real_escape_string($data['intro']);
  echo '<pre>';var_dump($data);exit;
  $aid=$model->addArticle($data);
  if(!$aid){
    echo "添加失败! $data[ourl] \r\n";
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
    echo 'error',curl_error($curl),"\r\n";
    return false;
  }
  curl_close($curl);
  return $tmpInfo;
}

?>
