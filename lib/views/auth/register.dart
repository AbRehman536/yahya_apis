import 'package:flutter/material.dart';
import 'package:yahya_todo_app/services/auth.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              label: Text("Username"),
              hintText: "abdullah rehman"
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text("Email"),
              hintText: "abdullah@gmail.com"
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              label: Text("Password"),
              hintText: "**********"
            ),
          ),
          SizedBox(
            height: 10,
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                  isLoading = true;
                  setState(() {});
                  await AuthService().registerUser(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text)
                      .then((value){
                        isLoading = false;
                        setState(() {});
                        showDialog(
                            context: context,
                          builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text("Register Successfully"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                    Navigator.pop(context);
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
          }, child: Text("Register"))
        ],
      ),
    );
  }
}
