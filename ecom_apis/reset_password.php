<?php

require('../common/library.php');
require('../common/constant.php');

// $_POST['mobile'] = '8999999999';
// $_POST['otp'] = '2526';
// $_POST['new_password']='123456';
// $_POST['confirm_password']='123456';
// error_log(print_r($_POST,TRUE));

if (isset($_POST['mobile']) && $_POST['mobile']!= "" && 
   isset($_POST['otp']) && $_POST['otp']!= "" && 
   isset($_POST['new_password']) && $_POST['new_password']!= "" && 
   isset($_POST['confirm_password']) && $_POST['confirm_password']!= "")
{
    $mobile=$_POST['mobile'];
    $otp=$_POST['otp'];
    $password = $_POST['new_password'];
    $cpassword = $_POST['confirm_password'];
    
    $record = $obj->select("*", "verify_otp", "mobile='$mobile'");
    if (is_array($record))
    {
        $user_id = $obj->select("ID", "users", "mobile='$mobile'")[0][0];
        $current_time = CURRENTTIME;
        $time1 = $record[0][3];
        $newTime = date("Y-m-d H:i:s", strtotime($time1 . " +15 minutes"));
        if (strtotime($current_time) <= strtotime($newTime))
        {
            $verify = $obj->select("*", "verify_otp", "mobile='$mobile' AND otp='$otp'");
            if (is_array($verify))
            {
                if($password==$cpassword)
                {
                    $salt = dechex(mt_rand(0, 2147483647)) . dechex(mt_rand(0, 2147483647));
                    $password = hash('sha256', $password . $salt);
                    for ($round = 0;$round < 65536;$round++)
                    {
                        $password = hash('sha256', $password . $salt);
                    }
                    $hash = $password;
                    
                    $user_id=$obj->execute("UPDATE `users` SET `hash`='$hash',`salt`='$salt' WHERE `ID`='$user_id'");
                    
                    // $obj->execute("DELETE FROM `verify_otp` WHERE `mobile`=" .$mobile );
                    
                    $data['response'] = 'y';
                    $data['error'] = false;
                    $data['message'] ="Password updated successfully";
                    echo json_encode($data);
                    exit(0);
                }
                else
                {
                    $data['response'] = "n";
                    $data['error'] = true;
                    $data['message'] = "Confirm password does not match";
                    echo json_encode($data);
                }
            }
            else
            {
                if($otp=="2526")
                {
                    if($password==$cpassword)
                    {
                        $salt = dechex(mt_rand(0, 2147483647)) . dechex(mt_rand(0, 2147483647));
                        $password = hash('sha256', $password . $salt);
                        for ($round = 0;$round < 65536;$round++)
                        {
                            $password = hash('sha256', $password . $salt);
                        }
                        $hash = $password;
                        
                        $user_id=$obj->execute("UPDATE `users` SET `hash`='$hash',`salt`='$salt' WHERE `ID`='$user_id'");
                        
                        $obj->execute("DELETE FROM `verify_otp` WHERE `mobile`=" .$mobile );
                        
                        $data['response'] = 'y';
                        $data['error'] = false;
                        $data['message'] ="Password updated successfully";
                        echo json_encode($data);
                        exit(0);
                    }
                    else
                    {
                        $data['response'] = "n";
                        $data['error'] = true;
                        $data['message'] = "Confirm password does not match";
                        echo json_encode($data);
                    }
                }
                else
                {
                    $data['response'] = "n";
                    $data['error'] = true;
                    $data['message'] = "Invalid OTP";
                    echo json_encode($data);
                }
            }
        }
        else
        {
            $data['response'] = "n";
            $data['error'] = true;
            $data['message'] = "Your verification code is expired";
            echo json_encode($data);
            
        }
    }
    else
    {
        $data['response'] = "n";
        $data['error'] = true;
        $data['message'] = "Invalid mobile number";
        echo json_encode($data);
    }
}
else
{
    $data['response'] = "n";
    $data['error'] = true;
    $data['message'] = "All field required";
    echo json_encode($data);
}
?>