<?php
 
require('../common/library.php');

// user_id
// current_password
// new_password
// confirm_password

// error_log(print_r($_POST,TRUE));

 /*$_POST['user_id']=20;
 $_POST['current_password']=654321;
 $_POST['new_password']=123456;
 $_POST['confirm_password']=123456;*/

if(isset($_POST['user_id']) && $_POST['user_id']!="" &&
    isset($_POST['curr_password']) && $_POST['curr_password']!="" &&
    isset($_POST['new_password']) && $_POST['new_password']!="" &&
    isset($_POST['confirm_password']) && $_POST['confirm_password']!=""
  ):
    $current_password = $_POST['curr_password'];
    $new_password = $_POST['new_password'];
    $confirm_password = $_POST['confirm_password'];
    $user_id = $_POST['user_id'];
    
   
    if($new_password == $confirm_password):
     
        $admin_data = $obj->select("*","users","ID='$user_id'");
        if(is_array($admin_data))
        {
            $db_hash = $admin_data[0][6];
            $db_salt = $admin_data[0][7];
            
           $db_salt = str_replace(" ","",$db_salt);
           
                //check oldpassword encreaption
                $password = hash('sha256', $current_password . $db_salt); 
        		for($round = 0; $round < 65536; $round++) 
        		{ 
        			$password = hash('sha256', $password . $db_salt); 
        		}
        		
        		$db_hash = str_replace(" ","",$db_hash);
        	    $password = str_replace(" ","",$password);
        		if(strcmp($db_hash,$password)==0)
        		{
        		    
        		        //encreaption 
                        $salt = dechex(mt_rand(0, 2147483647)) . dechex(mt_rand(0, 2147483647));	
                        $password = hash('sha256', $new_password . $salt); 
                        for($round = 0; $round < 65536; $round++) 
                        { 
                        	$password = hash('sha256', $password . $salt); 
                        }
                        $hash = $password;
    
                      //**************
        		     
        		        $obj->execute("UPDATE users SET hash='$hash',salt='$salt' WHERE ID='$user_id'");
                        $data['response']="y";
                        $data['error'] = false;
                        $data['message']="Password changed successfully";
                        $data['page'] = "my-profile.php";
        		}
                else{
                    $data['response']="n";
                    $data['error'] = true;
                    $data['message']="Current password does not match";
                }
           }
         else{
            $data['response']="n";
            $data['error'] = true;
            $data['message']="Current password does not match";
         }
         
         else:
                $data['response']="n";
                $data['error'] = true;
                $data['message']=" Confirm password does not match";
             
         endif;
else:
    $data['response']="n";
    $data['error'] = true;
    $data['message']="Fields marked with * are mandatory";
endif;
 
echo json_encode($data);
    
?>