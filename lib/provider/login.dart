import 'package:flutter/material.dart';
/*Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Color.fromRGBO(9, 162, 241, 1),
              borderRadius: BorderRadius.only(
                    bottomRight: const  Radius.circular(60.0)
              )
            ),
            child: Image(
              height: 80,
              width: 80,
              image: AssetImage(
                "assets/images/Logo Sante Odonto.png"
              ),
            ),   
          ), */
class Loguearse with ChangeNotifier{
  String _token;
  bool _logueado;
  String _seleccionada;
  String _nomeSeleccionada;
  get token{
    return this._token;
  }
  set token(String nome){
    this.token = nome;
    notifyListeners();
  }
  get logueado{
    return this._logueado;
  }
  set logueado(bool nome){
    this._logueado = nome;
    notifyListeners();
  }
  getSeleccionda(){
    return this._seleccionada;
  }
  getNomeSeleccionda(){
    return this._nomeSeleccionada;
  }
}