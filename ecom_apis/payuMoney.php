<?php

require('../common/library.php');
require('../common/constant.php');


$MERCHANT_KEY = MERCHANT_KEY;
$SALT = SALT;
// Merchant Key and Salt as provided by Payu.

$action = '';

$server_url=SERVERPATHS.'app_apis/';

//https://studyleagueit.com/ditrpEcommerce/app_apis/paymentParameter.php
// $_POST['amount']=50;
// $_POST['firstname']='Shubham';
// $_POST['lastname']='Gupta';
// $_POST['email']='shubham@gmail.com';
// $_POST['phone']=8286100926;
// $_POST['test_id']=2;
// $_POST['user_id']=2;
// $_POST['type']="Online";

//error_log(print_r($_POST, true));
if (isset($_POST['user_id']) && $_POST['user_id'] != "")
{
    
    $user_id= $_POST['user_id'];
    $is_referal = $_POST['is_referal'];
    $deliveryCharge = $_POST['deliveryamount'];
    $total = $_POST['total'];
    $order_amount = $total;
    $address_id = $_POST['address_id'];
    //error_log(print_r($_POST, true));
    //user detail 
    $users= $obj->select("name, mobile, email","users","ID='$user_id'");
    if(is_array($users))
    {
       $username = $users[0][0];
       $usermobile = $users[0][1];
       $useremail = $users[0][2];
    }
    
    $discounted_amnt = $_POST['discounted_amnt'];
    $coupon_id = $_POST['coupon_id'];
    
    $_POST['email']=$useremail;
    $_POST['phone']=$usermobile;
    $_POST['firstname']=$username;
    $_POST['user_id']=$user_id;
    $_POST['type']="Online";
    
    $_POST['key']=$MERCHANT_KEY;
    $_POST['productinfo']='test';
    
    $_POST['service_provider']='payu_paisa';
    
    
    $amount = $total - $discounted_amnt + $deliveryCharge;
    
    $_POST['amount']=$amount;
    $key=$MERCHANT_KEY;
    
    $productinfo=$_POST['productinfo'];

    $surl=$server_url.'placeOrderOnline.php';   //payment success url
    $furl=$server_url.'error.php?msg=Something went wrong';  //payment failed url
    
    $_POST['surl']=$surl;
    $_POST['furl']=$furl;

    $_POST['udf1']=$user_id;   //user id
    $_POST['udf2']=$coupon_id; //coupon id
    $_POST['udf3']=$address_id; //address id
    $_POST['udf4']=$deliveryCharge; //delivery charges
    $_POST['udf5']=$discounted_amnt.','.$is_referal.','.$total.','.$coupon_id; //discount amount, is_referal value, total amount without delivery charge and discount amount
    //$_POST['udf6']=$is_referal; //is_referal value
    //$_POST['udf7']=$total; //total amount without delivery charge and discount amount
    

    $PAYU_BASE_URL = "https://sandboxsecure.payu.in";		// For Sandbox Mode /Test mode
    //$PAYU_BASE_URL = "https://secure.payu.in";			// For Production Mode
    
    $action = '';
    
    $posted = array();
    if(!empty($_POST)) {
        
      foreach($_POST as $key => $value) {    
        $posted[$key] = $value; 
      }
    }
    
    //error_log(print_r($posted,true));
    
    $formError = 0;
    
    if(empty($posted['txnid'])) {
      // Generate random transaction id
      $txnid = substr(hash('sha256', mt_rand() . microtime()), 0, 20);
      $posted['txnid'] = $txnid;
    } else {
      $txnid = $posted['txnid'];
    };
    
    //$hash = '';
    $posted['hash'] = $hash;
    // Hash Sequence
    $hashSequence = "key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";
    if(empty($posted['hash']) && sizeof($posted) > 0) {
      if(
              empty($posted['key'])
              || empty($posted['txnid'])
              || empty($posted['amount'])
              || empty($posted['firstname'])
              || empty($posted['email'])
              || empty($posted['phone'])
              || empty($posted['productinfo'])
              || empty($posted['surl'])
              || empty($posted['furl'])
    		  || empty($posted['service_provider'])
      ) 
      {
        $formError = 1; 
      } 
      else 
      {
        //$posted['productinfo'] = json_encode(json_decode('[{"name":"tutionfee","description":"","value":"500","isRequired":"false"},{"name":"developmentfee","description":"monthly tution fee","value":"1500","isRequired":"false"}]'));
    	$hashVarsSeq = explode('|', $hashSequence);
        $hash_string = '';	
    	foreach($hashVarsSeq as $hash_var) {
          $hash_string .= isset($posted[$hash_var]) ? $posted[$hash_var] : '';
          $hash_string .= '|';
        }
    
        $hash_string .= $SALT;
    
        $hash = strtolower(hash('sha512', $hash_string));
        $action = $PAYU_BASE_URL . '/_payment';
        
      }
    } elseif(!empty($posted['hash'])) {
        
      $hash = $posted['hash'];
      
      $action = $PAYU_BASE_URL . '/_payment';
      
    }

?>    
<html>
  <head>

  </head>
  <body onload="submitPayuForm()">
    <!--<h2>PayU Form</h2>-->
    <form action="<?php echo $action; ?>" method="post" name="payuForm" style="display:none;">
      <input type="hidden" name="key" value="<?php echo $MERCHANT_KEY ?>" />
      <input type="hidden" name="hash" value="<?php echo $hash ?>"/>
      <input type="hidden" name="txnid" value="<?php echo $txnid ?>" />
      <table>
        <tr>
          <td><b>Mandatory Parameters</b></td>
        </tr>
        <tr>
          <td>Amount: </td>
          <td><input type="hidden" name="amount" value="<?php echo (empty($posted['amount'])) ? '' : $posted['amount'] ?>" /></td>
          <td>First Name: </td>
          <td><input type="hidden" name="firstname" id="firstname" value="<?php echo (empty($posted['firstname'])) ? '' : $posted['firstname']; ?>" /></td>
        </tr>
        <tr>
          <td>Email: </td>
          <td><input name="email" id="email" value="<?php echo (empty($posted['email'])) ? '' : $posted['email']; ?>" /></td>
          <td>Phone: </td>
          <td><input name="phone" value="<?php echo (empty($posted['phone'])) ? '' : $posted['phone']; ?>" /></td>
        </tr>
        <tr>
          <td>Product Info: </td>
          <td colspan="3"><textarea name="productinfo"><?php echo (empty($posted['productinfo'])) ? '' : $posted['productinfo'] ?></textarea></td>
        </tr>
        <tr>
          <td>Success URI: </td>
          <td colspan="3"><input type="hidden" name="surl" value="<?=$surl;?>" size="64" /></td>
        </tr>
        <tr>
          <td>Failure URI: </td>
          <td colspan="3"><input type="hidden" name="furl" value="<?=$furl;?>" size="64" /></td>
        </tr>

        <tr>
          <td colspan="3"><input type="hidden" name="service_provider" value="payu_paisa" size="64" /></td>
        </tr>
        
        <tr>
          <td colspan="3"><input type="hidden" name="user_id" value="<?=$_POST['user_id'];?>" size="64" /></td>
        </tr>
        
        <tr>
          <td colspan="3"><input type="hidden" name="type" value="<?=$_POST['type'];?>" size="64" /></td>
        </tr>
        
        <tr>
          <td><b>Optional Parameters</b></td>
        </tr>
        <tr>
          <td>UDF1: </td>
          <td><input name="udf1" value="<?php echo (empty($posted['udf1'])) ? '' : $posted['udf1']; ?>" /></td>
          <td>UDF2: </td>
          <td><input name="udf2" value="<?php echo (empty($posted['udf2'])) ? '' : $posted['udf2']; ?>" /></td>
        </tr>
        <tr>
          <td>UDF3: </td>
          <td><input name="udf3" value="<?php echo (empty($posted['udf3'])) ? '' : $posted['udf3']; ?>" /></td>
          <td>UDF4: </td>
          <td><input name="udf4" value="<?php echo (empty($posted['udf4'])) ? '' : $posted['udf4']; ?>" /></td>
        </tr>
        <tr>
          <td>UDF5: </td>
          <td><input name="udf5" value="<?php echo (empty($posted['udf5'])) ? '' : $posted['udf5']; ?>" /></td>
          <td>UDF6: </td>
          <td><input name="udf6" value="<?php echo (empty($posted['udf6'])) ? '' : $posted['udf6']; ?>" /></td>
        </tr>
        <tr>
          <td>UDF7: </td>
          <td><input name="udf7" value="<?php echo (empty($posted['udf7'])) ? '' : $posted['udf7']; ?>" /></td>
          <td>UDF8: </td>
          <td><input name="udf8" value="<?php echo (empty($posted['udf8'])) ? '' : $posted['udf8']; ?>" /></td>
        </tr>
        <tr>
          <td>UDF9: </td>
          <td><input name="udf9" value="<?php echo (empty($posted['udf9'])) ? '' : $posted['udf9']; ?>" /></td>
          <td>UDF10: </td>
          <td><input name="udf10" value="<?php echo (empty($posted['udf10'])) ? '' : $posted['udf10']; ?>" /></td>
        </tr>
        <tr>
          <?php if(!$hash) { ?>
            <td colspan="4"><input type="submit" value="Submit" /></td>
          <?php } ?>
        </tr>
      </table>
    </form>
  </body>
    <script type='text/javascript'>
        function submitPayuForm()
        {
            document.payuForm.submit();    
        }
        
        </script>
    <script>
    // var hash = '<?php echo $hash ?>';
    // alert(hash);
    
    // var payuForm = document.forms.payuForm;
    // payuForm.submit();
    
    // function submitPayuForm() {
    //   if(hash == '') {
    //     return;
    //   }
    //   var payuForm = document.forms.payuForm;
    //   payuForm.submit();
    // }
  </script>
</html>

<?php
}
else
{
    $data['response'] = "n";
    $data['error'] = true;
    $data['message'] = "All field required";
    echo json_encode($data);
}
?>