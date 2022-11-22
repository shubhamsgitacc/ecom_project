<?php
include '../common/library.php';
include '../common/constant.php';

$result_array = array();

$_POST['category_id'] = 2;

if (isset($_POST['category_id']) && $_POST['category_id'] != "")
{

    $category_id = $_POST['category_id'];

    $result = $obj->select("*", "sub_categories", "main_category_id=$category_id and status='1'");

    if (is_array($result))
    {

        foreach ($result as $ckey => $cvalue)
        {
            $product_array = array();


            $sub_category_id = $cvalue[0];
           
            $category_name = $cvalue[1];

            $product_detail = $obj->select("*", "products as p, main_categories as m", "p.main_category_id=m.ID and p.main_category_id  ='$category_id' and p.sub_category_id='$sub_category_id' and p.status='1' ");
            
            if (is_array($product_detail))
            {
                foreach ($product_detail as $key => $value)
                {
                    $image_array = array();
                    $productId = $value[0];
                    $variant_array =array();
                    
                    $images = $obj->select("*", "product_images", "product_id='$productId'");

                    if (is_array($images)):
                        foreach ($images as $ikey => $ivalue):
                            array_push($image_array, array(
                                'img_id' => $ivalue[0],
                                'img_product' => LOCAL_IMAGE_PATH . $ivalue[1]
                            ));
                        endforeach;

                    endif;
                    
                    $variant_info =$obj->select("*", "product_variants", "product_id='$productId'");
                    
                    if (is_array($variant_info)):
                        foreach ($variant_info as $jkey => $jvalue):
                            array_push($variant_array, array(
                                'ID' => $jvalue[0],
                                'weight' => $jvalue[1],
                                'quantity' => $jvalue[2],
                                'discount' => $value[3],
                                'final_price' => number_format($jvalue[3] - ($value[3] /100 * $jvalue[3] ), 2, '.', ''),
                                'actual_price' => $jvalue[3],
                                'product_id' => $jvalue[4],
                            ));
                        endforeach;

                    endif;
                    
                    if(is_array($variant_info) && $value[3])
                    {
                        $value[3]='0';
                    }

                    array_push($product_array, array(
                        'ID' => $value[0],
                        'name' => html_entity_decode($value[1], ENT_QUOTES) ,
                        'category_name' => html_entity_decode($value[19],ENT_QUOTES),
                        'final_price' =>number_format(($value[2] - ($value[3]/100)*$value[2]), 2, '.', '') ,
                        'actual_price' => $value[2],
                        'discount' => $value[3],
                        'qty' => $value[4],
                        'description'=>html_entity_decode($value[7],ENT_QUOTES),
                        'category_name' => $category_name,
                        'images' => $image_array,
                        'variant'=>$variant_array
                    ));

                }
            }

            array_push($result_array, array(
                'ID' => $sub_category_id,
                'name' => $category_name,
                // 'image_path'=>LOCAL_IMAGE_PATH.$cvalue[2],
                'products' => $product_array
            ));
        }

    }
}
$data["response"] = 'y';
$data['error'] = false;
$data["message"] = 'Success';
$data['result_array'] = $result_array;
echo json_encode($data);

