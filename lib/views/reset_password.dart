import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/services/auuth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(children: [
        TextField(controller: emailController,),
        ElevatedButton(onPressed: ()async
            {
              try{
                await AuthServices().resetPassword(
                  emailController.text.toString(),
                ).then((value){
                  showDialog(
                      context: context,
                    builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Link send successfully"),
                          actions: [
                            TextButton(onPressed: (){}, child: Text("Okay"))
                          ],
                        );
                    },);
                });
              }catch(e){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            }, child: Text("Send Link"))
      ],),

    );
  }
}
