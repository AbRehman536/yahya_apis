import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/provider/user_provider.dart';
import 'package:yahya_todo_app/views/profile/update_profile.dart';

class GetProfile extends StatelessWidget {
  const GetProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Text("Name: ${userProvider.getUser()!.user!.name}"),
          Text("Email: ${userProvider.getUser()!.user!.email}"),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
