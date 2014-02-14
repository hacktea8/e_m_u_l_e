<?php
//ini_set('display_errors',1);
//error_reporting(E_ALL);
Wind::import('APPS:emule.controller.EmuleBaseController');
/**
 * 资源详情页面
 * 
 * @version $Id: IndexController.php 25054 2013-03-01 03:14:54Z jieyin $
 * @author $Author: jieyin $ Foxsee@aliyun.com
 * @copyright ©2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @package space
 */

class TopicController extends EmuleBaseController {
        public $imguploadapiurl = 'http://img.hacktea8.com/imgapi/upload/?seq=';
        /**
         *
         *
         */
        public function beforeAction($handlerAdapter) {
                parent::beforeAction($handlerAdapter);
                $aid = intval($this->getInput('aid','GET'));
                if(in_array($handlerAdapter->action,array('run','edit')) &&$aid<1){
                    $this->showError('EMULE:emule.not.exist');
                }
//var_dump($this->loginUser->isadmin);exit;
                if($handlerAdapter->action !== 'run'){
                   if($this->loginUser->uid < 1){
                      $this->showError('SPACE:user.not.login');
                   }
                }
                //修改帖子
                if($handlerAdapter->action == 'edit'){
                   $this->emule->getEmuleTopicByAid($aid,$this->loginUser->uid,$this->loginUser->isadmin);
                }
                //查看帖子
                if($handlerAdapter->action == 'run'){
                   $this->emule->getEmuleTopicByAid($aid);
                }
                if(in_array($handlerAdapter->action,array('run','edit'))){
                   if(!isset($this->emule->emule['id'])){
                       $this->showError('EMULE:emule.not.exist');
                   }
                }
		$this->setOutput($this->showimgapi, 'showimgapi');
        }
	
	/**
	 * (non-PHPdoc)
	 * @see wekit/wind/web/WindController::run()
	 */
	public function run() {
//echo 333;exit;
		// seo设置

		Wind::import('SRV:seo.bo.PwSeoBo');
		$seoBo = PwSeoBo::getInstance();
		//加载语言包 $lang = Wind::getComponent('i18n');
		$des = Pw::substrs(trim(preg_replace('#\s+#',' ',strip_tags($this->emule->emule['intro']))), 100, 0, false);
		$seoBo->setCustomSeo($this->emule->emule['name'], $this->emule->emule['name'].','.$this->siteinfo['info.name'].','.$this->keywords, $des);
		Wekit::setV('seo', $seoBo);
                $this->emule->emule['ptime']=date('Y:m:d',$this->emule->emule['ptime']);
                $this->emule->emule['utime']=date('Y/m/d',$this->emule->emule['utime']);
                $this->setOutput($this->emule->emule, 'info');
                $this->postion=$this->emule->emule['cate'];
                $ip = Wind::getComponent('request')->getClientIp();
                $key = sprintf('emuhitslog:%s:%d',$ip,$this->emule->emule['id']);
                if(!$this->redis->exists($key)){
                   $this->redis->set($key, 1, $this->expirettl['6h']);
                }
	}
	
	/**
	 * 发帖
	 * Enter description here ...
	 */
	public function postAction() {
		if ($this->loginUser->uid < 1)  $this->showError('SPACE:user.not.login');
		$styleid = $this->getInput('fid');
		$this->setOutput(1, 'page');
		$this->setOutput('发表主题', 'headguide');
		$this->setOutput('post', 'action');
		$this->setOutput('setpost', 'do');
		$this->setOutput($this->space, 'space');
		$this->setOutput($this->imguploadapiurl, 'imguploadapiurl');
		$this->setTemplate('topic_post');
	}
	
	
	/**
	 * 编辑
	 * 
	 */
	public function editAction() {
                 
		$this->setOutPut($this->emule->emule, 'info');
		$this->setOutput('编辑主题', 'headguide');
		$this->setOutput('post', 'action');
		$this->setOutput('setpost', 'do');
		$this->setOutput($this->imguploadapiurl, 'imguploadapiurl');
		$this->setTemplate('topic_post');
	}
        /**
         *
         *
         */
        public function setpostAction(){
                $aid = (int)$this->getInput('aid','POST');
                $name = $this->getInput('name','POST');
                $intro = $this->getInput('intro','POST');
                $thum = $this->getInput('thum','POST');
                $downurl = $this->getInput('downurl','POST');
                $vipdwurl = $this->getInput('vipdwurl','POST');
                $keyword = $this->getInput('keyword','POST');
                $info = compact('name','thum','downurl','vipdwurl','intro','keyword');
echo '<pre>',$thum,$_POST['name'];var_dump($info);exit;
                if($aid){
                   $info['aid'] = $aid;
                   $this->emule->setEmuleTopicByAid($this->loginUser->uid,$info,$this->loginUser->isadmin); 
                }else{
                   $aid = $this->emule->addEmuleTopicByInfo($info);
                }
                header('Location: /index.php?m=emule&c=topic&a=run&aid='.$aid);
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
