import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/provider/token_provider.dart';
import 'package:yahya_todo_app/services/auth.dart';

import '../../provider/user_provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void initState(){
    var userProvider = Provider.of<UserProvider>(context);
    super.initState();
    if(userProvider.getUser()?.user?.name.toString() != null){
      nameController.text = userProvider.getUser()!.user!.name.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Enter your name"
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),):
          ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              bool success =
              await AuthService().updateProfile(
                  token: tokenProvider.getToken().toString(),
                  name: nameController.text);
              if(success){
                var updateUser =
                await AuthService().getProfile(token: tokenProvider.getToken().toString());
                userProvider.setUser(updateUser);
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Update Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                },);
              }
            }catch(e){
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update Profile"))
        ],
      ),
    );
  }
}
