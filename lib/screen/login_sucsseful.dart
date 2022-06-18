import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firstf1/main.dart';
import 'package:firstf1/modeldata/modeldata.dart';
import 'package:firstf1/util/firebaseDatabase.dart';
import 'package:firstf1/util/loginResigter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../util/constveriabal.dart';
import '../util/sharedUID.dart';

class Sucsses extends StatefulWidget {
  const Sucsses({Key? key}) : super(key: key);

  @override
  State<Sucsses> createState() => _SucssesState();
}

class _SucssesState extends State<Sucsses> {
  TextEditingController txt_titel = TextEditingController();
  TextEditingController txt_about = TextEditingController();
  TextEditingController txt_updata_titel = TextEditingController();
  TextEditingController txt_updata_about = TextEditingController();

  @override
  void initState() {
    super.initState();

    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('appicon');
    IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(android: androidInitializationSettings,iOS: iosInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = message.notification!.android;

      if(notification != null || androidNotification != null)
        {
          AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(channel.id,channel.name);

          flutterLocalNotificationsPlugin.show(notification.hashCode, notification!.title, notification.body, NotificationDetails(android: androidNotificationDetails));
        }

    });

  }

  @override
  Widget build(BuildContext context) {

    userid = Login_Register().auth.currentUser!.uid.toString();
    CreatShaerID(Login_Register().auth.currentUser!.uid.toString());

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to HomePage",
                style: TextStyle(
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: txt_titel,
                decoration: InputDecoration(
                  labelText: "titel",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: txt_about,
                decoration: InputDecoration(
                  labelText: "about",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  RealDB().addNewProcduct(txt_titel.text, txt_about.text,"ABCD");
                },
                child: Text("add Data"),
              ),
              ElevatedButton(
                onPressed: () {
                  Login_Register().singOut();
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text("Sign out"),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  child: StreamBuilder(
                    stream: RealDB().getProductData(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        DataSnapshot res = snapshot.data.snapshot;
                        List<ModelData> l1 = [];
                        l1.clear();
                        for (var x in res.children) {
                          print("==========> ${x.child("name").value}");
                          print("==========> ${x.child("price").value}");

                          String key = x.key.toString();
                          ModelData m1 = ModelData(
                              titel: x.child("name").value.toString(),
                              about: x.child("price").value.toString(),
                              key: key);
                          l1.add(m1);
                        }

                        return ListView.builder(
                            itemCount: l1.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text("${l1[index].titel}"),
                                title: Text("${l1[index].about}"),
                                subtitle: Text("${l1[index].key}"),
                                trailing: Column(
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          RealDB().deletData("${l1[index].key}");
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        onPressed: () {
                                          setState((){
                                            txt_updata_titel.text = l1[index].titel.toString();
                                            txt_updata_about.text = l1[index].about.toString();
                                          });
                                          updateDialog("${l1[index].key}");
                                        },
                                        icon: Icon(
                                          Icons.update,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDialog(String key) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextField(
                controller: txt_updata_titel,
              ),
              TextField(
                controller: txt_updata_about,
              ),
              ElevatedButton(
                onPressed: () {
                  RealDB().updataData(txt_updata_titel.text, txt_updata_about.text, key);
                  Navigator.pop(context);
                },
                child: Text("updata"),
              ),
            ],
          );
        });
  }
}
