import 'package:firstf1/util/loginResigter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Login_Register().curruntUser(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Login_Register.l1.singIn(context, email.text, password.text);
                  },
                  child: Text("Sign In"),
                ),

                SizedBox(
                  height: 30,
                ),

                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/singUp');
                    },
                    child: Text(
                      "Creat New Account",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),

                SizedBox(
                  height: 50,
                ),


                GestureDetector(
                  onTap: (){
                    Login_Register.l1.googlelogin(context);
                  },
                  child: Card(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      color: Colors.white,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(5),
                      child: Text("Google SignUp",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
