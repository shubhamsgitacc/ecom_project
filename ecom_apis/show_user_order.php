<?php
include '../common/library.php';
include '../common/constant.php';

$order_array = array();
 
//  $_POST['user_id']=16;

 
if(isset($_POST['user_id']) && $_POST['user_id']!="")
{
    
    $user_id=  $_POST['user_id'];
    $user_order_info = $obj->select("*","orders","user_id='$user_id'  order by ID DESC");
    if(is_array($user_order_info))
    {
        foreach($user_order_info as $okey=>$ovalue)
        {
            $order_id = $ovalue[0];
            $invoice_path = $ovalue[19];
            $invoice_name = $ovalue[20];
            
            $variant_size_name="";
            $variant_color_name="";
            
                    $order_info = $obj->select("*","orders","ID ='$order_id'");
                    
                    $orderProduct_info = $obj->select("*","ordered_products","order_id='$order_id'");
                    // print_r($orderProduct_info);exit;
                    $order_product_array = array();
                    if(is_array($orderProduct_info))
                    {      
                         foreach($orderProduct_info as $key=>$value)
                         {
                             $product_id = $value[2];
                             $productInfo = $obj->select("name,description","products","ID='$product_id'");
                             $product_name = $productInfo[0][0];
                             $product_description = $productInfo[0][1];
                             $product_img = $obj->select("*","product_images","product_id='$product_id'");
                             $image_path = $product_img[0][1];
                             $product_desc = $productInfo[0][1];
                             $product_qty = $value[3];
                             $product_price = $value[4];
                            //  print_r($value[5]);exit;
                            $variant_size_name=$value[5];
                            $variant_color_name=$value[9];
                             
                            if($variant_color_name=="N")
                			{
                				$variant_color_name = "";
                			}
                			if($variant_size_name=="N")
                			{
                				$variant_size_name = "";
                			}
                			
                			
                             if($variant_color_name!="" || $variant_size_name!="")
                             {
                                 $product_name=$product_name.' ('.$variant_size_name.' '.$variant_color_name.')';
                             }
                             
                             array_push($order_product_array,array(
                                 'Product_id'=>$product_id,
                                 'Product_name'=>$product_name,
                                 'Product_img'=>LOCAL_IMAGE_PATH.$image_path,
                                //  'Product_description'=>$product_description,
                                 'Product_qty' =>$product_qty,
                                 'Product_price'=>$product_price,
                                 'Product_weight'=>$variant_size_name,
                                 'Product_color'=>$variant_color_name
                                 ));
                             
                         }
                   }
                   //order array detail
                   if(is_array($order_info)) 
                   {
                        $user_id = $order_info[0][2]; 
                        $user_add_id =$order_info[0][8];
                        $status_id = $order_info[0][9];
                        $coupon_id = $order_info[0][6];
                        $placement_date = date('d-m-Y',strtotime($order_info[0][7]));
                        $delivery_date =  date('d-m-Y',strtotime($order_info[0][10]));
                        $total =  $order_info[0][3];
                        $discount =  $order_info[0][4];
                        $finalTotal =  $order_info[0][5];
                        $deliveryCharge = $order_info[0][12];
                        $payment_mode = $order_info[0][14];
                        
                        //$user_info = $obj->select("name","users","ID='$user_id'");
                        //$user_name = $user_info[0][0];
                        
                        $status = $obj->select("status","order_status","ID='$status_id'");
                        $status_name = $status[0][0];
                        
                       
                         $user_add_info = $obj->select("user_name, user_contact, user_add, landmark, pin_code","addresses","ID='$user_add_id'");
                         $coupon_info = $obj->select("*","coupons","ID='$coupon_id'");
                         
                         $coupon_name = $coupon_info[0][1];
                 
                         $user_name = $user_add_info[0][0];
                         $user_add = $user_add_info[0][2];
                         $user_contact = $user_add_info[0][1];
                         $user_landmark = $user_add_info[0][3];
                         $user_pincode = $user_add_info[0][4];
                         
                         
                        array_push($order_array,array(
                            'ID' => $order_info[0][0],
                            'order_number' => $order_info[0][1],
                            'username'=>$user_name,
                            'address'=>$user_add,
                            'contact'=>$user_contact,
                            'landmark'=>$user_landmark,
                            'pincode'=>$user_pincode,
                            'total'=>$total,
                            'discount'=>$discount,
                            'final_total'=>$finalTotal,
                            'DeliveryCharge'=>$deliveryCharge,
                            'status'=>$status_name,
                            'delivery_date'=>$delivery_date,
                            'placement_date'=>$placement_date,
                            'payment_mode'=>$payment_mode,
                            'invoice_path'=>LOCAL_IMAGE_PATH.$invoice_path,
                            'invoice_name'=>$invoice_name,
                            'coupon_name'=>$coupon_name,
                            'Products'=>$order_product_array
                            ));
                        
                   }
                   
                }
        }
        
}

    $data["response"] = 'y';
    $data['error'] = false;
    $data["message"] = 'Success';
    $data['result_array'] = $order_array;
    echo json_encode($data);
    
?>