<?php
include '../common/library.php';
include '../common/constant.php';


// $_POST['user_id'] ="3";
// $_POST['name']="testbysaurabh";
// $_POST['mobile'] ="3214569870";
// $_POST['address']  ="04 test";
// $_POST['landmark']="test";
// $_POST['pincode'] ="401208";


if(isset($_POST['user_id']) && $_POST['user_id']!=""&&
    isset($_POST['name']) && $_POST['name']!=""&&
    isset($_POST['mobile']) && $_POST['mobile']!=""&&
    isset($_POST['address']) && $_POST['address']!=""&&
    isset($_POST['landmark']) && $_POST['landmark']!=""&&
    isset($_POST['pincode']) && $_POST['pincode']!="" )
    {
            $user_id = $_POST['user_id'];
            $username =trim(htmlentities($_POST['name'],ENT_QUOTES));
            $user_contact = $_POST['mobile'];
            $user_add = trim(htmlentities($_POST['address'],ENT_QUOTES));
            $landmark = trim(htmlentities($_POST['landmark'],ENT_QUOTES));
            $pincode = $_POST['pincode'];
            
            // $pincode_array = $obj->select("*","pin_codes","pincode='$pincode'");
            
                    $addID = $obj->insert("addresses","user_id, user_name, user_contact, user_add, landmark, pin_code","'$user_id','$username','$user_contact','$user_add','$landmark','$pincode'");
            
                    $data["response"]='y';
                    $data['error'] = FALSE;
                    $data["message"]='Address added successfully';
                    echo json_encode($data);
           
    }
    else
    {
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='All filed required';
            echo json_encode($data);
    }
?>