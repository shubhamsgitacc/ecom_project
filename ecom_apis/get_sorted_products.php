<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();

// $_POST['category_id'] = 2;

    // $_POST['sort_by']='price DESC';
    // $_POST['category_id']='9';
    // $_POST['subcategory_id']='7';
    
    //error_log(print_r($_POST,TRUE));

    if (isset($_POST['category_id']) && $_POST['category_id'] != ""
        && isset($_POST['subcategory_id']) && $_POST['subcategory_id'] != "")
    {

    $sort_by = $_POST['sort_by'];
    
    $category_id = $_POST['category_id'];
    
    $subcategory_id = $_POST['subcategory_id'];

    $product_array = array();
    
    $product_id_array = array();
    
    $sorted_product_array = array();
    
    if($sort_by==="price DESC" || $sort_by==="price ASC"){
    
    $sort_product = $obj->select("*", "products", "main_category_id='$category_id' and sub_category_id='$subcategory_id' and status='1'");
    
    if (is_array($sort_product))
    {
        foreach ($sort_product as $spkey => $spvalue)
        {
            $sort_productId = $spvalue[0];
            array_push($product_id_array, $sort_productId);
        }
        
        $product_id_array = array_unique($product_id_array);
        
        foreach($product_id_array as $skey => $sproductID)
        {
            $product_id = $sproductID;
            $sort_product = $obj->select("*", "products", "ID='$product_id'");
            
            $sort_variant_info=$obj->select("*", "product_variants", "product_id='$product_id'");
            
            if (is_array($sort_variant_info)){
                $price = number_format(($sort_variant_info[0][3] - ($sort_product[0][3] /100 * $sort_variant_info[0][3])), 2, '.', '');
            }
            else{
                $price = number_format(($sort_product[0][2] - ($sort_product[0][3] /100 * $sort_product[0][2])), 2, '.', '');
            }
            
            array_push($sorted_product_array, array(
                'product_id' => $product_id,
                'final_price' => $price
            ));
        }
        
        if($sort_by==="price DESC"){
            array_multisort(array_column($sorted_product_array, 'final_price'), SORT_DESC, $sorted_product_array);
        }elseif($sort_by==="price ASC"){
            array_multisort(array_column($sorted_product_array, 'final_price'), SORT_ASC, $sorted_product_array);
        }
        
        foreach ($sorted_product_array as $sorted_key => $sorted_value){
            
            $sorted_product_id = $sorted_value['product_id'];
            
            $product_detail = $obj->select("*", "products", "ID='$sorted_product_id'");
            if (is_array($product_detail))
            {
                foreach ($product_detail as $key => $value)
                {
                    $image_array = array();
                    $productId = $value[0];
                    
                    $category_array=array();
                       
                    $category_name = $obj->select("main_category_name","main_categories","ID='$value[5]'")[0][0];
                    if(is_array($category_name)):
                        foreach($category_name as $ckey=>$cvalue):
                            array_push(
                             	$category_array, array(
                             	    'category_name' => html_entity_decode($cvalue[1],ENT_QUOTES)
                             	    ));
                        endforeach; 
                    endif;
                    $images = $obj->select("*", "product_images", "product_id='$productId'");
        
                    if (is_array($images)):
                        foreach ($images as $ikey => $ivalue):
                            array_push($image_array, array(
                                'img_id' => $ivalue[0],
                                'img_product' => LOCAL_IMAGE_PATH . $ivalue[1]
                            ));
                        endforeach;
        
                    endif;
                    
                    
                    $variant_array =array();
                    $variant_info = $obj->select("*", "product_variants", "product_id='$productId' and size_id!=0 and size_id IS NOT NULL group by size_id");
                            
                    if (is_array($variant_info)):
                        foreach ($variant_info as $jkey => $jvalue):
                            $color_array = array();
                            $size_name = $obj->select("size_name", "size", "ID='$jvalue[6]'") [0][0];
                            $color_ids = $obj->select("*", "product_variants", "product_id='$productId' and size_id='$jvalue[6]' AND color_id!=0  AND color_id IS NOT NULL");
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
        
                    array_push($product_array, array(
                        'ID' => $value[0],
                        'name' => html_entity_decode($value[1], ENT_QUOTES) ,
                        'category_name' => html_entity_decode($category_name),
                        'final_price' =>number_format(($value[2] - ($value[3]/100)*$value[2]), 2, '.', '') ,
                        'actual_price' => $value[2],
                        'discount' => $value[3],
                        'qty' => $value[4],
                        'description'=>html_entity_decode($value[7],ENT_QUOTES),
                        'images' => $image_array,
                        'variant'=>$variant_array,
                        'color' => $color_array
                    ));
                }
            }
        }
    }
    }else{
        $product_detail = $obj->select("*", "products", "main_category_id='$category_id' and sub_category_id='$subcategory_id' and status='1' ORDER BY $sort_by");
        if (is_array($product_detail))
        {
                foreach ($product_detail as $key => $value)
                {
                    $image_array = array();
                    $productId = $value[0];
                    $variant_array =array();
                    
                    $category_array=array();
                       
                    $category_name = $obj->select("main_category_name","main_categories","ID='$value[5]'")[0][0];
                    if(is_array($category_name)):
                        foreach($category_name as $ckey=>$cvalue):
                            array_push(
                             	$category_array, array(
                             	    'category_name' => html_entity_decode($cvalue[1],ENT_QUOTES)
                             	    ));
                        endforeach; 
                    endif;
                    $images = $obj->select("*", "product_images", "product_id='$productId'");
        
                    if (is_array($images)):
                        foreach ($images as $ikey => $ivalue):
                            array_push($image_array, array(
                                'img_id' => $ivalue[0],
                                'img_product' => LOCAL_IMAGE_PATH . $ivalue[1]
                            ));
                        endforeach;
        
                    endif;
                    
                    $variant_array =array();
                    //show product variant for size
                    $variant_info = $obj->select("*", "product_variants", "product_id='$productId' and size_id!=0 and size_id IS NOT NULL group by size_id");

                    if (is_array($variant_info)):
                        foreach ($variant_info as $jkey => $jvalue):
                            $color_array = array();
                            $size_name = $obj->select("size_name", "size", "ID='$jvalue[6]'") [0][0];
                            $color_ids = $obj->select("*", "product_variants", "product_id='$productId' and size_id='$jvalue[6]' AND color_id!=0  AND color_id IS NOT NULL");
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
        
                    array_push($product_array, array(
                        'ID' => $value[0],
                        'name' => html_entity_decode($value[1], ENT_QUOTES) ,
                        'category_name' => html_entity_decode($category_name),
                        'final_price' =>number_format(($value[2] - ($value[3]/100)*$value[2]), 2, '.', '') ,
                        'actual_price' => $value[2],
                        'discount' => $value[3],
                        'qty' => $value[4],
                        'description'=>html_entity_decode($value[7],ENT_QUOTES),
                        'images' => $image_array,
                        'variant'=>$variant_array,
                        'color' => $color_array
                    ));
                }
            }
    }
}
$data["response"] = 'y';
$data['error'] = false;
$data["message"] = 'Success';
$data['result_array'] = $product_array;
echo json_encode($data);