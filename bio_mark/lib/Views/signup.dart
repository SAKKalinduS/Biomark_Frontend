import 'package:flutter/material.dart';
import 'package:bio_mark/Components/button.dart';
import 'package:bio_mark/Components/colors.dart';
import 'package:bio_mark/Components/textfield.dart';
import 'package:bio_mark/JSON/users.dart';
import 'package:bio_mark/Views/login.dart';

import '../SQLite/database_helper.dart';

class SignupScreen extends StatefulWidget
{
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> 
{

  //Controllers
  final fullName = TextEditingController();
  final dob = TextEditingController();
  final mother = TextEditingController();
  final besty = TextEditingController();
  final pet = TextEditingController();
  final ownQuestion = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final db = DatabaseHelper();

  signUp()async
  {
    var res = await db.createUser(Users(fullName: fullName.text, dob: dob.text, mother: mother.text, besty: besty.text, pet: pet.text, ownQuestion: ownQuestion.text ,email: email.text, password: password.text));
    if(res>0)
    {
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
    }
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10),
                 child: Text("Bio Mark Signup",style: TextStyle(color: primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
               ),

                const SizedBox(height: 10),
                InputField(hint: "Full name", icon: Icons.person, controller: fullName),
                InputField(hint: "Date of Birth", icon: Icons.access_time_outlined, controller: dob),
                InputField(hint: "Mother's Maiden Name", icon: Icons.spatial_audio_sharp, controller: mother),
                InputField(hint: "Childhood Best Friend's Name", icon: Icons.supervisor_account, controller: besty),
                InputField(hint: "Childhood Pet's Name", icon: Icons.pets, controller: pet),
                InputField(hint: "Your Own Question", icon: Icons.question_answer_rounded, controller: ownQuestion),
                InputField(hint: "Email", icon: Icons.email, controller: email),
                InputField(hint: "Password", icon: Icons.lock, controller: password,passwordInvisible: true),
                InputField(hint: "Re-enter password", icon: Icons.lock, controller: confirmPassword,passwordInvisible: true),

                const SizedBox(height: 10),
                Button(label: "SIGN UP", press: ()
                {
                  signUp();
                }),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",style: TextStyle(color: Colors.grey),),
                    TextButton(
                        onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                        },
                        child: const Text("LOGIN"))
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
