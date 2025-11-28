import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/user.dart';
import 'package:flutter_b18_backend/services/auuth.dart';
import 'package:flutter_b18_backend/services/user.dart';
import 'package:flutter_b18_backend/views/get_all_task.dart';
import 'package:flutter_b18_backend/views/registration.dart';
import 'package:flutter_b18_backend/views/reset_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        ElevatedButton(onPressed: ()async{
          try{
            await AuthServices().loginUser(
                email: emailController.text,
                password: passwordController.text)
                .then((user){
             if(user!.emailVerified == true){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>GetAllTaskView()));
             }else{
               showDialog(
                 context: context,
                 builder: (BuildContext context) {
                   return AlertDialog(
                     content: Text("Kindly verify yor email"),
                     actions: [
                       TextButton(onPressed: (){
                         Navigator.pop(context);
                       }, child: Text("Okay"))
                     ],
                   );
                 },);
             }
            });
          }catch(e){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Login")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
        }, child: Text("Register")),
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
        }, child: Text("Forgot Password")),
      ],),
    );
  }
}
