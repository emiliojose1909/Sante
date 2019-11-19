import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../provider/login.dart';
import '../herramientas.dart';
class LoginPage extends StatefulWidget {
  final VoidCallback _onSignIn;
  
  LoginPage({@required onSignIn})
      : assert(onSignIn != null),
        _onSignIn = onSignIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  // maintains validators and state of form fields
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // esta es la llamada asincrona del progress HUD widget
  bool _isInAsyncCall = false;

  bool _isInvalidAsyncUser = false; // managed after response from server
  bool _isInvalidAsyncPass = false; // managed after response from server

  String _username;
  String _password;
  bool _isLoggedIn = false;

  // validaciones de username
  String _validateUserName(String userName) {
    if (userName.length < 4) {
      return 'E-mail deve ter 4 characters';
    }

    if (_isInvalidAsyncUser) {
      // disable message until after next async call
      _isInvalidAsyncUser = false;
      return 'E-mail Invalido';
    }
    return null;
  }

  // validate password
  String _validatePassword(String password) {
    if (password.length < 3) {
      return 'Senha deve ter min 3 characters';
    }

    if (_isInvalidAsyncPass) {
      // disable message until after next async call
      _isInvalidAsyncPass = false;
      return 'Senha Invalida';
    }

    return null;
  }
  
  Future _submit() async {
    final login = Provider.of<Loguearse>(context); 
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      // dismiss keyboard during async call
      FocusScope.of(context).requestFocus(new FocusNode());
      // start the modal progress HUD
      setState(() {
        _isInAsyncCall = true;
      });

      Future.delayed(Duration(seconds: 1), () async { 
        var body = json.encode({
            "email": _username,
            "password": _password,
        });
        print(body);
        final response = await http.post('https://mobile.santeodonto.io/api/v1/auth/sign_in',  body: body);
        print(response.body); 
        print(response.statusCode); 
        if (response.statusCode == 200) {
          print(json.decode(response.body));
          var dato = json.decode(response.body);
         
           setState(() {
             _isLoggedIn = true;
             _isInvalidAsyncUser = false;
             _isInvalidAsyncPass = false;
             _isInAsyncCall = false; //la llamada para des'sincronizar la funcion
           });
        }else  if(response.statusCode == 202){      
          var dato = json.decode(response.body);         
          msgbox(dato['errors'], 'Erro', context);
          setState((){
            _isLoggedIn = false;
            _isInAsyncCall = false;
            _isInvalidAsyncUser = true;
          });
        }else{
          var dato = json.decode(response.body);
          msgbox(dato['errors'].toString(), 'Erro', context);
          setState((){
            _isLoggedIn = false;
            _isInAsyncCall = false;
            _isInvalidAsyncUser = true;
          });
        }
        if (_isLoggedIn)
          widget._onSignIn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: SingleChildScrollView(
              child: buildLoginForm(context),
          ),
          inAsyncCall: _isInAsyncCall,
          // demo of some additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacementNamed(context, '/Menu');
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {    
    _loginFormKey.currentState?.validate();
    return Column(
      children: <Widget>[
        Container(
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
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: this._loginFormKey,
            child: Column(
              children: [          
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: Key('username'),
                    decoration: InputDecoration(
                        hintText: 'E-mail', 
                        border: OutlineInputBorder()
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                    validator: _validateUserName,
                    onSaved: (value) => _username = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    key: Key('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Senha',      
                        border: OutlineInputBorder()           
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                    validator: _validatePassword,
                    onSaved: (value) => _password = value,
                  ),
                ),
                Container(
                  width: double.infinity ,
                  height: 55,          
                  margin: const EdgeInsets.only(left: 10.0, right: 10, bottom: 12,),  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(38.0)
                    ),
                  ),
                  child: RaisedButton(
                    color: Color.fromRGBO(99, 125, 239, 1),
                    onPressed: _submit,
                    child: Text("Entrar",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: InkWell(
                        onTap: (){},
                        child: Text(
                          "Esqueci a Senha",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(9, 162, 241, 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                        onTap: (){},
                        child: Text(
                          "Criar uma Conta",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(9, 162, 241, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
