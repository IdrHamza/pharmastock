import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  late String? fid;
  late String fname;
  late String lname;
  late String email;
  late String birthday;
  late String Phonenum;
  late String docid;
  late String image;
  late String typeacc;
  Supplier(
      {required this.fid,
      required this.fname,
      required this.lname,
      required this.email,
      required this.birthday,
      required this.Phonenum,
      required this.docid,
      required this.image,
      required this.typeacc});
  Map<String, dynamic> toMap() {
    return {
      'fid': fid,
      'fname': fname,
      'lname': lname,
      'email': email,
      'birthday': birthday,
      'phonenum': Phonenum,
      'docid': docid,
      'image': image,
      'typeacc': typeacc
    };
  }

  Supplier.fromDocumentsSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    fid = doc.data()!['fid'];
    fname = doc.data()!['fname'];
    lname = doc.data()!['lname'];
    email = doc.data()!['email'];
    birthday = doc.data()!['birthday'];
    Phonenum = doc.data()!['phonenum'];
    docid = doc.data()!['docid'];
    image = doc.data()!['image'];
    typeacc = doc.data()!['typeacc'];
  }
  factory Supplier.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Supplier(
      fid: data['fid'] ?? '',
      fname: data['fname'] ?? '',
      lname: data['lname'] ?? '',
      email: data['email'] ?? '',
      birthday: data['birthday'] ?? '',
      Phonenum: data['phonenum'] ?? '',
      docid: data['docid'] ?? '',
      image: data['image'] ?? '',
      typeacc: data['typeacc'] ?? '',
    );
  }
}
