import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/user_model.dart';
import '../Widgets/Chat Cards/chat_cards.dart';

class ChatCardScreen extends StatefulWidget {
  const ChatCardScreen({Key? key}) : super(key: key);

  @override
  State<ChatCardScreen> createState() => _ChatCardScreenState();
}

class _ChatCardScreenState extends State<ChatCardScreen> {

  List<UserModel> contactList = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('Users').snapshots(),
        // firestore
        //     .collection('Users')
        //     .where('userId ' , isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        //     .snapshots(),

        //List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const CircularProgressIndicator();
          case ConnectionState.active:
          case ConnectionState.done:
            final data = snapshot.data?.docs;
            contactList = data
                ?.map((e) =>
                UserModel.fromJson(e.data() as Map<String, dynamic>))
                .toList() ??
                [];

            final int indexWhere = contactList.indexWhere((e) {
              return e.userID == FirebaseAuth.instance.currentUser!.uid;
            });

            contactList.removeAt(indexWhere);
        }
        return ListView.builder(
            itemCount: contactList.length,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return UserChatCards(
                user: contactList[index],
              );
              // return Text('$listOfUsers[index]');
            });
      }
    );
  }
}
