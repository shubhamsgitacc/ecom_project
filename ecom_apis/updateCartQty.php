<?php
include '../common/library.php';
include '../common/constant.php';

//$_POST['user_id'] = "16";
//$_POST['products'] = '[{"data1":"191","data4":"2","data6":"2","data9":"","itemQty":0},{"data1":"190","data4":"2","data6":"2","data9":"2","itemQty":0},{"data1":"190","data4":"1","data6":"3","data9":"1","itemQty":0},{"data1":"196","data4":"1","data6":"","data9":"1","itemQty":0}]';

$result_array = array();
$product_array = array();
$Total = 0;
$tooltip = "";
$is_referal = false;
error_log(print_r($_POST,TRUE));
if (isset($_POST['user_id']) && $_POST['user_id'] != "" && isset($_POST['products']) && $_POST['products'] != "")
{
    $user_id = $_POST['user_id'];
    $products = $_POST['products'];
    $flag = 0;
    $ServiceCharge = 0;
    $grandTotal = 0;
    $discount_rs = 0;
    $products = (array)json_decode($products, true);

    if (is_array($products))
    {
        $deleteQuery = "delete from cart where User_id='$user_id'";
        $obj->execute($deleteQuery);
        
        $variant_size_name="";
        $variant_color_name="";
        foreach ($products as $pkey => $pvalue)
        {
            $cartProduct_id = $pvalue['data1'];
            $cartQty = $pvalue['data4'];
            $size_id = $pvalue['data6'];
            $color = $pvalue['data9'];
            $product_info = $obj->select("*", "products", "ID='$cartProduct_id'");
            
            if(($size_id!="0" || $size_id!="" || $size_id!=null) && ($color!="0" || $color!="" || $color!=null)){
                $variant_info = $obj->select("*", "product_variants", "product_id='$cartProduct_id' and size_id='$size_id' and color_id='$color'");
                $variant_size_name = $obj->select("size_name", "size", "ID='$size_id'")[0][0];
                $variant_color_name = $obj->select("name", "color", "ID='$color'")[0][0];
            }
            else if($size_id!="0" || $size_id!="" || $size_id!=null){
                $variant_info = $obj->select("*", "product_variants", "product_id='$cartProduct_id' and size_id='$size_id'");
                $variant_size_name = $obj->select("size_name", "size", "ID='$variant_size_id'")[0][0];
            }
            else if($color!="0" || $color!="" || $color!=null){
                $variant_info = $obj->select("*", "product_variants", "product_id='$cartProduct_id' and color_id='$color'");
                $variant_color_name = $obj->select("name", "color", "ID='$variant_color_id'")[0][0];
            }
            
            if($variant_color_name=="N")
			{
				$variant_color_name = "";
			}
			if($variant_size_name=="N")
			{
				$variant_size_name = "";
			}
			
            $variant_qty = $variant_info[0][2];
            

            if (is_array($product_info))
            {
                $db_qty = $product_info[0][4];
                $product_name = html_entity_decode($product_info[0][1],ENT_QUOTES);
                $product_discount = $product_info[0][3];
                $product_price = number_format(($product_info[0][2] - ($product_discount / 100 * $product_info[0][2])) , 2, '.', '');
                $createdon = DATETIMEFORMAT;
                $updatedon = DATETIMEFORMAT;

                if (is_array($variant_info))
                {
                    $product_price = number_format(($variant_info[0][3] - ($product_discount / 100 * $variant_info[0][3])) , 2, '.', '');
                    $db_qty = $variant_info[0][2];
                    $product_name = html_entity_decode($product_info[0][1].' ('.$variant_size_name.' '.$variant_color_name.')',ENT_QUOTES);
                }

                if ($cartQty <= $db_qty)
                {
                    // echo $cartQty; echo "<br>"; echo $db_qty;echo "<br>";`color`
                    //  print_r($product_price);exit;
                    //new data insert in cart and update qty if already in cart
                    $checkProduct = $obj->select("*", "cart", "procuct_id='$cartProduct_id' and User_id='$user_id' and weight='$size_id' and color='$color'");
                    if (is_array($checkProduct))
                    {
                        $id = $checkProduct[0][0];
                        $updateQuery = "update cart set qty='$cartQty',updatedon='$updatedon',procuct_id='$cartProduct_id',User_id='$user_id',weight='$size_id',color='$color' where ID='$id'";
                        $obj->execute($updateQuery);
                        $finalQty = $cartQty;
                    }
                    else
                    {
                        $obj->insert("cart", "User_id, procuct_id, qty, createdon, updatedon ,weight,price,color", "'$user_id','$cartProduct_id','$cartQty','$createdon','$updatedon','$size_id','$product_price','$color'");
                        $finalQty = $cartQty;
                    }

                }
                else
                {
                    $cartError = true;
                    //$option = "Available quantity for " . $product_name . " - " . $variant_size_name .  " - " . $variant_color_name . " is " . $db_qty;
                    $option = "Available quantity for " . $product_name ." is " . $db_qty;
                    //make it dynamic
                    if ($cartError)
                    {
                        $data['error'] = true;
                        $data['message'] = $option;
                    }
                    else
                    {
                        $data['error'] = false;
                    }
                    echo json_encode($data);
                    exit;

                    // if ($db_qty != 0) {
                    //     //new data insert in cart and update qty if already in cart
                    //     $checkProduct = $obj->select("*", "cart", "procuct_id='$cartProduct_id' and User_id='$user_id'");
                    //     if (is_array($checkProduct)) {
                    //         $id          = $checkProduct[0][0];
                    //         $updateQuery = "update cart set qty='$db_qty',updatedon='$updatedon',procuct_id='$cartProduct_id',User_id='$user_id' where ID='$id'";
                    //         $obj->execute($updateQuery);
                    //         $finalQty = $db_qty;
                    //     }
                    // }
                    
                } //end else
                $Total = number_format($Total + ($finalQty * $product_price) , 2, '.', '');
                $grandTotal = $Total;
            }

            $product_image = $obj->select("image_path", "product_images", "product_id ='$cartProduct_id' limit 1");

            if (is_array($product_image))
            {
                $pimage = $product_image[0][0];
                array_push($product_array, array(
                    'product_id' => $cartProduct_id,
                    'Qty' => $finalQty,
                    'product_name' => $product_name,
                    'product_price' => $product_price,
                    'final_price' => number_format($product_price * $finalQty , 2, '.', ''),
                    'weight' => $variant_size_name,
                    'product_img' => LOCAL_IMAGE_PATH . $pimage
                ));
            }
        }

        // $serviceCharge = $obj->select("minAmt,maxAmt,charges","deliveryCharges","1");
        // if(is_array($serviceCharge))
        // {
        //   $tooltip .="Charges based on order amount<br>";
        //     foreach($serviceCharge as $skey=>$svalue)
        //     {
        //         if($svalue[0]<=$Total && $svalue[1]>=$Total)
        //         {
        //             $ServiceCharge = $svalue[2];
        //         }
        //         $tooltip .="&#8377;".$svalue[0]." to &#8377;".$svalue[1]." = &#8377;".$svalue[2]."<br>";
        //     }
        // }
        

        $userid = $obj->select("*", "discount", "referrer_id='$user_id' and is_used='1'");
        if (is_array($userid))
        {
            $dis = $obj->select("*", "constant", "1");
            $xpercent = $dis[0][1];
            $yoff = $dis[0][2];
            $is_referal = true;
            $discount_rs = $xpercent / 100 * $grandTotal;
            if ($discount_rs <= $yoff)
            {
                $grandTotal = number_format(($grandTotal - $discount_rs) + $ServiceCharge , 2, '.', '');
            }
            else
            {
                $discount_rs = $yoff;
                $grandTotal = number_format(($grandTotal - $discount_rs) + $ServiceCharge , 2, '.', '');
            }
        }
        else
        {
            $grandTotal = number_format($grandTotal + $ServiceCharge , 2, '.', '');
        }

        array_push($result_array, array(
            'Total' => $Total,
            'is_referal' => $is_referal,
            'Referral_Discount' => number_format($discount_rs , 2, '.', ''),
            'GrandTotal' => $grandTotal,
            'ServiceCharge' => $ServiceCharge,
            'Tooltip' => $tooltip,
            'product_list' => $product_array
        ));

    }

}

$data['error'] = false;
$data['result'] = $result_array;
echo json_encode($data);

?>
