<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();
$image_array = array();
$variant_array =array();
//$_POST['product_id']='91';



if(isset($_POST['product_id']) && $_POST['product_id']!="")
{
    $product_id =$_POST['product_id'];
	$products = $obj->select("*","products as p, main_categories as m","p.main_category_id=m.ID and	p.status='1' and p.ID='$product_id'");
        
    if(is_array($products)):					
    	foreach($products as $key=>$value):
    	    $productId = $value[0];
            $images = $obj->select("*","product_images","product_id='$value[0]'");
            if(is_array($images)):
             foreach($images as $ikey=>$ivalue):
                  array_push(
                 	$image_array, array(
                 	    'img_id'=>$ivalue[0],
                 	    'img_product'=>LOCAL_IMAGE_PATH.$ivalue[1]
                 	    ));
             endforeach; 
            
            endif;
            
            $variant_array = array();
                    //show product variant for size
                    $variant_info = $obj->select("*", "product_variants", "product_id='$productId' and size_id!=0 and size_id IS NOT NULL group by size_id");

                    if (is_array($variant_info)):
                        foreach ($variant_info as $jkey => $jvalue):
                            $color_array = array();
                            $size_name = $obj->select("size_name", "size", "ID='$jvalue[6]'") [0][0];
                            $color_ids = $obj->select("*", "product_variants", "product_id='$productId' and size_id='$jvalue[6]' AND color_id!=0  AND color_id IS NOT NULL");
                            
                            // $variant_image_array = array();
                            // $variant_images = $obj->select("*", "variant_images", "variant_id='$jvalue[0]' and status!='2'");

                            // if (is_array($variant_images)):
                            //     foreach ($variant_images as $vikey => $vivalue):
                            //         array_push($variant_image_array, array(
                            //             'v_id' => $jvalue[0],
                            //             'img_id' => $vivalue[0],
                            //             'img_product' => LOCAL_IMAGE_PATH . $vivalue[1]
                            //         ));
                            //     endforeach;
                            // endif;
                            
                            
                            if (is_array($color_ids)):
                                foreach ($color_ids as $ckey => $cvalue): 
                                    $color_name = $obj->select("name", "color", "ID='$cvalue[7]'")[0][0];
                                    
                                    $variant_image_array = array();
                                    $variant_images = $obj->select("*", "variant_images", "variant_id='$cvalue[0]' and status='1'");
        
                                    if (is_array($variant_images)):
                                        foreach ($variant_images as $vikey => $vivalue):
                                            array_push($variant_image_array, array(
                                                'v_id' => $cvalue[0],
                                                'img_id' => $vivalue[0],
                                                'img_product' => LOCAL_IMAGE_PATH . $vivalue[1]
                                            ));
                                        endforeach;
                                    endif;
                                    
                                    array_push($color_array, array(
                                        'ID' => $cvalue[7],
                                        'quantity' => $cvalue[2],
                                        'discount' => $value[3],
                                        'final_price' => number_format($cvalue[3] - ($value[3] / 100 * $cvalue[3]) , 2, '.', '') ,
                                        'actual_price' => $cvalue[3],
                                        'product_id' => $cvalue[4],
                                        'color_name' => $color_name,
                                        'color_img' => $variant_image_array
                                    ));
                                endforeach;
                            endif;
                            array_push($variant_array, array(
                                'ID' => $jvalue[6],
                                'weight' => $size_name,
                                'quantity' => $jvalue[2],
                                'discount' => $value[3],
                                'final_price' => number_format($jvalue[3] - ($value[3] / 100 * $jvalue[3]) , 2, '.', '') ,
                                'actual_price' => $jvalue[3],
                                'product_id' => $jvalue[4],
                                'color' => $color_array,
                            ));
                            $actual_price = $jvalue[3];
                        endforeach;

                    endif;

                    // show product variant for color
                    $variant_info = $obj->select("*", "product_variants", "product_id='$productId' and (size_id=0 or size_id IS NULL)");

                    $color_array = array();
                    if (is_array($variant_info)):
                        foreach ($variant_info as $jkey => $jvalue):
                            $variant_image_array = array();
                            $variant_images = $obj->select("*", "variant_images", "variant_id='$jvalue[0]' and status!='2'");

                            if (is_array($variant_images)):
                                foreach ($variant_images as $vikey => $vivalue):
                                    array_push($variant_image_array, array(
                                        'v_id' => $jvalue[0],
                                        'img_id' => $vivalue[0],
                                        'img_product' => LOCAL_IMAGE_PATH . $vivalue[1]
                                    ));
                                endforeach;
                            endif;
                            
                            
                            $color_name = $obj->select("name", "color", "ID='$jvalue[7]'");
                            if (is_array($color_name)):
                                foreach ($color_name as $ckey => $cvalue):
                                    array_push($color_array, array(
                                        'ID' => $jvalue[7],
                                        'quantity' => $jvalue[2],
                                        'discount' => $value[3],
                                        'final_price' => number_format($jvalue[3] - ($value[3] / 100 * $jvalue[3]) , 2, '.', '') ,
                                        'actual_price' => $jvalue[3],
                                        'product_id' => $jvalue[4],
                                        'color_name' => $cvalue[0],
                                        'color_img' => $variant_image_array
                                    ));
                                endforeach;
                            endif;
                            $actual_price = $jvalue[3];
                        endforeach;
                    endif;
            
            // $variant_info = $obj->select("*", "product_variants", "product_id='$product_id'");
            // if(is_array($variant_info)):					
            //  foreach($variant_info as $ikey=>$kvalue):
            //       array_push(
            //      	$variant_array, array(
            //      	    'ID'=>$kvalue[0],
            //      	    'weight'=>$kvalue[1],
            //      	    'quantity'=>$kvalue[2],
            //      	    'final_price'=> number_format(($kvalue[3]- ($value[3] / 100 * $kvalue[3])), 2, '.', ''),
    			     //   'actual_price'=>$kvalue[3],
            //      	    'product_id'=>$product_id
            //      	    ));
            //  endforeach; 
            
            // endif;
            
    //         array_push(
    // 	    	$result_array, array(
    // 			'name'=>html_entity_decode($value[1],ENT_QUOTES),
    // 			'final_price'=> number_format(($value[2]- ($value[3] / 100 * $value[2])),2),
    // 			'actual_price'=>$value[2],
    // 			'discount'=>$value[3],
    // 			'qty' =>$value[4],
    // 			'variant'=>$variant_array,
    // 		    'images'=>$image_array    
    // 			));
    			
            endforeach;
       endif;
          
            $price=number_format(($value[2] - ($value[3] / 100 * $value[2])), 2, '.', '');
     
            $data["response"] = 'y';
            $data['error'] = false;
            $data["message"] = 'Success';
    		$data["ID"] = $value[0];
            $data["name"] = html_entity_decode($value[1],ENT_QUOTES);
            $data["category_name"] = html_entity_decode($value[19],ENT_QUOTES);
            $data["description"] = html_entity_decode($value[7],ENT_QUOTES);
            $data["final_price"] = $price;
    		$data["actual_price"] = $value[2];
    		$data["discount"] = $value[3];
    		$data["qty"] = $value[4];
    		$data["variant"] = $variant_array;
    		$data["images"]= $image_array; 
    		$data["color"]= $color_array;
            echo json_encode($data);
}
else{
    
        $data["response"] = 'n';
        $data['error'] = TRUE;
        $data["message"] = 'All fields are required';
        echo json_encode($data);
}

?>