<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();

// $_POST['user_id']=39;
$user_id='';
if (isset($_POST['user_id']) && $_POST['user_id'] != "" ){
    $user_id=$_POST['user_id'];
}

$user_account_created_time = $obj->select("createdon", "users","ID='$user_id'")[0][0];

$result = $obj->select("*", "notification","(user_id='$user_id' OR user_id IS NULL) AND date >= '$user_account_created_time' ORDER BY id DESC");

if (is_array($result))
{
    foreach ($result as $key => $value):
        array_push($result_array, array(
            'ID' => $value[0],
            'message'=>$value[1],
            'date'=>$value[2]
    ));
    endforeach;

    $data["response"] = 'y';
    $data['error'] = false;
    $data["message"] = 'Data found';
    $data['result_array'] = $result_array;
    echo json_encode($data);
}
else
{
    $data["response"] = 'n';
    $data['error'] = true;
    $data["message"] = 'No result found';
    $data['result_array'] = $result_array;
    echo json_encode($data);
}
?>