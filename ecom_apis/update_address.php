<?php
include '../common/library.php';
include '../common/constant.php';


// $_POST['addrs_id'] ="9";
// $_POST['name']="updated address";
// $_POST['mobile'] ="3214569870";
// $_POST['address']  ="test5 test5";
// $_POST['landmark']="near test5";
// $_POST['pincode'] ="452001";

if(isset($_POST['addrs_id']) && $_POST['addrs_id']!="" &&
    isset($_POST['name']) && $_POST['name']!=""&&
    isset($_POST['mobile']) && $_POST['mobile']!=""&&
    isset($_POST['address']) && $_POST['address']!=""&&
    isset($_POST['landmark']) && $_POST['landmark']!=""&&
     isset($_POST['pincode']) && $_POST['pincode']!="")
    {
            $add_id = $_POST['addrs_id'];
            $user_id = $_POST['user_id'];
            $username =trim(htmlentities($_POST['name'],ENT_QUOTES));
            $user_contact = trim($_POST['mobile']);
            $user_add = trim(htmlentities($_POST['address'],ENT_QUOTES));
            $landmark = trim(htmlentities($_POST['landmark'],ENT_QUOTES));
            $pincode = trim($_POST['pincode']);
            
                    $update_query = "UPDATE addresses SET user_name='$username',user_contact='$user_contact',user_add='$user_add',landmark='$landmark',pin_code='$pincode' WHERE  ID='$add_id' ";
                    $obj->execute($update_query);
                    
                    $data["response"]='y';
                    $data['error'] = FALSE;
                    $data["message"]='Address Updated Successfully.';
                    echo json_encode($data);
    }
    else
    {
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='All Filed Required.';
            echo json_encode($data);
    }
?>