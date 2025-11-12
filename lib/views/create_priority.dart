import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/priority.dart';
import 'package:flutter_b18_backend/services/priority.dart';

class CreatePriority extends StatefulWidget {
  const CreatePriority({super.key});

  @override
  State<CreatePriority> createState() => _CreatePriorityState();
}

class _CreatePriorityState extends State<CreatePriority> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Priority"),
      ),
      body: Column(children: [
        TextField(controller: nameController,),
        isLoading ? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: ()async{
          try{
            isLoading = true;
            setState(() {});
            await PriorityServices()
                .createPriority(PriorityModel(
              name: nameController.text.toString(),
              createdAt: DateTime.now().millisecondsSinceEpoch
            )).then((val){
              isLoading=false;
              setState(() {});
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Priority created"),
                    actions: [
                      TextButton(onPressed: (){}, child: Text("Oka"))
                    ],
                  );
                }, );
            });
          }catch(e){
            isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }, child: Text("Create Priority"))
      ],),
    );
  }
}
