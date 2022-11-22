<?php
include '../common/library.php';
include '../common/constant.php';
 
// $_POST['coupon_name'] = "admin20";
// $_POST['order_amt'] = "200";
// $_POST['user_id']=14;

if(isset($_POST['coupon_name'])  && $_POST['coupon_name'] != "" &&
isset($_POST['order_amt'])  && $_POST['order_amt'] != "" &&
isset($_POST['user_id'])  && $_POST['user_id'] != ""){
    
    $user_id = $_POST['user_id'];
    $coupon_name = $_POST['coupon_name'];
    $order_amt = $_POST['order_amt'];
    $today = CURRENTDATE;
    $show_discount = TRUE;
    $record = $obj->select("*", "coupons", "coupon_name='$coupon_name' and status =1");
    if (is_array($record)):
        $coupon_id=$record[0][0];
        
        //   $couponUsed = $obj->select("COUNT(ID)", "orders", "coupon_id='$coupon_id' AND user_id='$user_id'");
          $couponUsed = $obj->select("COUNT(ID)", "orders", "coupon_id='$coupon_id'");
            if ($couponUsed[0][0] < $record[0][2]){
                if($record[0][7] >= $today){
                    if($order_amt >= $record[0][3]){
                        $value = $record[0][4];
                        $value_type = $record[0][5];
                        $start_date = $record[0][6];
                        $end_date = $record[0][7];
                        
                          $coupons = $obj->select("*", "coupons", "coupon_name='$coupon_name' and  start_date<='$today' and expiry_date>='$today'") ;
                            //if(date('Y-m-d',strtotime($today)) >= date('Y-m-d',strtotime($startdate)) && date('Y-m-d',strtotime($today))<=date('Y-m-d',strtotime($endDate)))
                            if(is_array($coupons))
                            {
                                $coupon_type =$coupons[0][11];
                                if($value_type == "Percent"){
                                     $discounted_amnt =  ($order_amt*$value/100);
                                    $final_amnt = $order_amt - $discounted_amnt;
                                }else{
                                    $discounted_amnt =  $value;
                                    $final_amnt = $order_amt - $discounted_amnt;
                                }
                                
                                $data['response'] = 'y';
                                $data['error']    = FALSE;
                                $data['final_amount']= $final_amnt;
                                $data['discount_amount']= $discounted_amnt;
                                
                                if($coupon_type == 'Discount')
                                {
                                   $show_discount = TRUE;  
                                   $data['is_show'] = $show_discount;
                                   $data['message']  = 'Coupon applied successfully';
                                }
                                else
                                {
                                    $show_discount = false;
                                    $data['is_show'] = $show_discount;
                                    $data['message']  = 'You get '.$discounted_amnt.' cashback on order completion';
                                }
                                
                                echo json_encode($data);
                            }
                            else
                            {
                                $data["response"]='n';
                                $data['error'] = TRUE;
                                $data["message"]='Coupon expaire';
                                echo json_encode($data);
                            }
                        
                    }else{
                        $data["response"]='n';
                        $data['error'] = TRUE;
                        $data["message"]='Min. order amount should be ₹ '.$record[0][3];
                        echo json_encode($data);
                    }
                }else{
                    $data["response"]='n';
                    $data['error'] = TRUE;
                    $data["message"]='Coupon Expired';
                    echo json_encode($data);
                }
          }
          else{
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='Coupon used for maximum number of times';
            echo json_encode($data);
          }
    else:
            $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='Coupon code does not exist';
            echo json_encode($data);
    endif;
}else{
    $data["response"]='n';
    $data['error'] = TRUE;
    $data["message"]='All fields required';
    echo json_encode($data);
}


?>