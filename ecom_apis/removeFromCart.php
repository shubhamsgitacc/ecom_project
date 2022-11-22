<?php
include '../common/library.php';
include '../common/constant.php';

// $_POST['user_id']='13';
// $_POST['product_id']='1';

if(isset($_POST['user_id']) && $_POST['user_id']!="" &&
    isset($_POST['product_id']) && $_POST['product_id']!="")
    {
            $user_id = $_POST['user_id'];
            $product_id=$_POST['product_id'];
            
            $query = "delete from cart where User_id='$user_id' and procuct_id='$product_id'";
            $obj->execute($query);
            
            $data["response"]='y';
            $data['error'] = FALSE;
            $data["message"]='Product deleted successfully from cart';
            echo json_encode($data);
    }
    else
    {
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='Select product and enter quantity';
            echo json_encode($data);
    }
?>