<?php
include '../common/library.php';
include '../common/constant.php';


// $_POST['user_id'] = "14";
// $_POST['product_id'] ="3";
// $_POST['qty']="50";

if(isset($_POST['user_id']) && $_POST['user_id']!="" &&
    isset($_POST['product_id']) && $_POST['product_id']!="" &&
    isset($_POST['qty']) && $_POST['qty']!="")
    {
            $user_id = $_POST['user_id'];
            $product_id=$_POST['product_id'];
            
            
            $product_info = $obj->select("*","products","ID='$product_id'");
            if(is_array($product_info))
            {
                $db_qty =  $product_info[0][4];
                $qty = $_POST['qty'];
                $createdon= DATETIMEFORMAT;
                $updatedon = DATETIMEFORMAT;
                
                if($qty<=$db_qty)
                {
                     $checkProduct = $obj->select("*","cart","procuct_id='$product_id' and User_id='$user_id'");
                     if(is_array($checkProduct))
                     {
                         $id = $checkProduct[0][0];
                         $updateQuery = "update cart set qty='$qty',updatedon='$updatedon',procuct_id='$product_id',User_id='$user_id' where ID='$id'";
                         $obj->execute($updateQuery);
                     }
                     else
                     {
                          $obj->insert("cart","User_id, procuct_id, qty, createdon, updatedon","'$user_id','$product_id','$qty','$createdon','$updatedon'");
                     }
                    $data["response"]='y';
                    $data['error'] = FALSE;
                    $data["message"]='Product added to cart';
                    echo json_encode($data);
                }
                else
                {
                    $data["response"]='n';
                    $data['error'] = TRUE;
                    $data["message"]='Only '.$db_qty.' quantity available in stock ';
                    echo json_encode($data);
                }
            }
            else
            {
                    $data["response"]='n';
                    $data['error'] = TRUE;
                    $data["message"]='Requested product is not found';
                    echo json_encode($data);
            }
    }
   else
    {
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='Select product and enter quantity';
            echo json_encode($data);
    }
?>