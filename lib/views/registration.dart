import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/user.dart';
import 'package:flutter_b18_backend/services/auuth.dart';
import 'package:flutter_b18_backend/services/user.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        TextField(controller: emailController,),
        TextField(controller: passwordController,),
        TextField(controller: cpasswordController,),
        TextField(controller: phoneController,),
        TextField(controller: addressController,),
        ElevatedButton(onPressed: ()async{
          try{
            await AuthServices().signUpUser(
                email: emailController.text,
                password: passwordController.text)
                .then((user){
                  UserServices().createUser(UserModel(
                    name: nameController.text.toString(),
                    email: emailController.text.toString(),
                    phone: phoneController.text.toString(),
                    address: addressController.text.toString(),
                    createdAt: DateTime.now().millisecondsSinceEpoch
                  )).then((value){
                    showDialog(
                        context: context,
                      builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text("Register Successfully"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Okay"))
                            ],
                          );
                      },);
                  });
            });
          }catch(e){
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Sign up"))
      ],),
    );
  }
}
