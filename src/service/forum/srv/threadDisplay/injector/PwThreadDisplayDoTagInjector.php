<?php
defined('WEKIT_VERSION') || exit('Forbidden');

/**
 * 帖子阅读-标签
 *
 * @author jinlong.panjl <jinlong.panjl@aliyun-inc.com>
 * @copyright ©2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id$
 * @package wind
 */
class PwThreadDisplayDoTagInjector extends PwBaseHookInjector {
	
	public function run() {
		Wind::import('SRV:forum.srv.threadDisplay.do.PwThreadDisplayDoTag');
		return new PwThreadDisplayDoTag();
	}
}