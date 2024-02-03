import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:want_coffee/models/preference_coffee.dart';
import 'package:want_coffee/models/user.dart';

class DatabaseService {
  //collection reference : referensi ke sebuah koleksi terentu

  final String? uid;
  DatabaseService(this.uid);

  final CollectionReference wcCollection =
      FirebaseFirestore.instance.collection('wcaffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await wcCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // Future<QuerySnapshot> getInitialSnapshot() async {
  //   return wcCollection.get();
  // }

//coffee list from snapshot
  // List<PreferenceCoffee> _preferenceCoffeeFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return PreferenceCoffee(
  //       name: doc.data['name'] ?? '',
  //       sugars: doc.data['sugars'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //     );
  //   });
  // }

  List<PreferenceCoffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // Konversi 'doc.data' ke tipe Map

      return PreferenceCoffee(
        name: doc['name'] ?? 'update your name',
        sugars: doc['sugars'] ?? '0',
        strength: doc['strength'] ?? 0,
      );
    }).toList();
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // return UserData(uid : uid, name, sugars, strength,)
    var data = snapshot.data()! as Map<String, dynamic>; // Pastikan data ada

    return UserData(
      uid: uid!,
      name: data['name'],
      sugars: data['sugars'],
      strength: data['strength'],
    );
  }

  //get stream
  Stream<List<PreferenceCoffee>> get ncaffeStream {
    // return wcCollection.snapshots(); awalnya
    return wcCollection.snapshots().map(_coffeeListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return wcCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
