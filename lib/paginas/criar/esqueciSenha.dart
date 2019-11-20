import 'dart:async';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../herramientas.dart';
class EsqueciPage extends StatefulWidget {

  @override
  _EsqueciPageState createState() => _EsqueciPageState();
}

class _EsqueciPageState extends State<EsqueciPage> {
  
  // maintains validators and state of form fields
  TextEditingController controlerEmail = new TextEditingController();

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
        });
        print(body);                           ///api/v1/user/reset_password
        final response = await http.post('https://mobile.santeodonto.io/api/v1/user/reset_password', headers: {"Content-Type": "application/json"} ,body: body);
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
              height: 320,
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
                    top: 140,
                    left: 100,
                    child: Image(
                      image: AssetImage(
                        "assets/images/Logo Sante Odonto.png"
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 60,
                    child: Text('Esqueci minha senha',
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 65,
                    child: Container(
                      width: 280,
                      child: Text('Insira seu e-mail cadastrado e clique em enviar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          
                        ),
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
                    padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8, bottom: 8),
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
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Container(
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
                        child: Text("Enviar",
                          style: TextStyle(
                            color: Colors.white
                          ),
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
