
import 'dart:convert';

import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/webservices/get.dart';
import 'package:http/http.dart' as http;

import '../models/postProductdetailpage.dart';
Map? getProductdetailsres;

  Postfromjsonproduct postfromjsonproduct=Postfromjsonproduct();
  List<Postfromjsonproduct> postfromjsonproductdata=[];


 Future postdata( id) async {
  int ids=int.parse(id);
  
  final http.Response response = await http.post(
    Uri.parse('https://web.stellarinfosys.com/choicemaker/app_apis/getProductDetails.php'),
    
    body: {
      'product_id': id.toString(),
    },
        
 
  );
    
    
  
  
  getProductdetailsres=jsonDecode(response.body);
  if(getProductdetailsres!=null){
  postfromjsonproduct=Postfromjsonproduct.fromJson(getProductdetailsres!);
  

    
  }
  else {
    print('nothing');
  }
  print(postfromjsonproduct.name);
 
  return postfromjsonproduct;
  
  }
