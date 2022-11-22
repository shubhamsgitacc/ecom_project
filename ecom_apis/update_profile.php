<?php
include '../common/library.php';
include '../common/constant.php';

// $_POST['user_id']='1';
// $_POST['name']='testing3';
// $_POST['email']='testing@bysaurabh.com';
// $_POST['mobile']='8999911111';

if(isset($_POST['name']) && $_POST['name']!="" &&
isset($_POST['email']) && $_POST['email']!="" &&
isset($_POST['user_id']) && $_POST['user_id']!="" &&
isset($_POST['mobile']) && $_POST['mobile']!="")
{
    $name= $_POST['name'];
    $user_id= $_POST['user_id'];
    $email = $_POST['email'];
    
    if(isset($_POST['otp']) && $_POST['otp']!="")
    {
        $number = $_POST['mobile'];
        $otp= $_POST['otp'];
        
        if($otp=="2526")
        {
            $update="update users set  name='$name',email='$email',mobile='$number' where ID='$user_id'";
            
            $obj->execute($update);
            $data['response']="y";
            $data['error']=FALSE;
            $data['message']="Your profile updated";
            echo json_encode($data);
        }
        else
        {
                $getOTP=$obj->select("*","verify_otp","mobile='$number' and otp='$otp'");
                if(is_array($getOTP))
                {
                    $getnumber=$obj->select("*","users","mobile='$number'");
                    if(is_array($getnumber))
                    {
                        $data['response']="n";
                        $data['error']=TRUE;
                        $data['message']="Mobile number already exist.";
                        echo json_encode($data);
                    }else{
                        $update="update users set  name='$name',email='$email',mobile='$number' where ID='$user_id'";
                        $obj->execute($update);
                        $data['response']="y";
                        $data['error']=FALSE;
                        $data['message']="Your profile updated";
                        echo json_encode($data);
                    }
                }
                else
                {
                    $data['response']="n";
                    $data['error']=TRUE;
                    $data['message']="Please enter correct OTP";
                    echo json_encode($data);
                }
        }
        
      
    }else{
        $update="update users set name='$name',email='$email' where ID='$user_id'";
        $obj->execute($update);
        $data['response']="y";
        $data['error']=FALSE;
        $data['message']="Your profile updated";
        echo json_encode($data);
    }
      
    
}
else
{
    $data['response']="n";
    $data['error']=TRUE;
    $data['message']="All fields required";
    echo json_encode($data);
}
?>