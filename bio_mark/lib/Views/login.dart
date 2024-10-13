import 'package:flutter/material.dart';
import 'package:bio_mark/Components/button.dart';
import 'package:bio_mark/Components/colors.dart';
import 'package:bio_mark/Components/textfield.dart';
import 'package:bio_mark/JSON/users.dart';
import 'package:bio_mark/Views/profile.dart';
import 'package:bio_mark/Views/signup.dart';

import '../SQLite/database_helper.dart';

class LoginScreen extends StatefulWidget 
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
{
  //Our controllers
  //Controller is used to take the value from user and pass it to database
  final email = TextEditingController();
  final password = TextEditingController();

  bool isChecked = false;
  bool isLoginTrue = false;

  final db = DatabaseHelper();
  //Login Method
  //We will take the value of text fields using controllers in order to verify whether details are correct or not
  login()async
  {
    Users? usrDetails = await db.getUser(email.text);
    var res = await db.authenticate(Users(email: email.text, password: password.text));
    if(res == true)
    {
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(profile: usrDetails)));
    }
    else
    {
      setState(() 
      {
        isLoginTrue = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Because we don't have account, we must create one to authenticate
                //lets go to sign up

                const Text("Login",style: TextStyle(color: primaryColor,fontSize: 35,fontWeight: FontWeight.bold),),
                Image.asset("assets/background.jpg"),
                InputField(hint: "Email", icon: Icons.account_circle, controller: email),
                InputField(hint: "Password", icon: Icons.lock, controller: password,passwordInvisible: true),

                ListTile(
                  horizontalTitleGap: 2,
                  title: const Text("Remember me"),
                  leading: Checkbox(
                    activeColor: primaryColor,
                    value: isChecked,
                    onChanged: (value)
                    {
                      setState(() 
                      {
                        isChecked = !isChecked;
                      });
                    },
                  ),
                ),

                //Our login button
                Button(label: "LOGIN", press: ()
                {
                  login();
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",style: TextStyle(color: Colors.grey),),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                        },
                        child: const Text("SIGN UP"))
                  ],
                ),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Forgot your password?",style: TextStyle(color: Colors.grey),),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
                        },
                        child: const Text("Recover"))
                  ],
                ),

                 // Access denied message in case when your username and password is incorrect
                //By default we must hide it
                 //When login is not true then display the message
                 isLoginTrue? Text("Username or password is incorrect",style: TextStyle(color: Colors.red.shade900),):const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
