<?php

/**
 * 举报Controller
 *
 * @author jinlong.panjl <jinlong.panjl@aliyun-inc.com>
 * @copyright ©2003-2103 phpwind.com
 * @license http://www.phpwind.com
 * @version $Id$
 * @package wind
 */

class IndexController extends PwBaseController {
	
	public function beforeAction($handlerAdapter) {
		parent::beforeAction($handlerAdapter);
		if (!$this->loginUser->isExists()) {
			$this->forwardAction('u/login/run',array('backurl' => WindUrlHelper::createUrl('my/article/run')));
		}
		if (!$this->loginUser->getPermission('allow_report')) {
			$this->showError(array('report.allow',array('{grouptitle}' => $this->loginUser->getGroupInfo('name'))));
		}
	}
	
	/**
	 * 举报弹窗
	 *
	 * @return void
	 */
	public function reportAction() {
		list($type,$type_id) = $this->getInput(array('type','type_id'));
		$this->setOutput($type, 'type');
		$this->setOutput($type_id, 'type_id');
	}
	
	/**
	 * do举报
	 *
	 * @return void
	 */
	public function doReportAction() {
		list($type, $type_id, $reason) = $this->getInput(array('type', 'type_id', 'reason'), 'post');
		if (!$type_id) {
			$this->showError('operate.fail');
		}
		$report = Wekit::load('report.srv.PwReportService');
		$result = $report->sendReport($type,$type_id,$reason);
		if ($result instanceof PwError) {
			$this->showError($result->getError());
		}
		$this->showMessage('success');
	}
}
