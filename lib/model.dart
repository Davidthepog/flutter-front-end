//import 'package:flutter/foundation.dart';

class Utenze {
  final int? id;
  final int? idruolo;
  final String  cognome;
  final String nome;
  final String email;
  


const Utenze ({
  required this.id,
  required this.idruolo,
  required this.cognome,
  required this.nome,
  required this.email
});


  factory Utenze.fromJson(Map<String,dynamic>json)=> Utenze(
  id: json['id'],
  idruolo: json['idruolo'],
  cognome: json['cognome'],
  nome: json['nome'],
  email: json['email'] );
  Map<String,dynamic> toJson()=>{
    'id':id,
    'idruolo':idruolo,
    'cognome':cognome,
    'nome':nome,
    'email':email
  };
  
}


