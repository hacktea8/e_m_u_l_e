<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Webbase extends CI_Controller {
  public $tpl_dir='default/';
  public $viewdata=array();


  public function __construct(){
    parent::__construct();
    //$this->load->model('testModel');
    $this->load->_ci_view_paths = array(APPPATH.'views/'.$this->config->item('tpl_dir')  => TRUE);

    $this->setviewdata(array('base_css'=>$this->config->item('base_css'),
    'base_js'=>$this->config->item('base_js'),'base_imgs'=>$this->config->item('base_imgs'),'site_name'=>$this->config->item('site_name'),'site_keywords'=>$this->config->item('site_keywords'),
    'site_description'=>$this->config->item('site_description'),'base_url'=>$this->config->item('base_url')));
  }
  public function setviewdata($param=array()){
    foreach($param as $key=>$val){
       $this->viewdata[$key]=$val;
    }
    return true;
  }
}

