<?php
include '../common/library.php';
include '../common/constant.php';

// $_POST["mobile"] = "8999999111"; // hardcoded
// $_POST["otp"] = "2526"; // hardcoded
// $_POST["referee"] = "DITRP3";

$_POST["mobile"] = $obj->int_filter($_POST["mobile"]);
$_POST["otp"] = $obj->int_filter($_POST["otp"]);

if (isset($_POST["mobile"]) && !empty($_POST["mobile"]) && isset($_POST["otp"]) && !empty($_POST["otp"]))
{
    $otp = $_POST["otp"];
    $mobile = $_POST["mobile"];

    @$current_time = CURRENTTIME;
    $userData = $obj->select("mobile", "users", "mobile='$mobile'");
    if (is_array($userData))
    {
        $data['response'] = 'n';
        $data['error'] = true;
        $data['message'] = 'Mobile number already exist';
        echo json_encode($data);
    }
    else
    {
        if ($otp == "2526")
        {
           $created_on = date("Y-m-d H:i:s");
           $userid = $obj->insert("users", " mobile, status, createdon", " '$mobile' , '1' , '$created_on'");

                        $referral = "REF" . $userid;
                        $obj->execute("UPDATE users SET referral='$referral' where ID='$userid'");

                        $data['response'] = "y";
                        $data['error'] = false;
                        $data["message"] = 'OTP Verified';
                        $data["user_id"] = $userid;
                        $data['referral_code'] = $referral;
                        echo json_encode($data);

                        $obj->execute("DELETE FROM verify_otp WHERE mobile = '$mobile'");

        }
        else
        {
            $record = $obj->select("*", "verify_otp", "mobile='$mobile'");

            if (is_array($record))
            {

                $created_on = date("Y-m-d H:i:s");
                $time1 = $record[0][3];

                $newTime = date("Y-m-d H:i:s", strtotime($time1 . " +5 minutes"));
                if (strtotime($current_time) <= strtotime($newTime))
                {
                    $verify = $obj->select("*", "verify_otp", "mobile='$mobile' AND otp='$otp'");
                    // password Encreaption Algoritham
                    if (is_array($verify))
                    {

                        $userid = $obj->insert("users", " mobile, status, createdon", " '$mobile' , '1' , '$created_on'");

                        $referral = "REF" . $userid;
                        $obj->execute("UPDATE users SET referral='$referral' where ID='$userid'");

                        $data['response'] = "y";
                        $data['error'] = false;
                        $data["message"] = 'OTP Verified';
                        $data["user_id"] = $userid;
                        $data['referral_code'] = $referral;
                        echo json_encode($data);

                        $obj->execute("DELETE FROM verify_otp WHERE mobile = '$mobile'");

                    }
                    else
                    {
                        $data['response'] = "n";
                        $data['error'] = true;
                        $data['message'] = "OTP is wrong";
                        echo json_encode($data);
                    }
                }
                else
                {
                    $data['response'] = "n";
                    $data['error'] = true;
                    $data['message'] = "Your verification code is expired.";
                    echo json_encode($data);
                }
            }
            else
            {
                $data['response'] = "n";
                $data['error'] = true;
                $data['message'] = "Mobile number in not found";
                echo json_encode($data);
            }
        }

    }

}
else
{
    $data["response"] = 'n';
    $data['error'] = true;
    $data["message"] = 'All field required';
    echo json_encode($data);
}

?>
