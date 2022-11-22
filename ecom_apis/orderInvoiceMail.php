<?php
// include ('../common/library.php');
// include ('../common/function.php');
// include ('../common/constant.php');
// include ('../common/EmailConfig/configMail.php');
// include ('../common/tcpdf/tcpdf.php');
// setlocale(LC_MONETARY, 'en_IN.UTF-8');
$server_path = SERVERPATHS;

            $invoice_no = "CM-INVC-" . time();
            // $order_id=31;
            $order = $obj->select("*","orders","ID='$order_id'");
            if(is_array($order)){
                foreach($order as $key=>$value){
                			$id= $value[0];
                			$order_no= $value[1];
                			$address_id = $value[8];
                			$user_id = $value[2];
                			$coupon_id =$value[6];
                			$final_amount = $value[5];
                			$deliveryCharge = $value[12];
                			$final_discount = $value[4];
                			$paymentDate = new DateTime($value[7]);
                			$orderDate=$paymentDate->format('d M y');
                			$paymentType = $value[14];
                			
                			$userDetail = $obj->select("*","users","ID='$user_id'");
                            //Getting User detail for email
                            if(is_array($userDetail))
                            {
                                $reg_username = $userDetail[0][1];
                                $email = $userDetail[0][3];
                            }
                            
                            $get_user_add = $obj->select("*", "addresses", "ID='$address_id'");
                            $user_name = $get_user_add[0][2];
                            $user_phone = $get_user_add[0][3];
                            $user_add = $get_user_add[0][4]."<br/>".$get_user_add[0][5]." - ".$get_user_add[0][6];

            $message = "<html>
                                <head>
                                <style type='text/css'>
                                .restable{
                                    width:35%;
                                }
                                @media(max-width:500px){
                                            .restable {
                                            width:100%;
                                        }
                                }
                                </style>
                                </head>
                                 <body>
                                    <table class='restable' style='height:auto;min-width:348px;' border='0' cellspacing='0' cellpadding='0' align='center'>
                                        <tbody>
                                            <tr height='32px'>
                                             <td colspan='2' align='right'><img src='$server_path/img/choice-maker-logo.jpeg' style='width:150px;'></td>
                                            </tr>
                                            <tr>
                                             <td><br></td>
                                            </tr>
                                            <tr align='center' style='background-color:#007f00;color:#FFFFFF'>
                                                <td colspan='2' align='center'><h1 style='margin-top:15px;'>YOUR ORDER IS PLACED</h1></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2' ><h3>Dear $reg_username,</h3></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2' >You have received this message in response to your Order Placed on Choice Maker.<br><br></td>
                                            </tr>
                                           
                                            <tr>
                                                <td colspan='2'>Your Order Number Is : <b>$order_no</b></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2'>Placed on  <b>$orderDate</b></td>
                                            </tr>";
            $message .= $body;
            $message .= "  <td><br></td>
                                             <tr>
                                                <td colspan='2'>Total amount <b>₹ $final_amount</b></td>
                                            </tr>
                                            <td><br></td>
                                             <td><br></td>
                                            <tr>
                                                <td>Sincerely,<br>Choice Maker</td>
                                            </tr>
                                         </tbody>
                                    </table>
                                 </body>
                            </html>";

            $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
            $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
            $pdf->SetAutoPageBreak(true, PDF_MARGIN_BOTTOM);

            if (@file_exists(dirname(__FILE__) . '/lang/eng.php'))
            {
                require_once (dirname(__FILE__) . '/lang/eng.php');
                $pdf->setLanguageArray($l);
            }
            $pdf->SetFont('helvetica', '', 15);
            $pdf->AddPage('L');
            
            $html='<!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <title>Invoice</title>
                        <style type="text/css">
                            p,
                            h5,
                            h3{
                                margin: 0;
                            }
                            th{
                                font-size: 12px;
                            }
                            td,p{
                                font-size: 11px;
                            }
                        </style>
                    </head>
                <body>
                <table width="100%">
                    <thead>
                        <tr>
                            <th align="left">
                                <img src="'.$server_path.'/img/choice-maker-logo.jpeg" alt="logo" width="200">
                            </th>
                            <th align="right">
                                <h5>CHOICE MAKER</h5>
                                <p>A-Wing, Flat No. 105, Attarwala Apt,Hathi Mohalla, Vasai West, Palghar, Mumbai, 401201, Maharashtra, India</p>
                                <p>GST NO. 27ESGPS1144R1Z0</p>
                            </th>
                        </tr>
                    </thead>
            
                    <tbody>
                        <tr>
                            <td colspan="2" align="center">
                                <h1>TAX INVOICE</h1>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <p>Invoice No.: '.$invoice_no.'</p>
                                <p>Invoice Date: '.$orderDate.'</p>
                                <p>Order ID: '.$order_no.'</p>
                                <p>Order Type: '.$paymentType.'</p>
                            </td>
                            <td align="right">
                                <p>Ship To:</p>
                                <h3>'.$user_name.'</h3>
                                <p>'.$user_add.'</p>
                                <p>'.$user_phone.'</p>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br/>
                <br/>
                <table  width="90%" align="center">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th width="20%">Item</th>
                            <th>Qty</th>
                            <th>Unit Price</th>
                            <th>Effective Price</th>
                            <th>CGST%</th>
                            <th>CGST Amount</th>
                            <th>SGST%</th>
                            <th>SGST Amount</th>
                            <th>Total</th>
                        </tr>
                    </thead>
            
                    <tbody align="center">';
            
                $order_detail = $obj->select("*","ordered_products","order_id='$order_id'");
                	if(is_array($order_detail)){
                	    $size="";
                        $color="";
                		foreach($order_detail as $order_key=>$order_value){
                		    $product_id=$order_value[2];
                		    $size=$order_value[5];
                		    $color=$order_value[9];
                		    $variant_id=$order_value[10];
                		    $sr_no=$order_key+1;
                		    if($color=="N")
                			{
                				$color = "";
                			}
                			else if($size=="N")
                			{
                				$size = "";
                			}
            
            $html.='<br/><tr>
                    <td>'.$sr_no.'</td>';
            
                $products = $obj->select("price,ID,quantity,GST_type,cgst,sgst,discount,name", "products", "ID='$product_id'");
                    if (is_array($products))
                    {
                        $discount = round($products[0][6],2);
                        //actual price - (actual price * (discount / 100))
                        $itemPrice = $products[0][0] - ($products[0][0] * $discount / 100);
                        $dbQty = $products[0][2];
                        $gst_type = $products[0][3];
                        $cgst = $products[0][4];
                        $sgst = $products[0][5];
                        $product_name = $products[0][7];
                    }
    
                    $variant_info = $obj->select("*", "product_variants", "ID='$variant_id'");

                    if (is_array($variant_info))
                    {
                    $itemId = $variant_info[0][4];
                    $itemPrice = $variant_info[0][3] - ($variant_info[0][3] * $discount / 100);
                    $dbQty = $variant_info[0][2];
                    }
                    
                    $sub_total=$itemPrice*$order_value[3];
                    
                    $cgst_cost=0;
                    $sgst_cost=0;
                    if($cgst!=0 && $sgst!=0){
                        $cgst_cost=round($sub_total* ($cgst / 100),2);
                        $sgst_cost=round($sub_total* ($sgst / 100),2);
                    }
                    $eff_price=round($sub_total-$cgst_cost-$sgst_cost,2);
                    
                    $unit_price=round($eff_price / $order_value[3],2);
                    
                    $pdf_total += $sub_total;
            
            
            $html.='<td width="20%">'.$product_name.'&nbsp;'.$size.'&nbsp;'.$color.'</td>
                    <td>'.$order_value[3].'</td>
                    <td>'.$unit_price.'</td>
                    <td>'.$eff_price.'</td>
                    <td>'.$cgst.'%</td>
                    <td>'.$cgst_cost.'</td>
                    <td>'.$sgst.'%</td>
                    <td>'.$sgst_cost.'</td>
                    <td>'.$sub_total.'</td>
                </tr>';
                		}
                	}
            $html.='
                <br/>
                </tbody>
        
                <tfoot>
                    <tr>
                        <td colspan="10" align="right">Discount - '.$final_discount.'</td>
                    </tr>
                    <tr>
                        <td colspan="10" align="right">Delivery Charge + '.$deliveryCharge.'</td>
                    </tr>
                    <tr>
                        <td colspan="10" align="right">Mode Of Payment '.$paymentType.'</td>
                    </tr>';
                    $grand_total=round($pdf_total-$final_discount+$deliveryCharge,2);
                $html.='<tr>
                    <td colspan="10" align="right">Grand Total Rs.'.$grand_total.'</td>
                    </tr> 
                </tfoot>
            </table>
                
            <hr>
                
            <h3 align="center">Thank you!</h3>
                
            <p align="center">This is computer generated invoice, therefore does not required any signature</p>
        </body>
    </html>';

                }
            }
            $pdf->writeHTML($html, true, 0, true, 0);
            $pdf->lastPage();
            ob_clean();
			ob_end_clean();
            $pdf->Output($_SERVER['DOCUMENT_ROOT'] . 'img/invoice/invoice_' . $order_no . '.pdf', 'F');

            if($email!= null || $email!="")
            {
                $mail->AddAddress($email);
                $mail->IsHTML(true);
                $mail->Subject = 'Your Order Status';
                $mail->Body = $message;
                $mail->addAttachment($_SERVER['DOCUMENT_ROOT'] . '/img/invoice/invoice_' . $order_no . '.pdf');
            }
            $invoice_path=$serverpath.'img/invoice/invoice_' . $order_no . '.pdf';
            $invoice_name='invoice_' . $order_no . '.pdf';
            
            $updateInvoice = "update orders set invoice_path = '$invoice_path',invoice_name='$invoice_name' where ID='$order_id'";
            $obj->execute($updateInvoice);
            
            //echo "<a href=../".$invoice_path.">Invoice File</a>";
            ?>