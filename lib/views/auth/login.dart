import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yahya_todo_app/services/auth.dart';
import 'package:yahya_todo_app/views/auth/register.dart';
import 'package:yahya_todo_app/views/tasks/get_all_task.dart';

import '../../provider/token_provider.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text("Email"),
              hintText: "abdullah@gmail.com",
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              label: Text("Password"),
              hintText: "**********",
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await AuthService().loginUser(
                      email: emailController.text,
                      password: passwordController.text)
                      .then((val){
                        tokenProvider.setToken(val.token.toString());
                        isLoading = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text("Login Successfully"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> GetAllTask()));
                                },
                                    child: Text("Okay"))
                              ],);
                          },);
                  });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterUser()));
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
