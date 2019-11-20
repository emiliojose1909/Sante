import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './paginas/Login/novoLogin.dart';
import './paginas/criar/criarConta.dart';
import './paginas/criar/esqueciSenha.dart';
import './provider/login.dart';

void main() => runApp(new Momy());

class Momy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( builder: (context) => Loguearse() ),
        //ChangeNotifierProvider( builder: (context) => Visible() ),
      ],
      child: MaterialApp(
        home: LoginPage(onSignIn: () => print('Login successful!')),  
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
           // '/NuevoLogin': (BuildContext context) => new LoginPage(onSignIn: () => print('login successful!'),),
           '/Login': (BuildContext context) => new LoginPage(onSignIn: () => print('Login successful!')), 
           '/Criar': (BuildContext context) => new CriarPage(),
           '/Esqueci': (BuildContext context) => new EsqueciPage(),
        },      
      ),
    );
  }
}

