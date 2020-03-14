import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:ireg/classes/VisitorsClass.dart';

class Services{

  static const String url =   'https://naragenergy.com/ireg/api/visitors';
  static Future<String> saveVisitor(String name,String phoneNumber,String address,String purpose,String tagNo,DateTime dateAndTimeIn,DateTime dateAndTimeOut) async{

    try{
      final response = await http.post(url,  headers: {'content-type' : 'application/json'}, body: jsonEncode({'name': '$name', 'phoneNumber': '$phoneNumber', 'address': '$address', 'purpose': '$purpose', 'tagNo': '$tagNo', 'dateAndTimeIn': '$dateAndTimeIn', 'dateAndTimeOut': '$dateAndTimeOut' ,'status':'IN'}));
  
      if(response.statusCode==200){
        String result = parse(response.body);
       return result;
     }else {

     
      throw Exception(response.statusCode);
     }
   }
   catch(e){
     throw Exception(e.toString());
   }
  }

  
static String parse(String responseBody){

    final parsed = json.decode(responseBody)["status"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }
 static String parseError(String responseBody){

    final parsed = json.decode(responseBody)["error"]["message"];
    return parsed.toString();//.map<PhoneActivation>((json)=> PhoneActivation.fromJson(json)).toList();
  }
}