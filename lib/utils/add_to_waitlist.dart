import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'auth.dart';

int? length = 0;

Future<void> addUserToWaitList() async {
  FirebaseFirestore.instance
      .collection('Waitlist')
      .doc('waitlist')
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;
      length = data['length'];
      length = length! + 1;

      FirebaseFirestore.instance.collection('Waitlist').doc('waitlist').update({
        'length': length,
      });
      FirebaseFirestore.instance
          .collection('Users')
          .doc(Auth().currentUser!.uid)
          .set({
        'id': Auth().currentUser!.uid.toString(),
        'number': length.toString(),
        'date_of_joining':
            DateFormat('kk:mm:ss \n EEE d MMM').format(DateTime.now())
      });
      //Set the relevant data to variables as needed
    } else {
      print('Document does not exist on the database');
    }
  });
  return;
}
