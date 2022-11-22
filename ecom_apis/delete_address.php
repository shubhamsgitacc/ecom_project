<?php
include '../common/library.php';
include '../common/constant.php';

// $_POST['addrs_id'] = "8";


if(isset($_POST['addrs_id']) && $_POST['addrs_id']!="")
{
        
        $add_id= $_POST['addrs_id'];   
        $orders = $obj->select("count(*)","orders","address_id='$add_id'");
        $count = $orders[0][0];
        
        if($count == 0 )
        {
            $query = "delete from addresses where ID='$add_id'";     
            $obj->execute($query);
                
              
            $data["response"]='y';
            $data['error'] = FALSE;
            $data["message"]='Address is deleted successfully';
            echo json_encode($data);
        }
        else
        {
             $data["response"]='n';
            $data['error'] = TRUE;
            $data["message"]='Address data is used in order detail';
            echo json_encode($data);
        }
           
}
else
{
        $data["response"]='n';
        $data['error'] = TRUE;
        $data["message"]='All fields required';
        echo json_encode($data);
}
?>