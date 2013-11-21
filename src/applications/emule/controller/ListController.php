<?php
Wind::import('APPS:emule.controller.EmuleBaseController');
/**
 * 新鲜事
 * 
 * @version $Id: IndexController.php 25054 2013-03-01 03:14:54Z jieyin $
 * @author $Author: jieyin $ Foxsee@aliyun.com
 * @copyright ©2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @package space
 */

class ListController extends EmuleBaseController {

  /**
   *
   *
   */
  public  function beforeAction($handlerAdapter) {
          parent::beforeAction($handlerAdapter);
  }	
  /**
   * (non-PHPdoc)
   * @see wekit/wind/web/WindController::run()
   */
  public function run() {
    $page = (int)$this->getInput('page','get');
    //if ($page < 1||$page>10) $page = 1;
    $this->setOutput(25, 'perpage');
    $this->setOutput($page, 'page');
    $order='';
    $cid=intval($this->getInput('cid','get')); 
    if($page>0 &&$page<11){           
       $this->emule->emulelist=$this->mem->get('emu-emulelist'.$cid.'-'.$page.$order);
       $this->emule->atotal=$this->mem->get('emu-listatotal'.$cid);
       $this->emule->subcatelist=$this->mem->get('emu-listsubcatelist'.$cid);
       $this->emule->postion=$this->mem->get('emu-listpostion'.$cid);
       if(empty($this->emule->emulelist)){
//die($this->expirettl['12h'].'empty');
         $this->emule->getArticleListByCid($cid,$order,$page);
//echo '<pre>';var_dump($this->emule->hotTopic);exit;
         $this->mem->set('emu-emulelist'.$cid.'-'.$page.$order,$this->emule->emulelist,$this->expirettl['7d']);
         $this->mem->set('emu-listatotal'.$cid,$this->emule->atotal,$this->expirettl['7d']);
         $this->mem->set('emu-listsubcatelist'.$cid,$this->emule->subcatelist,$this->expirettl['7d']);
         $this->mem->set('emu-listpostion'.$cid,$this->emule->postion,$this->expirettl['7d']);
       }
    }else{
       $this->emule->getArticleListByCid($cid,$order,$page);
    }
    $this->setOutput($this->emule->emulelist, 'infolist');
    $this->setOutput($this->emule->atotal, 'listcount');
    $this->setOutput($this->emule->subcatelist, 'subcatelist');
    $this->setOutput($cid, 'cid');
    //echo '<pre>',var_dump($this->emule->rootCate);exit;
    // seo设置
    Wind::import('SRV:seo.bo.PwSeoBo');
    $seoBo = PwSeoBo::getInstance();
    $lang = Wind::getComponent('i18n');
    $title = '';
    $kw = $this->siteinfo['info.name'].',';
    foreach($this->emule->postion as $row){
       $title .= $title ? '_' : '';
       $title .= $row['name'];
       $kw .= $row['name'].',';
    }
    $keywords = $kw.$this->keywords;
    $des = $title.'_'.$this->siteinfo['info.name'].$this->description;
    $seoBo->setCustomSeo($title, $keywords, $des);
    Wekit::setV('seo', $seoBo);
}
	
