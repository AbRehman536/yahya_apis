import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/models/taskListing.dart';
import 'package:yahya_todo_app/provider/token_provider.dart';
import 'package:yahya_todo_app/services/tasks.dart';

class SearchTask extends StatefulWidget {
  const SearchTask({super.key});

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  TextEditingController searchController = TextEditingController();
  TaskListingModel? taskListingModel;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Here.....",
              prefixIcon: Icon(Icons.search)
            ),
            onChanged: (val)async{
              try{
                isLoading = true;
                taskListingModel = null;
                setState(() {});
                await TaskService().searchTask(
                    token: tokenProvider.getToken().toString(),
                    keyword: searchController.text)
                    .then((val){
                  isLoading = false;
                  taskListingModel = val;
                  setState(() {});
                });
              }catch(e){
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
          SizedBox(height: 20,),
          if(isLoading == true)
            Center(child: CircularProgressIndicator(),)
          else if(taskListingModel == null)
            Center(child: Text("No Data Found"),)
          else
            Expanded(
              child: ListView.builder(
                itemCount: taskListingModel!.tasks!.length,
                itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.task),
                  title: Text(taskListingModel!.tasks![index].description.toString()),
                );
              },),
            )
        ],
      ),
    );
  }
}
