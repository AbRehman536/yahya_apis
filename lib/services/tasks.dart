import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yahya_todo_app/models/taskListing.dart';

class TaskService{

  String baseURL = "https://todo-nu-plum-19.vercel.app";
  ///Create Task
  ///Update Task
  ///Delete Task
  ///Mark Task
  ///Get All Task
  ///Get Completed Task
  ///Get InCompleted Task
  ///Get Filter Task
  Future<TaskListingModel> filterTask({
    required String token,
    required String startDate,
    required String endDate,
  })async{
    try{
      http.Response response =
      await http.get(
          Uri.parse("$baseURL/todos/filter?startDate=$startDate&endDate=$endDate&="),
          headers: {'Authorization': token},
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        return taskListingModelFromJson(jsonDecode(response.body));
      }
      else{
        throw Exception("Something Went Wrong");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }
  ///Get Search Task
  Future<TaskListingModel> searchTask({
    required String token,
    required String keyword,
  })async{
    try{
      http.Response response =
      await http.get(
        Uri.parse("$baseURL/todos/search?keywords= $keyword"),
        headers: {'Authorization': token},
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        return taskListingModelFromJson(jsonDecode(response.body));
      }
      else{
        throw Exception("Something Went Wrong");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }
}