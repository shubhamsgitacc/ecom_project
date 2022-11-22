<?php

    require('../common/library.php');
    require('../common/constant.php');
    require('../common/function.php');
    
    $smsapik = SMSAPIKEY;
    $senderid = SENDERID;
    $routeid=ROUTEID;
    //$entity_id=ENTITYID;
    $campaign_id=CAMPAIGN_ID;
    
    
    // $_POST['mobile'] = '8999999999';
    // $_POST['type']="login";
    

    //error_log(print_r($_POST,true));
    
    if (isset($_POST['mobile']) && $_POST['mobile']!= "" &&
    isset($_POST['type']) && $_POST['type']!= "")
    {
        $mobile_no = $_POST['mobile'];
        $type=$_POST['type'];
        
        $today = CURRENTTIME;
        $otp = rand(1111, 9999);
        
        if(strlen($mobile_no)==10)
        {
            if($type=="login")
            {
                $userData = $obj->select("mobile", "users", "mobile='$mobile_no'");
                if (is_array($userData))
                {
                    $userData = $obj->select("mobile", "users", "mobile='$mobile_no' AND status='1'");
                    if (is_array($userData))
                    {
                        $message=urlencode("Your Ditrp verification code is ".$otp.".Verification code is valid for 5 minutes only, one time use.From SLITS");
                        $mobileResponse = file_get_contents("http://sms.studyleagueitsolutions.com/app/smsapi/index.php?key=".$smsapik."&campaign=".$campaign_id."&routeid=".$routeid."&type=text&contacts=".$mobile_no."&senderid=".$senderid."&msg=".$message."&template_id=".template_id); 
                        
                        
                        $record = $obj->select("*", "verify_otp", "mobile = '$mobile_no'");
            
                        if (is_array($record)):
                            $obj->execute("UPDATE verify_otp SET otp='$otp',createdon='$today' WHERE ID=" . $record[0][0]);
                        else:
                            $i = $obj->insert("verify_otp", "mobile,otp,createdon", "'$mobile_no','$otp','$today'");
            
                        endif;
                        $data['response'] = "y";
                        $data['error'] = false;
                        $data['message'] = "Enter the OTP sent on your mobile";
                        echo json_encode($data);
                    }
                    else
                    {
                        $data['response'] = 'n';
                        $data['error'] = true;
                        $data['message'] = 'User is inactive, please contact to your admin';
                        echo json_encode($data);
                    }
                }
                else
                {
                    $data['response'] = 'n';
                    $data['error'] = true;
                    $data['message'] = 'Mobile no. does not exist';
                    echo json_encode($data);
                }
            }
            else
            {
                $userData = $obj->select("mobile", "users", "mobile='$mobile_no'");
                if (is_array($userData))
                {
                    $data['response'] = 'n';
                    $data['error'] = true;
                    $data['message'] = 'Mobile number already exist';
                    echo json_encode($data);
                }
                else
                {
                    $message=urlencode("Your Ditrp verification code is ".$otp.".Verification code is valid for 5 minutes only, one time use.From SLITS");
                    $mobileResponse = file_get_contents("http://sms.studyleagueitsolutions.com/app/smsapi/index.php?key=".$smsapik."&campaign=".$campaign_id."&routeid=".$routeid."&type=text&contacts=".$mobile_no."&senderid=".$senderid."&msg=".$message."&template_id=".template_id); 
                   
                    $record = $obj->select("*", "verify_otp", "mobile = '$mobile_no'");
        
                    if (is_array($record)):
                        $obj->execute("UPDATE verify_otp SET otp='$otp',createdon='$today' WHERE ID=" . $record[0][0]);
                    else:
                        $i = $obj->insert("verify_otp", "mobile,otp,createdon", "'$mobile_no','$otp','$today'");
        
                    endif;
                    $data['response'] = "y";
                    $data['error'] = false;
                    $data['message'] = "Enter the OTP sent on your mobile";
                    echo json_encode($data);
                }
            }
        }
        else
        {
            $data['response'] = "n";
            $data['error'] = true;
            $data['message'] = "Mobile no. must 10 digit";
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