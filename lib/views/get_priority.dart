import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/priority.dart';
import 'package:flutter_b18_backend/services/priority.dart';
import 'package:flutter_b18_backend/views/create_priority.dart';
import 'package:provider/provider.dart';

class GetPriority extends StatelessWidget {
  const GetPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Priority")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePriority()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriority(),
        initialData: [PriorityModel()],
        builder: (context, child) {
          List<PriorityModel> priorityList = context
              .watch<List<PriorityModel>>();
          return ListView.builder(
            itemCount: priorityList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.priority_high),
                title: Text(priorityList[index].name.toString()),
                trailing: Icon(Icons.arrow_forward),
              );
            },
          );
        },
      ),
    );
  }
}
