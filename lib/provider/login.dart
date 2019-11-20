import 'package:flutter/material.dart';
import '../Clases/professional.dart';

class Loguearse with ChangeNotifier{
  bool _logueado;
  Professional professional;
  User user;
  loguearse(bool logueo, Professional prof, User user){
    this.logueado = logueo;
    this.professional = prof;
    this.user = user;
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