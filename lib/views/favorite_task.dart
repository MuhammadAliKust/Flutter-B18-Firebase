import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/task.dart';
import 'package:flutter_b18_backend/services/task.dart';
import 'package:provider/provider.dart';

class GetFavoriteTask extends StatelessWidget {
  const GetFavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Favorite Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
          value: TaskServices().getFavoriteTask("1"),
          initialData: [TaskModel()],
        builder: (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text(taskList[index].title.toString()),
                  subtitle: Text(taskList[index].description.toString()),
                );
              },);
        },

      ),
    );
  }
}
