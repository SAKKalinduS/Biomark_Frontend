import 'package:flutter/material.dart';
import 'package:bio_mark/Components/button.dart';
import 'package:bio_mark/Components/colors.dart';
import 'package:bio_mark/JSON/users.dart';
import 'package:bio_mark/Views/login.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45.0,horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
              const CircleAvatar
              (
                backgroundColor: primaryColor,
                radius: 77,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/no_user.jpg"),
                  radius: 75,
                ),
              ),

              const SizedBox(height: 10),
              Text(profile!.fullName??"",style: const TextStyle(fontSize: 28,color: primaryColor),),
              Text(profile!.email??"",style: const TextStyle(fontSize: 17,color: Colors.grey),),

              Button(label: "SIGN UP", press: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
              }),

                ListTile
                (
                leading: const Icon(Icons.person,size: 30),
                subtitle: const Text("Full name"),
                title: Text(profile!.fullName??""),
              ),

               ListTile
               (
                leading: const Icon(Icons.email,size: 30),
                subtitle: const Text("Email"),
                title: Text(profile!.email??""),
              ),

               ListTile
               (
                leading: const Icon(Icons.account_circle,size: 30),
                subtitle: const Text("Mother's Maiden Name"),
                title: Text(profile!.mother??""),
              ),

              ListTile
               (
                leading: const Icon(Icons.account_circle,size: 30),
                subtitle: const Text("Childhood Best Friend's Name"),
                title: Text(profile!.besty??""),
              ),

              ListTile
               (
                leading: const Icon(Icons.account_circle,size: 30),
                subtitle: const Text("Childhood Pet's Name"),
                title: Text(profile!.pet??""),
              ),

              ListTile
               (
                leading: const Icon(Icons.account_circle,size: 30),
                subtitle: const Text("Your Own Question"),
                title: Text(profile!.ownQuestion??""),
              ),
              
          ],
        ),
            )),
      ),
    );
  }
}
