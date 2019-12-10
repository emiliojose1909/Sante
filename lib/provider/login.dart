import 'package:flutter/material.dart';
import '../Clases/professional.dart';

class Loguearse with ChangeNotifier{
  bool _logueado;
  Professional professional;
  User user;
  String client;
  String uid;
  String accessToken;
  loguearse(bool logueo, Professional prof, User user, String client, String uid, String token){
    this.logueado = logueo;
    this.professional = prof;
    this.user = user;
    this.client = client;
    this.uid = uid;
    this.accessToken = token;
    notifyListeners();
  }
  getlogueado(){
    return this._logueado;
  }
  getProffessional(){
    return this.professional;
  }
  set logueado(bool nome){
    this._logueado = nome;
    notifyListeners();
  }
}