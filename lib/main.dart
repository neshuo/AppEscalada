
import 'package:escalaapp/paginaPrincipal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  Future<FirebaseApp> _initializeFirebase() async{
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return loginPage();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
    );
  }
}








class loginPage extends StatefulWidget {
  const loginPage({ Key? key }) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}



class _loginPageState extends State<loginPage> {

  static Future<User?> loginUsingEmailPassword({ required String email, required String password,  required BuildContext context})async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print("no se ha encontrado una cuenta con ese correo");
      }
    }

    return user;
  }


  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController=TextEditingController();
    TextEditingController _PasswordController=TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tu Equipamiento de Escalada", style:TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold,),
          ),
          Text("LogIn", style:TextStyle(color: Colors.black, fontSize:44.0, fontWeight: FontWeight.bold, ) 
          ),
          SizedBox(height: 44.0,),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "email",
              prefixIcon: Icon(Icons.mail, color:Colors.black),
            ),
          ),
          SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _PasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "password",
              prefixIcon: Icon(Icons.lock, color:Colors.black),
            ),
          ),
          Container(
            width: 88.0,
            child: RawMaterialButton(fillColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical:20.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            onPressed: () async {
              User? user =await loginUsingEmailPassword(email: _emailController.text, password: _PasswordController.text, context: context);
              print(user);
              if(user != null){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => loginPage()));
              }
            },child: Text("Login",style: TextStyle(color: Colors.white, fontSize: 18.0),),),
          ),
        ],
      ),
    );
  }
}