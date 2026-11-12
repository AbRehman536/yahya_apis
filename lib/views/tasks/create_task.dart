import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/provider/token_provider.dart';
import 'package:yahya_todo_app/services/tasks.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Enter Title",
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
          :ElevatedButton(onPressed: ()async{
            try{
              setState(() {
              isLoading = true;
            });
              await TaskService().createTask(
                  token: tokenProvider.getToken().toString(),
                  description: titleController.text)
                  .then((val){
                    isLoading = false;
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("Create Successfully"),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, child: Text("Okay"))
                          ],
                        );
                      },);
              });
            }catch(e){
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create"))
        ],
      ),
    );
  }
}
