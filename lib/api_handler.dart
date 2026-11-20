import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/model.dart';

class ApiHandler {
  final String baseUri="https://localhost:7052/api/utenze";
  Future<List<Utenze>> getUserData() async{
    List<Utenze> data= [];
    final uri= Uri.parse(baseUri);
    try{
      final response =await http.get(
        uri,
        headers:<String, String>{
          'Content-type' : 'application/json; charsert=UTF-8'
        }

      );
      if (response.statusCode >= 200 && response.statusCode <=299){
        final List<dynamic> jsonData= json.decode(response.body);
        data =jsonData.map((json)=> Utenze.fromJson(json)).toList();
      }
    }catch(e){
      return data;
    }
    return data;
  }
}