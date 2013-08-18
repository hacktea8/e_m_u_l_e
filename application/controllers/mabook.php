<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
include_once('webbase.php');
class Mabook extends Webbase {
   
  public function __construct(){
    parent::__construct();
    //$this->load->model('testModel');
  }
	public function index()
	{
   // $this->load->model('testmodel');
   // $data=$this->testModel->getdata();
	 	$this->load->view('maindex',$this->viewdata);
	}
  public function insert($name){
   // $this->load->model('testmodel');
    $this->testModel->Insertdata($name);
  }
}

