<?php
include '../common/library.php';
include '../common/constant.php';


// $_POST['name']='sarita koshti';
// $_POST['email']='yawkar.sarita@gmail.com';
// $_POST['message']='test tesst test';
// $_POST['contact']='8097186562';

if(isset($_POST['name']) && $_POST['name']!="" &&
isset($_POST['email']) && $_POST['email']!="" &&
isset($_POST['message']) && $_POST['message']!="" && 
isset($_POST['mobile']) && $_POST['mobile']!="")
{
      $name= htmlentities(ucfirst($_POST['name']), ENT_QUOTES);
      $email = $_POST['email'];
      $contact = $_POST['mobile'];
      $message = htmlentities($_POST['message'], ENT_QUOTES);
      $created_on = DATETIMEFORMAT;
      
      $obj->insert("enquiry","name, email, message,createdon,contact","'$name','$email','$message','$created_on','$contact'");
      
        $data['response']="y";
        $data['error']=FALSE;
        $data['message']="Enquiry submitted. We will contact you soon.";
        echo json_encode($data);
}
else
{
     $data['response']="n";
            $data['error']=TRUE;
            $data['message']="All fields required";
            echo json_encode($data);
}
?>