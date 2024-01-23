// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Widgets/group_card/group_card.dart';
import 'package:widget_loading/widget_loading.dart';

import '../Models/group_model.dart';
import '../Models/user_model.dart';

class GroupCardScreen extends StatefulWidget {
  const GroupCardScreen({Key? key}) : super(key: key);

  @override
  State<GroupCardScreen> createState() => _GroupCardScreenState();
}

class _GroupCardScreenState extends State<GroupCardScreen> {
  List<GroupModel> groupList = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('Groups')
            .orderBy('sentAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return CircularWidgetLoading(
                  sizeDuration: Duration(milliseconds: 5),
                  dotRadius: 5,
                  dotColor: Colors.teal.shade200,
                  child: Container());
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              groupList = data
                      ?.map((e) =>
                          GroupModel.fromJson(e.data() as Map<String, dynamic>))
                      .toList() ??
                  [];

              // Remove the current user from the groupList
              groupList.removeWhere((user) =>
                  user.groupID == FirebaseAuth.instance.currentUser!.uid);
          }
          return ListView.builder(
              itemCount: groupList.length,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(1),
                  child: GroupChatCard(
                    user: groupList[index],
                  ),
                );
                // return Text('$listOfUsers[index]');
              });
        });
  }
}
