import 'package:firebase_database/firebase_database.dart';
import 'package:firstf1/util/constveriabal.dart';
import 'package:firstf1/util/sharedUID.dart';

class RealDB {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;

  void insertData(String titel, String about) {
    databaseReference = firebaseDatabase.ref();

    databaseReference!
        .child("News")
        .push()
        .set({"titel": "$titel", "about": "$about"});
  }

  Stream<DatabaseEvent> getData() {
    databaseReference = firebaseDatabase.ref();

    return databaseReference!.child("News").onValue;
  }

  void deletData(String key) {
    databaseReference = firebaseDatabase.ref();

    databaseReference!.child("News").child(key).remove();
  }

  void updataData(String titel, String about, String key) {
    databaseReference = firebaseDatabase.ref();

    databaseReference!
        .child("News")
        .child(key)
        .set({"titel": titel, "about": about});
  }

  Stream<DatabaseEvent> getProductData()
  {
    databaseReference = firebaseDatabase.ref();

    return databaseReference!.child("Product").child(userid).onValue;
  }

  void addNewProcduct(String name, String price, String qa) async {
    databaseReference = firebaseDatabase.ref();
    String? uid = await GetUidData();
    databaseReference!
        .child("Product")
        .child(uid!)
        .push()
        .set({"name": name, "price": price, "qa": qa});
  }
}