	/**
	 * 搜索页面
	 * Enter description here ...
	 */
	public function searchAction() {
		$q = $this->getInput('q');
                $type = $this->getInput('type');
                $page = intval($this->getInput('page'));
                $page = $page < 1 ? 1: $page;
                $list = array();
                if($q){
                  $param = array('kw' => URLENCODE($q), 'page' => $page, 'page_size' => 20);
                  if(1 == $type){
                    $param[] = '';
                  }elseif(2 == $type){
                    $param[] = '';
                  }
                  Wind::import('LIB:base.AliyunSearchApi.php');
                  $search = new AliyunSearchApi();
                  $search->getsearch($list, $type, $param); 
                }
                $hot_search = array();
                $recommen_topic = array();
                $recommen_topic[1] = array();
                $recommen_topic[2] = array();
                $hot_topic = array();
                $hot_topic['hit'] = array();
                $hot_topic['focus'] = array();
//var_dump($list);exit; 
/*
["searchtime"]=> float(0.043) ["total"]=> int(98) ["num"]=> int(20) ["viewtotal"]=> int(98) } ["status"]=> string(2) "OK" }
*/
		$this->setOutput($list['result'], 'searchlist');
		$this->setOutput(URLENCODE($q), 'q');
		$this->setOutput(20, 'perpage');
		$this->setOutput($page, 'page');
		$this->setOutput($list['result']['viewtotal'], 'listcount');
		$this->setOutput($hot_search, 'hot_search');
		$this->setOutput($recommen_topic, 'recommen_topic');
		$this->setOutput($hot_topic, 'hot_topic');
		$this->setTemplate('list_search');
	}
	
	
	/**
	 * 回复
	 * 
	 */
	public function replyAction() {
		$id = (int)$this->getInput('id');
		Wind::import('LIB:ubb.PwSimpleUbbCode');
		Wind::import('LIB:ubb.config.PwUbbCodeConvertThread');
		Wind::import('SRV:attention.srv.PwFreshReplyList');
		$reply = new PwFreshReplyList($id);
		$fresh = $reply->getData();
		$replies = $reply->getReplies(7);
		$replies = Wekit::load('forum.srv.PwThreadService')->displayReplylist($replies);
		
		$count = count($replies);
		if ($count > 6) {
			$replies = array_slice($replies, 0, 6, true);
		}
		$this->setOutput($count, 'count');
		$this->setOutPut($replies, 'replies');
		$this->setOutPut($fresh, 'fresh');
	}
	
	/**
	 * 阅读更多
	 * 
	 */
	public function readAction() {
		Wind::import('SRV:forum.bo.PwThreadBo');
		$id = (int)$this->getInput('id');
		$fresh = Wekit::load('attention.PwFresh')->getFresh($id);
		if ($fresh['type'] == 1) {
			$thread = new PwThreadBo($fresh['src_id']);
			$array = $thread->info;
			$array['pid'] = 0;
		} else {
			$array = Wekit::load('forum.PwThread')->getPost($fresh['src_id']);
			$thread = new PwThreadBo($array['tid']);
		}
		Wind::import('LIB:ubb.PwUbbCode');
		Wind::import('LIB:ubb.config.PwUbbCodeConvertThread');
		$array['content'] = WindSecurity::escapeHTML($array['content']);
		$array['content'] = str_replace("\n", '<br />', $array['content']);
		$array['useubb'] && $array['content'] = PwUbbCode::convert($array['content'], new PwUbbCodeConvertThread($thread, $array, $this->loginUser));

		echo $array['content'];
		$this->setTemplate('');
	}
	
	public function freshAction() {
		list($id, $weiboid) = $this->getInput(array('id', 'weiboid'));
		$page = intval($this->getInput('page'));
		if ($weiboid) {
			Wind::import('SRV:attention.srv.dataSource.PwFetchFreshByTypeAndSrcId');
			$dataSource = new PwFetchFreshByTypeAndSrcId(3, array($weiboid));
		} else {
			Wind::import('SRV:attention.srv.dataSource.PwGetFreshById');
			$dataSource = new PwGetFreshById($id);
		}

		Wind::import('SRV:attention.srv.PwFreshDisplay');
		$freshDisplay = new PwFreshDisplay($dataSource);
		if (!$fresh = $freshDisplay->gather()) {
			$this->showError('fresh.exists.not');
		}
		Wind::import('LIB:ubb.PwSimpleUbbCode');
		Wind::import('LIB:ubb.config.PwUbbCodeConvertThread');
		Wind::import('SRV:attention.srv.PwFreshReplyList');

		$fresh = current($fresh);
		$id = $fresh['id'];

		$page < 1 && $page = 1;
		$perpage = 10;
		list($offset, $limit) = Pw::page2limit($page, $perpage);
		$reply = new PwFreshReplyList($id);
		$replies = $reply->getReplies($limit, $offset);
		$replies = Wekit::load('forum.srv.PwThreadService')->displayReplylist($replies);

		$this->setOutput($fresh, 'fresh');
		$this->setOutput($replies, 'replies');
		$this->setOutput($id, 'id');
		$this->setOutput($fresh['created_userid'], 'uid');

		$this->setOutput($page, 'page');
		$this->setOutput($perpage, 'perpage');
		$this->setOutput($fresh['replies'], 'count');
	}

}
