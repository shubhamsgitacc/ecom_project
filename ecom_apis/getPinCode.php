<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();


$result = $obj->select("*", "pin_codes","1");
if (is_array($result))
{
    foreach ($result as $key => $value):
        array_push($result_array, array(
            'ID' => $value[0],
            'pincode' => $value[1],
            'deliveryCharge'=> $value[2]
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
