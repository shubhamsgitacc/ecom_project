<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();
$today = CURRENTDATE;

$result = $obj->select("*", "coupons", "status=1 and start_date<='$today' and expiry_date>='$today' ORDER BY ID DESC");
if (is_array($result))
{
    foreach ($result as $key => $value):
            if(strcmp($value[5],"Percent")==0 || strcmp($value[5],"percent")==0 )
            {
                $detail = "Get $value[4] % off on minimum order of ₹ $value[3], expiring on $value[7] ";
            }
            else
            {
                $detail = "Get ₹ $value[4] off on minimum order of ₹ $value[3], expiring on $value[7]";
            }
        array_push($result_array, array(
            'ID' => $value[0],
            'code' => $value[1],
            'detail'=>$detail
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
