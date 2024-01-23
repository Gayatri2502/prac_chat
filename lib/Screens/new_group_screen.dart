import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/models/group_model.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:widget_loading/widget_loading.dart';

import '../Models/user_model.dart';
import 'group_screen.dart'; // Import your GroupModel class

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({Key? key}) : super(key: key);

  @override
  _NewGroupScreenState createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  List<UserModel> selectedMembers = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String picUrl = "";
  List<UserModel> contactList = [];
  TextEditingController groupNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    groupNameController.clear();
    selectedMembers.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: const Text(
          'Groups',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * 0.125,
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.fill,
                      imageUrl: picUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        CupertinoIcons.camera_fill,
                        size: 35,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  // TextField(
                  //   controller: groupNameController,
                  // ),
                  const SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 250,
                    height: 50,
                    // color: Colors.pink,
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: ("Group name (optional)"),
                          hintStyle: TextStyle(fontSize: 18)),
                      controller: groupNameController,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.black54,
                    size: 25,
                  )
                ],
              ),
            ),
            Container(
                height: 150,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Card(
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                        ),
                        child: const ListTile(
                          title: Text("Disappearing Images"),
                          subtitle: Text("off"),
                          trailing: Icon(Icons.av_timer_sharp),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Card(
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                        ),
                        child: const ListTile(
                          title: Text("Group permissions and security"),
                          trailing: Icon(Icons.settings),
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Select members for the new group:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: firestore.collection('Users').snapshots(),
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
                        contactList = data
                                ?.map((e) => UserModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList() ??
                            [];

                        // Remove the current user from the contactList
                        contactList.removeWhere((user) =>
                            user.userID ==
                            FirebaseAuth.instance.currentUser!.uid);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        elevation: 0.4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the radius as needed
                        ),
                        child: ListView.builder(
                          itemCount: contactList.length,
                          itemBuilder: (context, index) {
                            final contact = contactList[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width:
                                      MediaQuery.of(context).size.width * 0.125,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  fit: BoxFit.fill,
                                  imageUrl: contact.photo,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    CupertinoIcons.person_crop_circle_fill,
                                    size: 50,
                                    color: Colors.black12,
                                  ),
                                ),
                              ),
                              title: Text(
                                contact.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Text(contact.phoneNumber),
                              trailing: IconButton(
                                icon: Icon(
                                  selectedMembers.contains(contact)
                                      ? Icons.check_circle
                                      : Icons.circle,
                                  color: selectedMembers.contains(contact)
                                      ? Colors.teal
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (selectedMembers.contains(contact)) {
                                      selectedMembers.remove(contact);
                                    } else {
                                      selectedMembers.add(contact);
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (selectedMembers.length >= 2) {
                    List<String> selectedMemberIDs =
                        selectedMembers.map((user) => user.name).toList();
                    GroupModel newGroup = GroupModel(
                      groupID: firestore
                          .collection('Groups')
                          .doc(groupNameController.text)
                          .id,
                      groupName: groupNameController.text,
                      createdBy: FirebaseAuth.instance.currentUser!.uid,
                      createdAt: DateTime.now().toString(),
                      groupPic: picUrl,
                      members: selectedMemberIDs,
                    );

                    await firestore
                        .collection('Groups')
                        .doc(newGroup.groupID)
                        .set(newGroup.toJson());

                    QuickAlert.show(
                      confirmBtnColor: Colors.teal.shade400,
                      context: context,
                      type: QuickAlertType.success,
                      text:
                          '${groupNameController.text} Group Created Successfully!',
                    );

                    await Future.delayed(const Duration(seconds: 50));

                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return const GroupCardScreen();
                    }));
                  } else {
                    showSnackbar(context,
                        'Select at least two members to create a group.');
                  }
                } catch (e) {
                  showSnackbar(
                      context, 'Error creating group. Please try again.');
                }
              },
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(150, 50),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.teal.shade700,
                ),
              ),
              child: const Text(
                'Create Group',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// void showSuccessAlert(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return QuickAlert.show(
//         context: context,
//         type: QuickAlertType.success,
//         text: 'Transaction Completed Successfully!',
//       );
//       //   Dialog(
//       //   backgroundColor: Colors.teal.shade100,
//       //   shape: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.circular(30.0)), //this right here
//       //   child: Container(
//       //     height: 200,
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         Container(
//       //           decoration: BoxDecoration(
//       //             color: Colors.white,
//       //             // borderRadius: BorderRadius.only(
//       //             //     topLeft: Radius.circular(30),
//       //             //     topRight: Radius.circular(30))
//       //           ),
//       //           height: 100,
//       //         ),
//       //         Container(
//       //           height: 50,
//       //           child: Center(
//       //             child: Text(
//       //               "Group Created Scuccesfully",
//       //               style: TextStyle(color: Colors.black, fontSize: 15),
//       //             ),
//       //           ),
//       //         )
//       //       ],
//       //     ),
//       //   ),
//       // );
//     },
//   );
// }

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 1,
      backgroundColor: Colors.teal.shade100,
      // padding: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50), // Adjust the radius as needed
      ),
      content: ListTile(
        leading: const Icon(Icons.error_outline_outlined),
        title: Text(
          message,
          style: const TextStyle(color: Colors.black87, fontSize: 15),
        ),
        // subtitle: Text("Try again."),
      ),
    ),
  );
}
