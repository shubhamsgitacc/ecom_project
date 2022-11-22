<?php
include '../common/library.php';
include '../common/constant.php';
include '../common/function.php';

//$_POST['order_id']='1';

if(isset($_POST['order_id']) && $_POST['order_id']!="")
{
    $order_id = $_POST['order_id'];
    $today= CURRENTTIME;
  
    //update wallet balance and sent in wallet statement
    $get_order = $obj->select("deducted_amount,user_id,order_no","orders","ID='$order_id'");
    $deducted_amount = $get_order[0][0];
    $user_id =  $get_order[0][1];
    $order_no =  $get_order[0][2];
    
   //user wallet balance 
    $wallet_balance = $obj->select("wallet_balance","users","ID='$user_id'") [0][0];
   
    if($deducted_amount != "")
    {
         //add the same entry in wallet history
         $obj->insert("wallet_statement","referee_id, referral_id, order_id, referral_amount, createdon,method",
                "'','$user_id','$order_id','$deducted_amount','$today','Credit'");
    
         $wallet_balance = $wallet_balance + $deducted_amount;
        //update user wallet
        $obj->execute("UPDATE users set walletBalance = '$wallet_balance' where ID='$user_id'");
    }
    //update  order item detail
    $get_item = $obj->select("*","ordered_products","order_id='$order_id'");
    if(is_array($get_item))
    {
        foreach($get_item as $key=>$val)
        {
            $item_id = $val[2];
            $item_qty = $val[3];
            $item_weight = $val[5];
            $item_color = $val[9];
            $size_id = $obj->select("ID","size","size_name='$item_weight'") [0][0];
            $color_id = $obj->select("ID","color","name='$item_color'") [0][0];
            
            if($item_weight!='N' && $item_color !='N'){
                
                $var_qty = $obj->select("quantity","product_variants","product_id='$item_id' and size_id='$size_id' and color_id='$color_id'") [0][0];
                $var_update_qty = $var_qty + $item_qty;
                $update = "UPDATE product_variants SET quantity='$var_update_qty' where product_id='$item_id' and size_id='$size_id' and color_id='$color_id'";
            } elseif($item_weight!='N' && $item_color =='N') {
                
                $var_qty = $obj->select("quantity","product_variants","product_id='$item_id' and size_id='$size_id'") [0][0];
                $var_update_qty = $var_qty + $item_qty;
                $update = "UPDATE product_variants SET quantity='$var_update_qty' where product_id='$item_id' and size_id='$size_id'";
            } elseif($item_weight =='N' && $item_color !='N') {
                
                $var_qty = $obj->select("quantity","product_variants","product_id='$item_id' and color_id='$color_id'") [0][0];
                $var_update_qty = $var_qty + $item_qty;
                $update = "UPDATE product_variants SET quantity='$var_update_qty' where product_id='$item_id' and color_id='$color_id'";
            }
            else
            {
                $current_qty = $obj->select("quantity","products","ID='$item_id'") [0][0];
                $update_qty = $current_qty + $item_qty;
                $update = "UPDATE products SET quantity='$update_qty' where ID='$item_id'";
            }
            $obj->execute($update);
        }
    }
    
    $player_id=$obj->select("player_id","users","ID='$user_id'")[0][0];
                    
    if($player_id!="")
    {
        $title="Order Cancelled";
        $message="Your Order ".$order_no." has been cancelled.";
                                        
        $notification_id = $obj->insert("notification","message,date,user_id","'$message','$today','$user_id'");
        //Send interest notification
        // sendnotification($player_id, $title, $message,'orderCancel');
    }
    else{
        $title="Order Cancelled";
        $message="Your Order ".$order_no." has been cancelled.";
                                        
        $notification_id = $obj->insert("notification","message,date,user_id","'$message','$today','$user_id'");
    }
    
    //update status
    $query = "update orders set status='5' where ID=$order_id";
    $obj->execute($query);
    
    $data['response']="y";
    $data['error']=FALSE;
    $data['message']="Your order cancelled";
    echo json_encode($data);
    
}
else
{
     $data['response']="n";
    $data['error']=TRUE;
    $data['message']="Order ID  missing.";
    echo json_encode($data);
    
}

?>