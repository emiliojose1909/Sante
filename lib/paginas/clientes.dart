import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import '../Clases/clientes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/login.dart';
import 'herramientas.dart';
class MyClientes extends StatefulWidget {
  MyClientes({Key key}) : super(key: key);

  @override
  _MyClientesState createState() => _MyClientesState();
}

class _MyClientesState extends State<MyClientes> {
  
  Future<List<Cliente>> generarDetalles(BuildContext context) async {  
      final login = Provider.of<Loguearse>(context);
      String uid = login.uid;
      String client = login.client;
      String token = login.accessToken;  ////api/v1/customer/autocomplete
      var body = json.encode({
        "term": "",
        "search_only_active": false,
      });

      var response = await http.get('https://mobile.santeodonto.io/api/v1/customer/autocomplete', 
        headers: {"Content-Type": "application/json", 'client': client, 'uid': uid, 'access-token': token, 'data': body},
      );
      print(client+ ''+ uid+ ''+ token);
      if (response.statusCode == 200) {      
        print(json.decode(response.body));      
        var dato = json.decode(response.body);
        List<Cliente> clientes = [];
        for (Map i in dato) {
            clientes.add(Cliente.fromJson(i));
        }
        return clientes;
      }else{
        var dato = json.decode(response.body);
        print(dato);
          msgbox('mensaa', 'Erro', context);
      }
      return null;
  } 
  @override
  Widget build(BuildContext context) {
    //generarDetalles(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(143.0), // here the desired height
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                    bottomRight: const  Radius.circular(30.0),
                    bottomLeft: const  Radius.circular(30.0)
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Color.fromRGBO(100, 100, 100, 1),
                  blurRadius: 5.0,
                  offset: new Offset(2.0, 3.0),
                )
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, left: 14, right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){},
                        child: Icon(
                          Icons.clear,
                          size: 30,
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      ),
                      Text(
                        'Clientes',
                        style: TextStyle(
                          fontSize: 28,
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Icon(
                          Icons.control_point,
                          size: 30,
                          color: Color.fromRGBO(100, 100, 100, 1),
                        ),
                      )
                    ],
                  ),
                ),

                

              ],
            ),
          ),
      ),
      body: FutureBuilder(
        future: generarDetalles(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data == null){
            return Container(
              child: Center(
                child:  CircularProgressIndicator()
              )
            );
          }else{
            return  ListView.separated(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 90,
                  child: Stack(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 5,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 4.0, top: 10, left: 5),
                              child: CircleAvatar(                  
                                backgroundImage: (snapshot.data[index].avatar == '') ? new AssetImage('assets/images/img_958.png') : new CachedNetworkImageProvider('https://mobile.santeodonto.io'+snapshot.data[index].avatar),
                              
                              radius: 40.0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 95,
                          top: 20,
                          child: Text(
                            snapshot.data[index].name,
                            style: TextStyle(
                              color: Color.fromRGBO(9, 162, 241, 1),
                              fontSize: 16
                            ),
                          )
                        ),
                        Positioned(
                          left: 95,
                          top: 40,
                          child: Text(snapshot.data[index].phones)
                        ),
                        Positioned(
                          right: 10,
                          top: 40,                        
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: const  Radius.circular(30.0),
                                bottomLeft: const  Radius.circular(30.0),
                                topLeft: const  Radius.circular(30.0),
                                topRight: const  Radius.circular(30.0),
                              ),
                              color: (snapshot.data[index].active) ? Colors.greenAccent : Colors.redAccent,
                            ),
                            
                            child: Center(
                              child: Text(
                                snapshot.data[index].active ? 'Ativo': 'Inativo',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              )
                            )
                          )
                        )
                     ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
        }
      )
    );
  }
}    
      