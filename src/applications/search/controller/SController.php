<?php

class SController extends PwBaseController {
	
	public function run() {
		$keywords = $this->getInput('keyword');
		if (!Wekit::C('site', 'search.isopen')) {
			$this->forwardRedirect(WindUrlHelper::createUrl('search/search/run', array('keyword' => $keywords)));
		}
		$this->forwardAction('app/index/run?app=search',array('keywords' => $keywords));
	}

}