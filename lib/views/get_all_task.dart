import 'package:flutter/material.dart';
import 'package:flutter_b18_backend/models/task.dart';
import 'package:flutter_b18_backend/services/task.dart';
import 'package:flutter_b18_backend/views/create_task.dart';
import 'package:flutter_b18_backend/views/favorite_task.dart';
import 'package:flutter_b18_backend/views/get_completed_task.dart';
import 'package:flutter_b18_backend/views/get_in_completed_task.dart';
import 'package:flutter_b18_backend/views/get_priority.dart';
import 'package:flutter_b18_backend/views/update_task.dart';
import 'package:provider/provider.dart';

class GetAllTaskView extends StatelessWidget {
  const GetAllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>GetPriority()));
          }, icon: Icon(Icons.category_rounded)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetInCompletedTaskView(),
                ),
              );
            },
            icon: Icon(Icons.incomplete_circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetCompletedTaskView()),
              );
            },
            icon: Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GetFavoriteTask()),
              );
            },
            icon: Icon(Icons.favorite),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskView()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamProvider.value(
        value: TaskServices().getAllTask(),
        initialData: [TaskModel()],
        builder: (context, child) {
          List<TaskModel> taskList = context.watch<List<TaskModel>>();
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskList[i].title.toString()),
                subtitle: Text(taskList[i].description.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: taskList[i].isCompleted,
                      onChanged: (val) async {
                        try {
                          await TaskServices().markTaskAsComplete(
                            taskList[i].docId.toString(),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                    ),
                    IconButton(
                      onPressed: () async {
                        try {
                          await TaskServices()
                              .deleteTask(taskList[i].docId.toString())
                              .then((val) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Task has been deleted successfully",
                                    ),
                                  ),
                                );
                              });
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdateTask(
                            model: taskList[i],
                          )),
                        );
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(onPressed: ()async{
                      if(taskList[i].favorite!.contains("1")){
                        await TaskServices()
                            .removefromFavorite(
                            userID: "1",
                            taskID: taskList[i].docId.toString());
                      }
                      else{
                        await TaskServices().addtoFavorite(
                            userID: "1",
                            taskID: taskList[i].docId.toString());
                      }
                    },
                        icon: Icon(taskList[i].favorite!.contains("1")
                        ? Icons.favorite : Icons.favorite_border))
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
