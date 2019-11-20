import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../provider/login.dart';
import '../herramientas.dart';
import '../../Clases/professional.dart';
class CriarPage extends StatefulWidget {

  @override
  _CriarPageState createState() => _CriarPageState();
}

class _CriarPageState extends State<CriarPage> {
  
  // maintains validators and state of form fields
  TextEditingController controlerEmail = new TextEditingController();
  TextEditingController controlerPassword = new TextEditingController();
  TextEditingController controlerRePassword = new TextEditingController();
  TextEditingController controlerNome = new TextEditingController();
  TextEditingController controlerPhone = new TextEditingController();
  TextEditingController controlerClinica = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // esta es la llamada asincrona del progress HUD widget
  bool _isInAsyncCall = false;
  Future _submit() async {
      // dismiss keyboard during async call
      FocusScope.of(context).requestFocus(new FocusNode());
      // start the modal progress HUD
      setState(() {
        _isInAsyncCall = true;
      });
      
      Future.delayed(Duration(seconds: 1), () async { 
        var body = json.encode({
            "email": controlerEmail.text,
            "password": controlerPassword.text,
            "password_confirmation": controlerRePassword.text,
            "user_name": controlerNome.text,
            "phone": controlerPhone.text,
            "company_name": controlerClinica.text
        });
        print(body);
        final response = await http.post('https://mobile.santeodonto.io/api/v1/register_new_company', headers: {"Content-Type": "application/json"} ,body: body);
        print(response.body); 
        print(response.statusCode); 
        if (response.statusCode == 200) {
          print(json.decode(response.body));
          var dato = json.decode(response.body);
          var error = dato['erros']; 
          if(dato['erros'] != null){
            msgbox(error.toString(), 'Erro', context);
          }else{
            msgbox(dato['message'].toString(), 'Successo', context);
          }
          
          setState(() {
            _isInAsyncCall = false;
          });
        }else {     
          setState(() {
            _isInAsyncCall = false;
          });
          var dato = json.decode(response.body);         
          msgbox('Erro', 'Erro', context);
        }
      });
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
    );
  }

  Widget buildLoginForm(BuildContext context) {    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromRGBO(9, 162, 241, 1),
                borderRadius: BorderRadius.only(
                      bottomRight: const  Radius.circular(60.0)
                )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 10,
                    top: 40,
                    child:  InkWell(
                      onTap: (){
                          Navigator.pushReplacementNamed(context, '/Login');
                      },
                      child: Icon(
                        Icons.keyboard_arrow_left,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 100,
                    child: Image(
                      image: AssetImage(
                        "assets/images/Logo Sante Odonto.png"
                      ),
                    ),
                  ),
                ] 
              ),   
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [          
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'E-mail', 
                          border: OutlineInputBorder()
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerEmail,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Erro ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Senha',      
                          border: OutlineInputBorder()           
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerPassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Erro ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirmaçao Senha',      
                          border: OutlineInputBorder()           
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerRePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Erro ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Seu Nome',      
                          border: OutlineInputBorder()           
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerNome,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Erro ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Telefone',      
                          border: OutlineInputBorder()           
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerPhone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Nome da Clinica',      
                          border: OutlineInputBorder()           
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      controller: controlerClinica,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Erro ';
                        }
                        return null;
                      },
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
                      color: Color.fromRGBO(9, 162, 241, 1),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _submit();
                        }
                      }, 
                      child: Text("Criar conta",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
