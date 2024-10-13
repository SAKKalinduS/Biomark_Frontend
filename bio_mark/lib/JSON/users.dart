
import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users 
{
  final int? usrId;
  final String? fullName;
  final String? dob;
  final String? mother;
  final String? besty;
  final String? pet;
  final String? ownQuestion;

  final String? email;
  final String password;

  Users({
    this.usrId,
    this.fullName,
    this.dob,
    this.mother,
    this.besty,
    this.pet,
    this.ownQuestion,
    this.email,
    required this.password,
  });

  //These json value must be same as your column name in database that we have already defined
  //one column didn't match
  factory Users.fromMap(Map<String, dynamic> json) => Users
  (
    usrId: json["usrId"],
    fullName: json["fullName"],
    dob: json["dob"],
    mother: json["mother"],
    besty: json["besty"],
    pet: json["pet"],
    ownQuestion: json["ownQuestion"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => 
  {
    "usrId": usrId,
    "fullName": fullName,
    "dob": dob,
    "mother": mother,
    "besty": besty,
    "pet" :pet,
    "ownQuestion" :ownQuestion,
    "email": email,
    "password": password,
  };
}
