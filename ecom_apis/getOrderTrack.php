<?php
include '../common/library.php';
include '../common/constant.php';
//SELECT `ID`, `User_id`, `procuct_id`, `qty`, `createdon`, `updatedon`
$result_array = array();
// $_POST['order_id']='DITRP1622529827';

// error_log(print_r($_POST,TRUE));

if(isset($_POST['order_id']) && $_POST['order_id']!=""):
    
    $order_no = $_POST['order_id'];
    
    $orderDetail = $obj->select("ID","orders","order_no ='$order_no' AND status<=4");
    
    if(is_array($orderDetail))
    {
        $orderid= $orderDetail[0][0];
        $ordertrack_info = $obj->select("*","order_traks","order_id ='$orderid' ORDER BY track_status ASC");
        
        if(is_array($ordertrack_info))
        {
             foreach($ordertrack_info as $key=>$value):
                array_push($result_array,
                      array(
                          'status'=>$value[2],
                          'updatedon'=>$value[3]
                        )); 
                 
            endforeach;     
        }
    
    }
endif;
echo json_encode(array('result'=>$result_array));
?>