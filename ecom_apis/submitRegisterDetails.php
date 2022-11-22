<?php
include '../common/library.php';
include '../common/constant.php';

    // $_POST["name"] = "Referal Testing";                    // hardcoded
    // $_POST["email"] = "testing@yahoo.com";             // hardcoded
    // $_POST["password"]="123456";
    // $_POST["cpassword"]="123456";
    // $_POST["user_id"] = "9";               // hardcoded
    // $_POST["referee"] = "DITRP16";
    
    
    $_POST["user_id"] = $obj->int_filter($_POST["user_id"]);
    $_POST["name"] = $obj->string_filter($_POST["name"]);
    $_POST["email"] = $obj->email_filter($_POST["email"]);
    $_POST["password"] = $obj->password_filter($_POST["password"]);        //can contain only alphabets, numbers and special characters such as (.$%&@!*#)
    $_POST["cpassword"] = $obj->password_filter($_POST["cpassword"]); 
    
    
    if(isset($_POST["name"]) && !empty($_POST["name"]) && 
    isset($_POST["email"]) && !empty($_POST["email"]) &&
    isset($_POST["password"]) && !empty($_POST["password"])&&
    isset($_POST["cpassword"]) && !empty($_POST["cpassword"]) &&
    isset($_POST["user_id"]) && !empty($_POST["user_id"]))
    {
        $password = $_POST["password"];
        $cpassword = $_POST["cpassword"];
        $name = $_POST["name"];
        $user_id = $_POST["user_id"];
        $email = $_POST["email"];
         
        if(strcmp($password,$cpassword)==0)
        {
            
            if(isset($_POST["referee"]) && !empty($_POST["referee"]))
            {
                 $ref=$_POST["referee"];
                 $userid = $obj->select("*", "users", "referral='$ref'");
                 
                if(is_array($userid))
                {
                 $referrerID = $userid[0][0] ;
                 $today = CURRENTTIME;
                //  $insert = $obj->insert("discount", "referrer_id,user_id,is_used,createdon","'$referrerID', $user_id', '1','$today'");/
                 $insert = $obj->insert("discount", "referrer_id,user_id,is_used,createdon","'$user_id', '0', '1','$today'");
                 $obj->execute("UPDATE users SET referee='$ref' where ID='$user_id'");  
                }
                else{
                    $data['response']="n";
                    $data['error']=TRUE;
                    $data["message"]='Invalid referral code';
                    echo json_encode($data);
                    exit;
                }
            }
            
            $pass = $_POST['password'];
            $salt = dechex(mt_rand(0, 2147483647)) . dechex(mt_rand(0, 2147483647));	
            $password = hash('sha256', $pass . $salt); 
            for($round = 0; $round < 65536; $round++) 
            { 
                $password = hash('sha256', $password . $salt); 
            }
            $hash = $password;
                                                       
            $referral ="REF".$userid;   
                                    
            $obj->execute("UPDATE users SET name='$name' , email='$email', hash='$hash', salt='$salt' where ID='$user_id'");  
            

            $data['response']="y";
            $data['error']=FALSE;
            $data["message"]='Registration successful';
            echo json_encode($data);
                                                        
        }
        else{
        	$data['response']="y";
            $data['error']=TRUE;
            $data["message"]='Password and Confirm Password does not match';
            echo json_encode($data);
        }
                                            
    }
else{
    $data["response"]='n';
    $data['error'] = TRUE;
    $data["message"]='All field required';
    echo json_encode($data);
}
    

?>
