<?php
//include ('../common/library.php');
//include ('../common/function.php');
//include ('../common/constant.php');
//include ('../common/EmailConfig/configMail.php');
//include ('../common/tcpdf/tcpdf.php');
//setlocale(LC_MONETARY, 'en_IN.UTF-8');

$admin_msg = "<html>
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
                                                <td colspan='2' align='center'><h1 style='margin-top:15px;'>NEW ORDER RECEIVED</h1></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2' ><h3>Dear Admin,</h3></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2' >You have received this message in response to the New Order Placed on Choice Maker.<br><br></td>
                                            </tr>
                                           
                                            <tr>
                                                <td colspan='2'>Order Number Is : <b>$order_no</b></td>
                                            </tr>
                                            <tr>
                                                <td colspan='2'>Placed on  <b>$today</b></td>
                                            </tr>";
            $admin_msg .= $body;
            $admin_msg .= "  <td><br></td>
                                             <tr>
                                                <td colspan='2'>Total amount <b>₹ $amount</b></td>
                                            </tr>
                                            <td><br></td>
                                             <td><br></td>
                                         </tbody>
                                    </table>
                                 </body>
                            </html>";

$mail->AddAddress(ADMINEMAIL);
//$mail->AddAddress('tester.studyleagueit@gmail.com');
$mail->IsHTML(true);
$mail->Subject = 'New Order Received';
$mail->Body = $admin_msg;
//$mail->addAttachment($serverPath.'img/invoice/invoice_' . $order_no . '.pdf');
$mail->addAttachment($_SERVER['DOCUMENT_ROOT'] . '/img/invoice/invoice_' . $order_no . '.pdf');
?>