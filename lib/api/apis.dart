import 'dart:developer';
import 'dart:io';
//import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_user.dart';


// Cấu trúc dự án đơn giản (Tương tự MVVM) & Lớp với các thành viên tĩnh 

class APIs{

  // for authenticotion
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing clould firebase database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing  firebase storrage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // for storing self ìnomation
  static late ChatUser me;
  
  static User get user => auth.currentUser!;

  //for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore
      .collection('users')
      .doc(user.uid)
      .get())
    .exists;
  }

  //for checking if user exists or not?
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async{
        if(user.exists){
          me = ChatUser.fromJson(user.data()!);
          log('My Data: ${user.data()}');
          //log('My Data: ${user.data()}');
        }else{
          await createUser().then((value) => getSelfInfo());
        }
      });
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    // ignore: non_constant_identifier_naes
    final chatUser = ChatUser(
      id: user.uid, 
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "Hey, I`m using App Chat",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '');

    return await firestore
    .collection('users')
    .doc(user.uid)
    .set(chatUser.toJson());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return firestore
    .collection('users')
    .where('id', isNotEqualTo: user.uid)
    .snapshots();
  }


  //for checking if user exists or not?
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    log('Extension: $ext');
    final ref =  storage.ref().child('profile_pictures/${user.uid}.$ext');
    await ref
      .putFile(file, SettableMetadata(contentType: 'image/$ext'))
      .then((p0) {
        log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
      });
    me.image = await ref.getDownloadURL();
    await firestore 
    .collection('users')
    .doc(user.uid)
    .update( {'image':me.image});

  }


  // static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(){
  //   return firestore
  //   .collection('message')
  //   .snapshots();
  // }
}