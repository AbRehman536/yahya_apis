import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/services/tasks.dart';
import 'package:yahya_todo_app/views/tasks/create_task.dart';

import '../../models/taskListing.dart';
import '../../provider/token_provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tasks"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateTask()));
      },child: Icon(Icons.add),),
      body: FutureProvider.value(
          value: TaskService().getAllTask(tokenProvider.getToken().toString()),
          initialData: TaskListingModel(),
          builder: (context, child){
            TaskListingModel taskListingModel = context.watch<TaskListingModel>();
            return ListView.builder(
              itemCount: taskListingModel.tasks!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("${index + 1}"),
                  title: Text(taskListingModel.tasks![index].description.toString()),
                  trailing: Row(
                    mainAxisSize: .min,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: Colors.blue,)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                );
              },);
          },
      ),
    );
  }
}
