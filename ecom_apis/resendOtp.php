<?php
include '../common/library.php';
include '../common/constant.php'; 
include '../common/function.php'; 

$smsapik = SMSAPIKEY;
$senderid = SENDERID;
$routeid=ROUTEID;
//$entity_id=ENTITYID;
$campaign_id=CAMPAIGN_ID;

// $_POST['mobile']='7776977382';

if (isset($_POST['mobile']) && $_POST['mobile'] != "")
{
    $mobile_no = $_POST['mobile'];

    $today = CURRENTTIME;
    $record = $obj->select("*", "verify_otp", "mobile = '$mobile_no'");
    if (is_array($record))
    {
        $otp = $record[0][2];
    }
    else
    {
        $otp = rand(1111, 9999);
    }
    
    $message=urlencode("Your Ditrp verification code is ".$otp.".Verification code is valid for 5 minutes only, one time use.From SLITS");
    $mobileResponse = file_get_contents("http://sms.studyleagueitsolutions.com/app/smsapi/index.php?key=".$smsapik."&campaign=".$campaign_id."&routeid=".$routeid."&type=text&contacts=".$mobile_no."&senderid=".$senderid."&msg=".$message."&template_id=".template_id); 
               
    $record = $obj->select("*", "verify_otp", "mobile = '$mobile_no'");
    
    if (is_array($record)):
        $obj->execute("UPDATE verify_otp SET otp='$otp',createdon='$today' WHERE ID=".$record[0][0]);
    else:
        $i = $obj->insert("verify_otp", "mobile,otp,createdon", "'$mobile_no','$otp','$today'");
    endif;
    $data['response'] = "y";
    $data['error'] = false;
    $data['message'] = "Verification code resent";
    echo json_encode($data);

}
else
{
    $data['response'] = "n";
    $data['error'] = true;
    $data['message'] = "All fields arerequired";
    echo json_encode($data);
}

?>
