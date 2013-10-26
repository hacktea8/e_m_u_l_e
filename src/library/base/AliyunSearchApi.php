<?php
$currentpath = dirname(__FILE__);
require_once($currentpath.'/CloudSearchApi.php');
require_once($currentpath.'/CloudSearchIndex.php');
require_once($currentpath.'/HelperError.php');
define('APIROOT','http://css.aliyun.com/v1/api');
define('CLIENT_ID','6100084360938795');
define('CLIENT_SECRET','2abc67908c9c062d6da13ca10fa8ccef');

class AliyunSearchApi{
  public $api;
  protected $msg;

  public function __construct(){
    if($this->api){
      return false;
    }
    $this->api=new CloudSearchApi(APIROOT, CLIENT_ID, CLIENT_SECRET);
  }

  public function createindex($indexName,$tpl){
    if (!$this->api->exists($indexName)){
      $this->api->createIndex($indexName, $tpl); //指定模版为news
    }
    if (!$this->api->exists($indexName)){
      $this->msg='create index failed!';
      return false;
    }
    return true;
  }
  public function deleteindex(){
    $this->api->deleteIndex($indexName);
    return true;
  }
/*
                   "id":"1",
                   "title":"阿里云隆重推出开放搜索",
                   "body":"广大中小企业都有各种结构化的数据需要进行检索，
                   目前一般采用数据库本身提供的搜索功能或者利用open source的搜索软件搭建。",
                   "display_text":"open search",
                   "author":"阿里云",
                   "update_timestamp":"1345448016",
                   "type_id":"1",
                   "url":"http://www.aliyun.com",
                   "cat_id":[1, 2],
                   "grade":"10",
                   "source":"阿里云云搜索",
                   "comment_count":"1234",
                   "tag":{"搜索":10,"阿里云":2,"云搜索":5,"开放搜索":8},
                   "create_timestamp":"1345448016",
                   "focus_count":"8888",
                   "boost":"1",
                   "integer_1":"100",
                   "hit_num":"88888"
*/
  public function adddocument(&$itemsArr, $indexName = 'emu_hacktea8'){
    $_itemsArr=array();
    foreach($itemsArr as $val){
      array_push($_itemsArr,array("cmd"=>"add","fields" =>$val));
    }
//var_dump($_itemsArr);exit;
    $index = $this->api->getIndex($indexName);
    $index->addDocuments($_itemsArr);
    return "添加成功，系统需要几分钟来处理数据，请耐心等待！";
  }
  public function deletedocument($indexName,$docId){
    $index = $this->api->getIndex($indexName);
    $index->deleteDocument($docId);
    return true;
  }
  public function getdocnum($indexName){
    $index = $api->getIndex($indexName);
    return $index->getTotalDocCount();
  }
  public function geterrlog($indexName){
    $index = $this->api->getIndex($indexName);
    return  $rs = $index->getErrorMessage(1, 20);
    $list = $rs["result"];

    return $rs["result"]["items"];
  }
  public function getlistindexs(){
    return $rs = $this->api->listIndexes();
  }
  public function getsearch($type=0,&$result,$param){
    $index = $api->getIndex($indexName);
    switch($type){
       case 0:$result=$index->search('q='.$param['kw']);
       break;
/*
$index->search(
                     'cq=title:战',
                     1,
                     6,
                     array("-create_timestamp"),
                    "cat_id=3 AND hit_num>8000",
                    array("facet_key"=>"type_id",
               "facet_fun"=>"sum(hit_num)#max(hit_num)#min(hit_num)#count()"),
                    "title;body");
*/
       case 1:$result=$index->search(
                     'cq='.$param['kw'],
                     1,
                     6,
                     $param['sort'],
                     $param['filter'],
                     $param['facet_key'],
                     $param['facet_fun'],
                     $param['fetch_fields']);
       break;
       case 2:$result=$api->search('q='.$param['kw'],$param['indexArr'],
              '2',10,null,"","");
       break;
       default:
       
    }
  }
  public function printmsg(){
    return $this->msg;
  }
}

?>
