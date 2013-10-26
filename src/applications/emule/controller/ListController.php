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
   * (non-PHPdoc)
   * @see wekit/wind/web/WindController::run()
   */
  public function run() {
    $page = (int)$this->getInput('page','get');
    if ($page < 1||$page>10) $page = 1;
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
         $this->mem->set('emu-emulelist'.$cid.'-'.$page.$order,$this->emule->emulelist,$this->expirettl['12h']);
         $this->mem->set('emu-listatotal'.$cid,$this->emule->atotal,$this->expirettl['12h']);
         $this->mem->set('emu-listsubcatelist'.$cid,$this->emule->subcatelist,$this->expirettl['12h']);
         $this->mem->set('emu-listpostion'.$cid,$this->emule->postion,$this->expirettl['12h']);
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
    $kw = '';
    foreach($this->emule->postion as $row){
       $title .= $title ? '_' : '';
       $title .= $row['name'];
       $kw .= $row['name'].',';
    }
    $config = Wekit::C('site');
    $keywords = $kw.'电驴资源,电驴资源网,电驴资源网站,电驴资源下载,电驴资源搜索,电驴资源分享,电驴下载,电骡资源,电驴 资源,电骡下载,emule 资源,电驴资源库,电驴网站,电驴搜索,ed2k';
    $des = $title.'_'.$config['info.name'].'是一个综合的电驴资源网站，提供包含电影、电视剧、音乐、游戏、动漫、综艺、软件、资料、图书、教育等栏目电驴资源搜索、电驴下载服务。';
    $seoBo->setCustomSeo($title, $keywords, $des);
    Wekit::setV('seo', $seoBo);
}
	
	/**
	 * 风格预览
	 * Enter description here ...
	 */
	public function demoAction() {
		if ($this->loginUser->uid < 1)  $this->showError('SPACE:user.not.login');
		$styleid = $this->getInput('id');
		$style = Wekit::load('APPCENTER:service.PwStyle')->getStyle($styleid);
		if (!$style) $this->showError('SPACE:fail');
		$this->space->space['space_style'] = $style['alias'];
		$this->setOutput(1, 'page');
		$this->setOutput($this->space, 'space');
		$this->setTemplate('index_run');
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
