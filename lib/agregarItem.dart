import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/editable_text.dart';

class agregarItem extends StatelessWidget{

  late final String UID;
  late final CollectionReference items= FirebaseFirestore.instance.collection('usuarios/UID/Items');


  @override
  Widget build(BuildContext context) {
    
    CollectionReference users = FirebaseFirestore.instance.collection('usuarios');


    Future <void> agregarItem(){
      return users

      .add({
        'UID':UID,
      })
      .then((value) =>print("usser created"))
      .catchError((error) => print("failed to create: $error"));

    }




    throw UnimplementedError();
  }




}