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

class AjaxController extends EmuleBaseController {
        /**
         *
         *
         */
        public function beforeAction($handlerAdapter) {
                parent::beforeAction($handlerAdapter);
                define('ROOTPATH', dirname(dirname(dirname(dirname(dirname(__FILE__))))).'/'); 
        }
	
	/**
	 * (non-PHPdoc)
	 * @see wekit/wind/web/WindController::run()
	 */
	public function run() {
                $this->forwardRedirect('/');
                $this->setOutput($this->emule->emule, 'info');
                $this->postion=$this->emule->emule['cate'];

	}
	
	/**
	 * 提交分享URL
	 * Enter description here ...
	 */
	public function shareurlAction() {
                $url = $this->getInput('url');
                $url = urlDecode($url);
echo ROOTPATH;
		die(json_encode(1));
	}
	
	
	/**
	 * 编辑
	 * 
	 */
	public function editAction() {
                 
		$this->setTemplate('topic_post');
	}
        /**
         *
         *
         */
        public function setpostAction(){
                header('Location: /index.php?m=emule&c=topic&a=run&aid='.$aid);
        }	
	/**
	 * 阅读更多
	 * 
	 */
	public function readAction() {
		Wind::import('SRV:forum.bo.PwThreadBo');
	}
	
	public function freshAction() {
		$this->setOutput($fresh['replies'], 'count');
	}

}
