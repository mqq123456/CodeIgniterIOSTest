<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Test_model extends CI_Model {

    // 增
  public function insert($name,$password) {
    $this->load->database();
    // 查找数据
    $sql = "SELECT name FROM user where name = ?";
    $user = $this->db->query($sql,$name);
    $user = $user->result_array();//再查询一次数据库
    // 如果数据不存在，插入数据
    if (count($user) == 0) {       //数量为0，即表示用户不存在
        $sql1 = 'INSERT INTO user (name, password) VALUES (?,?)';
        $this->db->query($sql1,array($name,$password));//插入
        $id = $this->db->insert_id();//获取插入的行号，即id
        $user = $this->db->query($sql,$name);
        if (count($user) != 0) {//如果有数据，即表明插入成功
          $viewArray = array("status" => "ok","data"=> $user->result_array());
          exit(json_encode($viewArray));
        }
    }else{ // 插入失败，数据库已存在数据
      $viewArray = array("status" => "error","errorMsg"=> "user exist");
      exit(json_encode($viewArray));
   }
}
  // 删
  public function delete($name) {
        $this->load->database();
        //查找数据
        $sql = "SELECT name FROM user where name = ?";
        $res = $this->db->query($sql,$name);
        $res = $res->result_array();
        if (count($res) != 0 ) {
          // 删除数据
           $sql = 'DELETE FROM user WHERE name = ?';
           $this->db->query($sql,$name);
           $viewArray = array("status" => "ok");
          exit(json_encode($viewArray));
        }else{
          // 数据不存在
          $viewArray = array("status" => "error","errorMsg"=> "user not exist");
          exit(json_encode($viewArray));
        }
        
    }
  
  public function update($id,$password) {
    $this->load->database();
        //查找数据
        $sql = "SELECT id FROM user where id = ?";
        $res = $this->db->query($sql,$id);
        $res = $res->result_array();
        if (count($res) != 0 ) {
          // 更新数据
           $sql = "UPDATE user SET password = ? WHERE id = '$id'";
           $res = $this->db->query($sql,$password);
           if ($res) {
            $viewArray = array("status" => "ok");
            exit(json_encode($viewArray));
           }
        }else{
          // 数据不存在
          $viewArray = array("status" => "error","errorMsg"=> "user not exist");
          exit(json_encode($viewArray));
        }
  }

  // 查
	public function select()
    {
      $this->load->database();
    	$query=$this->db->query("select * from user");
      $array = $query->result();
      return $array;
    }

    

    

}
