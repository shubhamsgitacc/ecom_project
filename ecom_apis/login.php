<?php

include '../common/library.php';
include '../common/constant.php';

// //error_log(print_r($_POST,TRUE));
// $_POST['username']='8999999999'; 
// $_POST["password"]='123456';

 if(isset($_POST['username']) && !empty($_POST['username']) && isset($_POST["password"]) && !empty($_POST["password"]))
{
    $username = trim($_POST['username']);
    $pass = trim($_POST["password"]);
    $user_info = $obj->select("*","users","mobile='$username'");
    if(is_array($user_info))
    {
        if($user_info[0][4]==1)
        {
        $db_hash =  $user_info[0][6];  
        $db_salt =  $user_info[0][7];
        
      //echo $db_hash.$dbsalt;
        
         //de-encreaption
        $password = hash('sha256', $pass . $db_salt); 
		for($round = 0; $round < 65536; $round++) 
		{ 
			$password = hash('sha256', $password . $db_salt); 
		}
	 
		 //end de-encreaption
		 if($db_hash == $password){
		  //  print_r($user_info);
			$data['response']="y";
            $data['error']=FALSE;
            $data['user_id']= $user_info[0][0];
            $data['name']= $user_info[0][1];
            $data['email']= $user_info[0][3];
            $data['referral_code']=$user_info[0][9];
            $data['message']="Login successful";
            echo json_encode($data);
            
		}else{
			//echo "<script>alert('Wrong Password')</script>";
			$data['response']="n";
            $data['error']=TRUE;
            $data['message']="Password does not match";
            echo json_encode($data);
		}	
    
     
     
    
    }
        else{
            $data['response']="n";
            $data['error']=TRUE;
            $data['message']="Your account is inactive";
            echo json_encode($data);
        }
    }else{
        $data['response'] = 'n';
        $data['error'] = TRUE;
        $data['message'] = 'Mobile number is not registered';
        echo json_encode($data);
    }
    
    
   
}
else{
        $data['response']="n";
        $data['error']=TRUE;
        $data['message']="All fields required";
        echo json_encode($data);
}
?>
