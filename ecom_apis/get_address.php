<?php
include '../common/library.php';
include '../common/constant.php';

// $_POST['user_id'] = "16";

$address_array = array();
$pincode_array = array();

if(isset($_POST['user_id']) && $_POST['user_id']!="")
{
        $pin_codes = $obj->select("*", "pin_codes","1");
        if (is_array($pin_codes))
        {
            foreach ($pin_codes as $key1 => $value1):
                array_push($pincode_array, array(
                    'ID' => $value1[0],
                    'pincode' => $value1[1],
                    'deliveryCharge'=> $value1[2]
                ));
        
            endforeach;
        }
        
        $add_id= $_POST['user_id'];
        $address = $obj->select("*","addresses","user_id='$add_id'");
        
        if(is_array($address))
        {
            foreach($address as $key=>$value)
            {
                $name = html_entity_decode($value[2],ENT_QUOTES);
                $add = html_entity_decode($value[4],ENT_QUOTES);
                $landmark= html_entity_decode($value[5],ENT_QUOTES); 
                
                $pincode=$value[6];
                $delivery_charge = $obj->select("charges", "pin_codes","pincode='$pincode'")[0][0];
                
                  array_push($address_array,array(
                      'ID'=>$value[0],
                      'name'=>$name,
                      'mobile'=>$value[3],
                      'address'=>$add,
                      'landmark'=>$landmark,
                      'pincode'=>$pincode,
                      'delivery_charge'=>$delivery_charge,
                      'pin_code_array'=>$pincode_array
                      )); 
                   
            }
            
            $data["response"] = 'y';
            $data['error'] = false;
            $data["message"] = 'Data Sent Success';
            $data['result_array'] = $address_array;
            echo json_encode($data);
           
        }
        else{
            $data["response"] = 'n';
            $data['error'] = TRUE;
            $data["message"] = 'No data found';
            $data['result_array'] = $address_array;
            echo json_encode($data);
        }
}


?>