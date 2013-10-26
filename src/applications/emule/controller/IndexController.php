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

class IndexController extends EmuleBaseController {
  /**
   * (non-PHPdoc)
   * @see wekit/wind/web/WindController::run()
   */
  public function run() {
    $config = Wekit::C('site');
    //echo '<pre>';var_dump($config);exit;
    $this->setOutput('index', 'src');
    $this->emule->emuleIndex=$this->mem->get('emu-emuleIndexinfo');
    $this->setOutput($this->emule->emuleIndex,'emuleIndex');
//echo '<pre>';var_dump($this->emule->emuleIndex);exit;
// seo设置

    Wind::import('SRV:seo.bo.PwSeoBo');
    $seoBo = PwSeoBo::getInstance();
    $lang = Wind::getComponent('i18n');
    $title = $config["info.name"].'_让分享继续';
    $keywords = $config["info.name"].'电驴资源,电驴资源网,电驴资源网站,电驴资源下载,电驴资源搜索,电驴资源分享,电驴下载,电骡资源,电驴 资源,电骡下载,emule 资源,电驴资源库,电驴网站,电驴搜索,ed2k';
    $des = $config["info.name"].'是一个综合的电驴资源网站，提供包含电影、电视剧、音乐、游戏、动漫、综艺、软件、资料、图书、教育等栏目电驴资源搜索、电驴下载服务。';
    $seoBo->setCustomSeo($title, $keywords, $des);
    Wekit::setV('seo', $seoBo);
  }

  /*
   *
   */
  function htmlAction(){
     
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
