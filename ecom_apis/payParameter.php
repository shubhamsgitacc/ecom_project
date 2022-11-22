<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, X-Requested-With");

include '../common/library.php';
include '../common/constant.php';

// $_GET['user_id']=16;
// $_GET['is_referal']='false';
// $_GET['deliveryamount'] = 25;
// $_GET['total'] = 250;
// $_GET['address_id'] = 8;
// $_GET['test_id']=2;
// $_GET['type']="Online";


if(isset($_GET['total']) && $_GET['total']!="" && isset($_GET['address_id']) && $_GET['address_id']!="" && isset($_GET['user_id']) && $_GET['user_id']!="")
{
    //&& isset($_GET['type']) && $_GET['type']!=""

    $is_referal = $_GET['is_referal'];
    $deliveryCharge = $_GET['deliveryamount'];
    $total = $_GET['total'];
    $address_id = $_GET['address_id'];
    
    $user_id=$_GET['user_id'];
    
    $userData=$obj->select("name,mobile,email","users","ID='$user_id'");   
        
    $name=$userData[0][0];
    $phone=$userData[0][1];
    $email=$userData[0][2];
    $discounted_amnt = 0;
    $coupon_id = '';
    if ($is_referal == 'false')
    {
        if (isset($_GET['coupon_code']) && $_GET['coupon_code'] != "")
        {
            $coupon_name = $_GET['coupon_code'];
            $_SESSION['coupon_name'] = $coupon_name;
            $coupon_data = $obj->select("*", "coupons", "coupon_name='$coupon_name' and status='1'");
            if (is_array($coupon_data))
            {
                $coupon_id = $coupon_data[0][0];
                $value = $coupon_data[0][4];
                $valueType = $coupon_data[0][5];
                $startdate = $coupon_data[0][6];
                $endDate = $coupon_data[0][7];
                $minOrderAmount = $coupon_data[0][3];
                $couponUsed = $obj->select("COUNT(ID)", "orders", "coupon_id='$coupon_id' AND user_id='$user_id'");
                if ($couponUsed[0][0] < $coupon_data[0][2])
                {

                    $coupons = $obj->select("*", "coupons", "coupon_name='$coupon_name'");
                    //if(date('Y-m-d',strtotime($today)) >= date('Y-m-d',strtotime($startdate)) && date('Y-m-d',strtotime($today))<=date('Y-m-d',strtotime($endDate)))
                    if (is_array($coupons))
                    {
                        $coupon_id = $coupons[0][0];
                        if ($total >= $minOrderAmount)
                        {
                            if ($valueType == "Percent")
                            {
                                $discounted_amnt = ($total * $value / 100);
                            }
                            else
                            {
                                $discounted_amnt = $value;
                            }
                        }
                        else
                        {
                            //$message ="Coupon Minimum Amount is ".$minOrderAmount;
                            header("Location: error.php?msg=Coupon minimum amount is " . $minOrderAmount);
                            exit();
                        }
                    }
                    else
                    {
                        header("Location: error.php?msg=Coupon expiry");
                        exit();
                    }
                }
                else
                {
                    header("Location: error.php?msg=Coupon used for maximum number of times");
                    exit();
                }
            }
            else
            {
                header("Location: error.php?msg=Invalid Coupon");
                exit();
            }
        }
    }
    else
    {
        $discountArray = $obj->select("*", "discount", "referrer_id='$user_id' and is_used='1'");
        if (is_array($discountArray))
        {
            $dis = $obj->select("*", "constant", "1");
            $xpercent = $dis[0][1];
            $yoff = $dis[0][2];
            $is_referal = 'true';
            $discount_rs = $xpercent / 100 * $total;
            if ($discount_rs <= $yoff)
            {
                $discounted_amnt = $discount_rs;
            }
            else
            {
                $discounted_amnt = $yoff;
            }
        }
    }
?>
<html>
    <head>

  </head>
  <body onload="submitPayuForm()">
        <form name='fr' action='payuMoney.php' method='POST'>
            <input type='hidden' name='firstname' value='<?=$name;?>'>
            <input type='hidden' name='email' value='<?=$email;?>'>
            <input type='hidden' name='phone' value='<?=$phone;?>'>
            <input type='hidden' name='user_id' value='<?=$user_id;?>'>
            <!--<input type='hidden' name='test_id' value='<?=$_GET['test_id'];?>'>-->
            <input type='hidden' name='is_referal' value='<?=$is_referal;?>'>
            <input type='hidden' name='deliveryamount' value='<?=$deliveryCharge;?>'>
            <input type='hidden' name='discounted_amnt' value='<?=$discounted_amnt;?>'>
            <input type='hidden' name='coupon_id' value='<?=$coupon_id;?>'>
            <input type='hidden' name='total' value='<?=$total;?>'>
            <input type='hidden' name='address_id' value='<?=$address_id;?>'>
            <input type='hidden' name='productinfo' value='Test'> 
        </form>
        <script type='text/javascript'>
        function submitPayuForm()
        {
            document.fr.submit();    
        }
        
        </script>
    </body>
</html>
<?php
}
else
{
    header("Location: error.php?msg=All field required");
}
?>