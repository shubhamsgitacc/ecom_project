<?php
// session_start();
include ('../common/library.php');
include ('../common/constant.php');
include ('../common/function.php');
include ('../common/EmailConfig/configMail.php');
include ('../common/tcpdf/tcpdf.php');
setlocale(LC_MONETARY, 'en_IN.UTF-8');

// $_POST['user_id']='20';
// $_POST['address_id']='7';
// $_POST['deliveryamount'] ='50';
// $_POST['total'] ='240';
// $_POST['coupon_code'] ="";
// $_POST['wallet']="false";
// $_POST['payment_mode']="CASH";
$_POST['udf1'];
$_POST['udf2'];
$_POST['udf3'];
$_POST['udf4'];
$_POST['udf5'];
$_POST['udf6'];
$_POST['udf7'];

//error_log(print_r($_POST, true));

if (isset($_POST['payuMoneyId']) && $_POST['payuMoneyId'] != "")
{
    $user_id = $_POST['udf1'];
    $coupon_id = $_POST['udf2'];
    $user_add = $_POST['udf3'];
    $deliveryCharge = $_POST['udf4'];
    $txnid = $_POST['txnid'];
    $payment_status = 'Done';
    $udf5 = $_POST['udf5'];
    $udf5_list = explode(',', $udf5);
    
    $discounted_amnt = $udf5_list[0];;
    $is_referal = $udf5_list[1];;
    $total = $udf5_list[2];
    
    $wallet = "false";
    $type = 'Online';
    $today = CURRENTTIME;
    $server_path = SERVERPATHS;
    
    $order_amount = $total;

    //featch the constant data
    // $get_constant = $obj->select("refree_percent","constant","ID='1'");
    // $referral_per = $get_constant[0][0];
    // $deliver_amount = $deliveryCharge;
    //user_detail
    $get_user = $obj->select("*", "users", "ID='$user_id'");
    $user_name = $get_user[0][1];
    $user_mobile = $get_user[0][2];

    
    $amount = $total - $discounted_amnt + $deliveryCharge;
    do
    {
        $order_no = "DITRP" . time();
        $order_present = $obj->select("ID", "orders", "order_no = '$order_no'");
    }
    while (is_array($order_present));

    if ($wallet == "true")
    {
        $wallet_balance = $obj->select("walletBalance", "users", "ID='$user_id'") [0][0];
        //error_log(print_r("Wallet balance".$wallet_balance,TRUE));
        if ($wallet_balance > 0)
        {
            if ($wallet_balance >= $amount)
            {
                $final_amount = $wallet_balance - $amount;
                $wallet_use = '1';
                $wallet_balance = $wallet_balance - $amount;
                // error_log(print_r("Wallet balance".$wallet_balance,TRUE));
                $order_item = $obj->select("procuct_id,qty,price", "cart", "User_id='$user_id'");
                print_r($order_item);
                exit;

                if (is_array($order_item))
                {
                    $finalAmount = $total - $discounted_amnt + $deliveryCharge;
                    $order_id = $obj->insert("orders", "order_no, user_id, total, discount, final_total, coupon_id, placement_date, address_id, status,deliveryCharges, 
                      payment_status,payment_type, payment_requested_id,pending_amt,is_wallet,deducted_amount", "'$order_no', '$user_id', '$total', '$discounted_amnt','$finalAmount','$coupon_id','$today','$user_add','1','$deliveryCharge',
                     '1','Wallet','','0','1','$amount'");

                    if ($is_referal == 'true'){
                        $updateDiscount = "update discount set is_used = '0' where referrer_id='$user_id' and is_used='1' limit 1";
                        $obj->execute($updateDiscount);
                    }

                    $order_track = $obj->insert("order_traks", "order_id,track_status,updateon", "'$order_id','1','$today'");

                    foreach ($order_item as $key => $value)
                    {
                        $itemId = $value[0];
                        $itemQty = $value[1];
                        //$itemPrice = $value[2];
                        $dbQty = 0; //defacut value
                        $products = $obj->select("price,ID,quantity,GST_type,cgst,sgst", "products", "ID='$value[0]'");
                        if (is_array($products))
                        {
                            $itemPrice = $products[0][0] - ($products[0][0] * $discount / 100);
                            $dbQty = $products[0][2];
                            $gst_type = $products[0][3];
                            $cgst = $products[0][4];
                            $sgst = $products[0][5];
                        }

                        if ($dbQty > $itemQty)
                        {
                            $OP_price = $itemPrice * $itemQty;
                            //if Quantity is suficient then actual data save in order_products
                            $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$weight','$gst_type','$cgst','$sgst'");

                            $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                            $obj->execute($updatequery);
                        }
                        else
                        {
                            $OP_price = $dbQty * $itemPrice;
                            //if Quantity is not suficient then qty =0 and price 0 save in order_products with respect to product id
                            $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$gst_type','$cgst','$sgst'");
                            
                            $itemQty = $dbQty;
                            $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                            $obj->execute($updatequery);
                        }

                    }

                    $deleteCart = "delete from cart where User_id='$user_id'";
                    $obj->execute($deleteCart);

                    //sms to admin on confirmation of order
                    $companyName = COMPANY;
                    $api_key = SMS_API_KEY;
                    $route_id = SMS_API_ID;
                    $sender_id = SENDER_ID;
                    $compaign = COMPAIGN;
                    $admin_mobile_no = ADMIN;
                    //admin SMS
                    //$messageAdmin = urlencode("Dear Admin,\n You have received a new order #$order_no at $today.\n\n Regards,\nJeevsattva");
                    //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$admin_mobile_no&senderid=$sender_id&msg=$messageAdmin");

                    //user SMS
                    //$messageUser = urlencode("Dear $user_name,\n Your order (#$order_no) has been placed successfully. Thank you for using Jeevsattva.\n\n Regards,\nJeevsattva");
                    //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$user_mobile&senderid=$sender_id&msg=$messageUser");

                    //add the same entry in wallet history
                    $obj->insert("wallet_statement", "referee_id, referral_id, order_id, referral_amount, createdon,method", "'','$user_id','$order_id','$amount','$today','Debit'");

                    //update user wallet
                    $obj->execute("UPDATE users set walletBalance = '$wallet_balance' where ID='$user_id'");

                    header("Location: success.php?msg=Order placed successfully. Amount deducted from wallet");
                }
                else
                {
                    header("Location: error.php?msg=Cart is empty");
                }

            }
            else
            {
                $final_amount = $amount - $wallet_balance;

                $order_item = $obj->select("procuct_id,qty,price", "cart", "User_id='$user_id'");
                $variant_info = $obj->select("*", "product_variants", "ID='$value[0]'");
                print_r($variant_info);
                exit;
                if (is_array($order_item))
                {
                    $finalAmount = $total - $discounted_amnt + $deliveryCharge;
                    $order_id = $obj->insert("orders", "order_no, user_id, total, discount, final_total, coupon_id, placement_date, address_id, status,deliveryCharges, 
                      payment_id, payment_status,payment_type, payment_requested_id,pending_amt,is_wallet,deducted_amount", "'$order_no', '$user_id', '$total', '$discounted_amnt','$finalAmount','$coupon_id','$today','$user_add','1','$deliveryCharge',
                        '','1','Cash','','$final_amount','1','$wallet_balance'");

                    if ($is_referal == 'true'){
                        $updateDiscount = "update discount set is_used = '0' where referrer_id='$user_id' and is_used='1' limit 1";
                        $obj->execute($updateDiscount);
                    }
                    $order_track = $obj->insert("order_traks", "order_id,track_status,updateon", "'$order_id','1','$today'");

                    foreach ($order_item as $key => $value)
                    {
                        $itemId = $value[0];
                        $itemQty = $value[1];
                        //$itemPrice = $value[2];
                        $dbQty = 0; //defacut value
                        $products = $obj->select("price,ID,quantity,GST_type,cgst,sgst", "products", "ID='$value[0]'");
                        if (is_array($products))
                        {
                            $itemPrice = $products[0][0] - ($products[0][0] * $discount / 100);
                            $dbQty = $products[0][2];
                            $gst_type = $products[0][3];
                            $cgst = $products[0][4];
                            $sgst = $products[0][5];
                        }

                        if (is_array($variant_info))
                        {
                            $dbQty = $products[0][3];
                        }

                        if ($dbQty > $itemQty)
                        {
                            $OP_price = $itemPrice * $itemQty;
                            //if Quantity is suficient then actual data save in order_products
                            $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$weight','$gst_type','$cgst','$sgst'");

                            $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                            $obj->execute($updatequery);
                        }
                        else
                        {
                            $OP_price = $dbQty * $itemPrice;
                            //if Quantity is not suficient then qty =0 and price 0 save in order_products with respect to product id
                            $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$gst_type','$cgst','$sgst'");
                            
                            $itemQty = $dbQty;
                            $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                            $obj->execute($updatequery);
                        }

                    }

                    $deleteCart = "delete from cart where User_id='$user_id'";
                    $obj->execute($deleteCart);

                    //sms to admin on confirmation of order
                    $companyName = COMPANY;
                    $api_key = SMS_API_KEY;
                    $route_id = SMS_API_ID;
                    $sender_id = SENDER_ID;
                    $compaign = COMPAIGN;
                    $admin_mobile_no = ADMIN;
                    //admin SMS
                    //$messageAdmin = urlencode("Dear Admin,\n You have received a new order #$order_no at $today.\n\n Regards,\nJeevsattva");
                    //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$admin_mobile_no&senderid=$sender_id&msg=$messageAdmin");

                    //user SMS
                    //$messageUser = urlencode("Dear $user_name,\n Your order (#$order_no) has been placed successfully. Thank you for using Jeevsattva.\n\n Regards,\nJeevsattva");
                    //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$user_mobile&senderid=$sender_id&msg=$messageUser");

                    //add the same entry in wallet history
                    $obj->insert("wallet_statement", "referee_id, referral_id, order_id, referral_amount, createdon,method", "'','$user_id','$order_id','$wallet_balance','$today','Debit'");

                    //update user wallet
                    $obj->execute("UPDATE users set walletBalance = '0' where ID='$user_id'");

                    header("Location: success.php?msg=Order placed successfully");
                    //$data['message'] = "Order placed successfully, " . money_format('%n', $wallet_balance) . "/- amount deduct from wallet. Kindly pay " . money_format('%n', $final_amount) . "/- pay " . ucfirst($type);

                }
                else
                {
                    header("Location: error.php?msg=Cart is empty");
                }

            }
        }
        else
        {
            $final_amount = $amount - $wallet_balance;

            $order_item = $obj->select("procuct_id,qty,price", "cart", "User_id='$user_id'");
            if (is_array($order_item))
            {
                $finalAmount = $total - $discounted_amnt + $deliveryCharge;
                $order_id = $obj->insert("orders", "order_no, user_id, total, discount, final_total, coupon_id, placement_date, address_id, status,deliveryCharges,
                          payment_id, payment_status,payment_type, payment_requested_id,pending_amt,is_wallet,`deducted_amount`", "'$order_no', '$user_id', '$total', '$discounted_amnt','$finalAmount','$coupon_id','$today','$user_add','1','$deliveryCharge',
                            '$txnid','$payment_status','$type','$payment_request_id','$final_amount','1','$wallet_balance'");
                if ($is_referal == 'true'){
                    $updateDiscount = "update discount set is_used = '0' where referrer_id='$user_id' and is_used='1' limit 1";
                    $obj->execute($updateDiscount);
                }
                $order_track = $obj->insert("order_traks", "order_id,track_status,updateon", "'$order_id','1','$today'");

                foreach ($order_item as $key => $value)
                {
                    $itemId = $value[0];
                    $itemQty = $value[1];
                    //$itemPrice = $value[2];
                    $dbQty = 0; //defacut value
                    $products = $obj->select("price,ID,quantity,GST_type,cgst,sgst", "products", "ID='$value[0]'");
                    if (is_array($products))
                    {
                        $itemPrice = $products[0][0] - ($products[0][0] * $discount / 100);
                        $dbQty = $products[0][2];
                        $gst_type = $products[0][3];
                        $cgst = $products[0][4];
                        $sgst = $products[0][5];
                    }

                    if ($dbQty > $itemQty)
                    {
                        $OP_price = $itemPrice * $itemQty;
                        //if Quantity is suficient then actual data save in order_products
                        $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$gst_type','$cgst','$sgst'");
                        //$insert = $obj->insert("ordered_products", "order_id,product_id,qty,price","'$order_id', '$itemId', '$itemQty', '$OP_price'");
                        $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                        $obj->execute($updatequery);
                    }
                    else
                    {
                        $OP_price = $dbQty * $itemPrice;
                        //if Quantity is not suficient then qty =0 and price 0 save in order_products with respect to product id
                        $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$gst_type','$cgst','$sgst'");
                        
                        //$insert = $obj->insert("ordered_products", "order_id,product_id,qty,price","'$order_id', '$itemId', '$dbQty', '$OP_price'");
                        $itemQty = $dbQty;
                        $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                        $obj->execute($updatequery);
                    }

                }

                $deleteCart = "delete from cart where User_id='$user_id'";
                $obj->execute($deleteCart);

                //sms to admin on confirmation of order
                $companyName = COMPANY;
                $api_key = SMS_API_KEY;
                $route_id = SMS_API_ID;
                $sender_id = SENDER_ID;
                $compaign = COMPAIGN;
                $admin_mobile_no = ADMIN;
                //admin SMS
                //$messageAdmin = urlencode("Dear Admin,\n You have received a new order #$order_no at $today.\n\n Regards,\nJeevsattva");
                //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$admin_mobile_no&senderid=$sender_id&msg=$messageAdmin");

                //user SMS
                //$messageUser = urlencode("Dear $user_name,\n Your order (#$order_no) has been placed successfully. Thank you for using Jeevsattva.\n\n Regards,\nJeevsattva");
                //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$user_mobile&senderid=$sender_id&msg=$messageUser");

                //add the same entry in wallet history
                $obj->insert("wallet_statement", "referee_id, referral_id, order_id, referral_amount, createdon,method", "'','$user_id','$order_id','$wallet_balance','$today','Debit'");

                //calculate referal percentage
                //   $referee_code = $obj->select("referee","users","ID='$user_id'")[0][0];
                //   if($referee_code !="")
                //   {
                //       $referral_amount = round(($total*$referral_per)/100);
                //       $referral_user_id = $obj->select("ID","users","referral='$referee_code'")[0][0];
                //       $obj->insert("wallet_statement","referee_id, referral_id, order_id, referral_amount, createdon,method",
                //             "'$user_id','$referral_user_id','$order_id','$referral_amount','$today','Credit'");
                //       $referral_wallet_balance = $obj->select("walletBalance", "users", "ID='$referral_user_id'") [0][0];
                //       $referral_wallet_balance = $referral_wallet_balance+$referral_amount;
                //       $obj->execute("UPDATE users SET walletBalance='$referral_wallet_balance' WHERE ID='$referral_user_id'");
                //}
                

                //update user wallet
                $obj->execute("UPDATE users set walletBalance = '0' where ID='$user_id'");

                header("Location: success.php?msg=Order placed successfully");

            }
            else
            {
                header("Location: error.php?msg=Cart is empty");
            }

        }
    }
    else
    {
        //when wallet is not selected
        $order_item = $obj->select("procuct_id,qty,weight", "cart", "User_id='$user_id'");
        
        if (is_array($order_item))
        {
            $finalAmount = $total - $discounted_amnt + $deliveryCharge;
            // error_log(print_r($discounted_amnt, true));
            // error_log(print_r($deliveryCharge, true));
            // error_log(print_r($coupon_id, true));
            $order_id = $obj->insert("orders", "order_no, user_id, total, discount, final_total, coupon_id, placement_date, address_id, status,deliveryCharges, payment_id, payment_status,payment_type, is_wallet", 
                                                "'$order_no', '$user_id', '$total', '$discounted_amnt','$finalAmount','$coupon_id','$today','$user_add','1','$deliveryCharge','$txnid','$payment_status','$type','0'");
            if ($is_referal == 'true'){
                $updateDiscount = "update discount set is_used = '0' where referrer_id='$user_id' and is_used='1' limit 1";
                $obj->execute($updateDiscount);
                
                $referrer_id = $obj->select("referee", "users", "ID='$user_id'")[0][0];
                $referrer_id = strtoupper($referrer_id);
                $referrer_id = str_replace("REF", "", $referrer_id);
                $my_order_count = $obj->select("COUNT(ID)", "orders", "user_id='$user_id'")[0][0];
                if($my_order_count == 1)
                {
                    $obj->insert("discount", "referrer_id,user_id,is_used,createdon","'$referrer_id', '$user_id', '1','$today'");
                }
            }
            $order_track = $obj->insert("order_traks", "order_id,track_status,updateon", "'$order_id','1','$today'");
            
            foreach ($order_item as $key => $value)
            {
                $itemId = $value[0];
                $itemQty = $value[1];
                //$itemPrice = $total;
                $dbQty = 0; //defacut value
                $weight = $value[2];

                $products = $obj->select("price,ID,quantity,GST_type,cgst,sgst,discount", "products", "ID='$value[0]'");
                if (is_array($products))
                {
                    $discount = $products[0][6];
                    //actual price - (actual price * (discount / 100))
                    $itemPrice = $products[0][0] - ($products[0][0] * $discount / 100);
                    $dbQty = $products[0][2];
                    $gst_type = $products[0][3];
                    $cgst = $products[0][4];
                    $sgst = $products[0][5];
                }

                //$product_value = $value[0];
                $variant_info = $obj->select("*", "product_variants", "product_id='$itemId' and weight='$weight'");
                $flag = 0;
                if (is_array($variant_info))
                {
                    $itemId = $variant_info[0][4];
                    $itemPrice = $variant_info[0][3] - ($variant_info[0][3] * $discount / 100);
                    $dbQty = $variant_info[0][2];
                    $flag = 1;
                }

                if ($dbQty > $itemQty)
                {
                    $OP_price = $itemPrice * $itemQty;
                    //if Quantity is suficient then actual data save in order_products
                    $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$weight','$gst_type','$cgst','$sgst'");
                    //$insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight","'$order_id', '$itemId', '$itemQty', '$OP_price','$weight'");
                    
                    
                    $qty=$dbQty-$itemQty;
                    if ($flag)
                    {
                        $updatequery = "update product_variants set quantity = '$qty' where product_id='$itemId' and weight='$weight'";
                        $obj->execute($updatequery);
                    }
                    else
                    {
                        $updatequery = "update products set quantity = '$qty' where ID='$itemId'";
                        $obj->execute($updatequery);
                    }
                }
                else
                {
                    $OP_price = $dbQty * $itemPrice;
                    //if Quantity is not suficient then qty =0 and price 0 save in order_products with respect to product id
                    $insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight,gst_type,cgst,sgst", "'$order_id', '$itemId', '$itemQty', '$OP_price','$weight','$gst_type','$cgst','$sgst'");
                    //$insert = $obj->insert("ordered_products", "order_id,product_id,qty,price,weight","'$order_id', '$itemId', '$dbQty', '$OP_price','$weight'");
                    
                    
                    $itemQty = $dbQty;
                    if ($flag)
                    {
                        $updatequery = "update product_variants set quantity = quantity-$itemQty where product_id='$itemId' and weight='$weight'";
                        $obj->execute($updatequery);
                    }
                    else
                    {
                        $updatequery = "update products set quantity = quantity-$itemQty where ID='$itemId'";
                        $obj->execute($updatequery);
                    }

                }

            }

            
            $deleteCart = "delete from cart where User_id='$user_id'";
            $obj->execute($deleteCart);
            
            $player_id=$obj->select("player_id","users","ID='$user_id'")[0][0];
            if($player_id!="")
            {
                $title="Order Placed";
                $message="Your Order ".$order_no." has been placed successfully.";
                                        
                $notification_id = $obj->insert("notification","message,date,user_id","'$message','$today','$user_id'");
                //Send interest notification
                sendnotification($player_id, $title, $message,'orderPlace');
            }
            else{
                $title="Order Placed";
                $message="Your Order ".$order_no." has been placed successfully.";
                                        
                $notification_id = $obj->insert("notification","message,date,user_id","'$message','$today','$user_id'");
            }

            
            //sms to admin on confirmation of order
            $companyName = COMPANY;
            $api_key = SMS_API_KEY;
            $route_id = SMS_API_ID;
            $sender_id = SENDER_ID;
            $compaign = COMPAIGN;
            $admin_mobile_no = ADMIN;
            //admin SMS
            //$messageAdmin = urlencode("Dear Admin,\n You have received a new order #$order_no at $today.\n\n Regards,\nDITRP ClickToBuy");
            //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$admin_mobile_no&senderid=$sender_id&msg=$messageAdmin");

            //user SMS
            //$messageUser = urlencode("Dear $user_name,\n Your order (#$order_no) has been placed successfully. Thank you for using DITRP ClickToBuy.\n\n Regards,\n DITRP ClickToBuy ");
            //$mobileResponse = file_get_contents("http://sms.kutility.com/app/smsapi/index.php?key=$api_key&campaign=$compaign&routeid=$route_id&type=text&contacts=$user_mobile&senderid=$sender_id&msg=$messageUser");

            /*Invoice Generate code start*/

            //include Email Sending file
            
            //admin email for new orders
            include_once ('orderMailAdmin.php');
            $mail->Send();
            $mail->clearAddresses();
            
            //user order email
            include_once ('orderInvoiceMail.php');
            
            if ($mail->Send()):
                header("Location: success.php?msg=Your Order Placed");
            else:
                header("Location: success.php?msg=Mail Not Sent. But Order Placed...");
            endif;
        }
        else
        {
            header("Location: error.php?msg=Cart is empty");
        }
    }
}
else
{
    header("Location: error.php?msg=All field required");
}

?>
 