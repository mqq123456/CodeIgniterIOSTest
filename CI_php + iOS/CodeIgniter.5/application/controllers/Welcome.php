<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends CI_Controller {
	// 入口函数
	public function index()
	{
		//$this->load->view('welcome_message');
		echo '{"test":"ok"}';
	}
	// 公有函数，直接调用 ..welcome/comment
	public function comment() 
	{
		echo "comment";
	}
	// 带参数函数，调用方式 ...welcome/parms/parms1/parms2
	public function parms($parms1, $parms2) {
		echo $parms1;
		echo $parms2;
	}
	// 重定向入口函数
	// public function _remap($method)
	// {
 //    	if ($method === 'some_method')
 //   	 	{
 //        	$this->comment();
 //    	}
 //   		 else
 //    	{
 //        	$this->index();
 //    	}
	// }

	// 受保护方法
	private function privateMethod() {
		echo "private";
	}

	// insert
    public function insertData($name,$password) {
    	$this->load->model('Test_model');
		$this->Test_model->insert($name,$password);
    }

    // delete
    public function deleteData($name) {
    	$this->load->model('Test_model');
    	$this->Test_model->delete($name);
    }
    // update
    public function updateData($id,$password) {
    	$this->load->model('Test_model');
    	$this->Test_model->update($id,$password);
    }
    // select
	public function selectData()
    {
        $this->load->model('Test_model');
		$array = $this->Test_model->select();
		exit(json_encode($array));
    }
 
}
