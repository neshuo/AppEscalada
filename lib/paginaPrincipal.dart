import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escalaapp/agregarItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({ Key? key }) : super(key: key);

  @override
  _paginaPrincipalState createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        IconButton(icon: const Icon(Icons.logout),
        onPressed: () {
          final FirebaseAuth _auth = FirebaseAuth.instance;

          Future<void> _singOut() async{
            await _auth.signOut();
          }

        },)
      ]),
      body:Center(),
       floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
            return agregar();
          }));
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class agregar extends StatefulWidget {
  const agregar({ Key? key }) : super(key: key);

  @override
  _agregarState createState() => _agregarState();
}

class _agregarState extends State<agregar> {
  @override
  Widget build(BuildContext context) {

    TextEditingController nombre=TextEditingController();
    TextEditingController compra=TextEditingController();
    TextEditingController revision=TextEditingController();

    return Padding(padding: const EdgeInsets.all(16.0),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        TextField(
          controller: nombre,
          keyboardType: TextInputType.text,
          decoration:  InputDecoration(
            hintText: "Item name",
          ),
        ),
        TextField(
          controller: compra,
          keyboardType: TextInputType.datetime,
          decoration:  InputDecoration(
            hintText: "Buy Date",
          ),
        ),
        
        TextField(
          controller: revision,
          keyboardType: TextInputType.datetime,
          decoration:  InputDecoration(
            hintText: "Revision Date",
          ),
        ),
        SizedBox(height: 36.0),
        Container(
          width: 60.0,
          child: RawMaterialButton(fillColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          onPressed: () async{
            
          },child: Text("listo", style: TextStyle(color: Colors.white),),
        ),)
      ]
    )
    );
  }
}