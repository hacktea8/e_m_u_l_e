<?php
defined('WEKIT_VERSION') || exit('Forbidden');

/**
 * controller 基类
 *
 * @author Jianmin Chen <sky_hold@163.com>
 * @license http://www.phpwind.com
 * @version $Id: PwBaseController.php 29863 2013-07-02 03:28:46Z gao.wanggao $
 * @package lib.base.controller
 */
class PwBaseController extends WindController {

	/**
	 * 当前用户信息
	 *
	 * @var PwUserBo $loginUser
	 */
	protected $loginUser;
	protected $_m;
	protected $_c;
	protected $_a;
	protected $_mc;
	protected $_mca;
	
	/*
	 * (non-PHPdoc) @see WindSimpleController::beforeAction()
	 */
	public function beforeAction($handlerAdapter) {

		$this->_m = $handlerAdapter->getModule();
		$this->_c = $handlerAdapter->getController();
                $this->_c = $this->_c ? $this->_c : 'index';
		$this->_a = $handlerAdapter->getAction();
                $this->_a = $this->_a ? $this->_a : 'run';
		$this->_mc = $this->_m . '/' . $this->_c;
		$this->_mca = $this->_mc . '/' . $this->_a;
		
		$this->loginUser = Wekit::getLoginUser();
		$this->setTheme('site', null);
	}


	/**
	 * 显示信息
	 *
	 * @param string $message 消息信息
	 * @param string $referer 跳转地址
	 * @param boolean $referer 是否刷新页面
	 * @see WindSimpleController::showMessage()
	 */
	protected function showMessage($message = '', $referer = '', $refresh = false) {
		$this->addMessage('success', 'state');
		$this->addMessage($this->forward->getVars('data'), 'data');
		$this->addMessage($this->forward->getVars('html'), 'html');
		$this->showError($message, $referer, $refresh);
	}

	/**
	 * 显示错误
	 *
	 * @param string $error 消息信息
	 * @param string $referer 跳转地址
	 * @param boolean $referer 是否刷新页面
	 */
	protected function showError($error = '', $referer = '', $refresh = false) {
		if ($referer && !WindValidator::isUrl($referer)) {
			$_referer = explode('#', $referer, 2);
			$referer = WindUrlHelper::createUrl($_referer[0], array(), 
				isset($_referer[1]) ? $_referer[1] : '');
		}
		$this->addMessage($referer, 'referer');
		$this->addMessage($refresh, 'refresh');
		parent::showMessage($error);
	}
	
	/*
	 * (non-PHPdoc) @see WindSimpleController::setDefaultTemplateName()
	 */
	protected function setDefaultTemplateName($handlerAdapter) {
		$this->setTemplate($handlerAdapter->getController() . '_' . $handlerAdapter->getAction());
	}
	
	/*
	 * (non-PHPdoc) @see WindSimpleController::afterAction()
	 */
	public function afterAction($handlerAdapter) {
		$this->setOutput($this->loginUser, 'loginUser');
	}

	/**
	 * action Hook 注册
	 *
	 * @param string $registerKey 扩展点别名
	 * @param PwBaseHookService $bp        	
	 * @throws PwException
	 * @return void
	 */
	protected function runHook($registerKey, $bp) {
		if (!$registerKey) return;
		if (!$bp instanceof PwBaseHookService) {
			throw new PwException('class.type.fail', 
				array(
					'{parm1}' => 'src.library.base.PwBaseController.runHook', 
					'{parm2}' => 'PwBaseHookService', 
					'{parm3}' => get_class($bp)));
		}
		if (!$filters = PwHook::getRegistry($registerKey)) return;
		if (!$filters = PwHook::resolveActionHook($filters, $bp)) return;
		$args = func_get_args();
		$_filters = array();
		foreach ($filters as $key => $value) {
			$args[0] = isset($value['method']) ? $value['method'] : '';
			$_filters[] = array('class' => $value['class'], 'args' => $args);
		}
		$this->resolveActionFilter($_filters);
	}
	


	/**
	 * 风格设置
	 *
	 * 设置当前页面风格，需要两个参数，$type风格类型，$theme该类型下风格
	 *
	 * @see WindSimpleController::setTheme()
	 * @param string $type 风格类型(site,space,area...)
	 * @param string $theme 风格别名
	 */
	protected function setTheme($type, $theme) {
		$config = Wekit::C('site');
		$themePack = $config['theme.' . $type . '.pack'];
		$themePack = 'THEMES:' . $themePack;

		// 风格预览，管理员权限
		if ($style = Pw::getCookie('style_preview')) {
			list($s_theme, $s_type) = explode('|', $style, 2);
			if ($s_type == $type) {
				$theme = $s_theme;
				Wekit::C()->site->set('theme.' . $type . '.default', $theme);
			}
		}
		if (!$theme) $theme = $config['theme.' . $type . '.default'];
		parent::setTheme($theme, $themePack);
	}
        /** 
         * $cache_dir 缓存目录  [权限 777] 
         * $isindex   是否是首页 
         * $ttl       生存时间(单位: 秒) 
         */ 
        protected function getStaticHtml($cache_dir = '', $isindex = 0, $ttl = 86400){ 
          //获取网站根目录 
          $root = dirname(dirname(dirname(dirname(__FILE__)))); 
//die($root);
          //判断缓存目录是否为相对目录 
          $roots = '/' == substr($cache_dir, 0, 1) ? $cache_dir : $root.'/'.$cache_dir; 
          //生成缓存文件的位置 
          $cache_tpl = sprintf('%s/%s_%s_%s.html', $roots, $this->_m, $this->_c, $this->_a); 
          if($isindex){ 
            //是否为首页 
            $cache_tpl = $root.'/index.html'; 
          } 
//die($cache_tpl);
          //缓存文件存在且生存时间未过期 
          if(file_exists($cache_tpl) && (time() - filemtime($cache_tpl)) < $ttl){ 
            echo file_get_contents($cache_tpl);exit; 
          }else{ 
/*            $html = file_get_contents(WindUrlHelper::createUrl($this->_mca . '?time=' . time())); 
//die($html);
            if($html && strlen($html) > 5000){ 
              //获取页面的html 并写入缓存文件 
              file_put_contents($cache_tpl, $html); 
              //修改缓存文件权限 
              chmod($cache_tpl, 0777); 
            } 
*/
            $cmd = sprintf("wget %s -O %s ", WindUrlHelper::createUrl($this->_mca), $cache_tpl);
            $cmd = str_replace(array('?', '&'), array('\\?', '\\&'), $cmd);
//echo ($cmd);
            @exec($cmd);
            @chmod($cache_tpl, 0777);
          } 
      } 
}
