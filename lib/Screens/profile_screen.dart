import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prac_chat/Widgets/Services/auth_services.dart';
import '../Models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,

    //  required this.userData,
  }) : super(key: key);


  //UserModel user;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<UserModel> userList = [];
  final TextEditingController _userPhotoController = TextEditingController();
  final TextEditingController _userBioController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isLoading = false;
  AuthServices info = AuthServices();


  // @override
  // void initState() {
  //   super.initState();
  //   _userNameController.text = widget.user.Name;
  //   _userBioController.text = widget.user.Bio;
  //   _phoneNumberController.text = widget.user.PhoneNumber;
  //   _userPhotoController.text = widget.user.Photo;
  // }

  Future<void> bioDataSumbit() async {
    // if (_formKey.currentState!.validate()) {

    print("Save Submit");
    setState(() {
      _isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(Auth.currentUser!.uid)
        .set({
      "Name" : _userNameController.text,
      "PhoneNumber": _userPhotoController.text,
      "Bio": _userBioController.text,
      "Photo": _userPhotoController,
    }).then((value) {
      print("User about data Added to Database");
    });

    setState(() {
      _isLoading = false;
    });
  }

  FirebaseAuth Auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthServices authServices = AuthServices();

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        title: const Text('Profile'),
        leading: const Icon(Icons.arrow_back),
        actions: [
          IconButton(
              onPressed: () {
                bioDataSumbit();
              },
              icon: const Icon(Icons.save, color: Colors.white, size: 30))
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.35,
            vertical: MediaQuery.of(context).size.height * 0.15),
        child: FloatingActionButton.extended(
            onPressed: () async {
              // Dialogs.showProgressBar(context);
              // await authServices
              //     .signOut()
              //     .then((value) => Navigator.of(context).pop());
            },
            shape: const StadiumBorder(),
            backgroundColor: Colors.teal,
            icon: const Icon(
              Icons.logout,
            ),
            label: const Text('Logout')),
      ),
      body: StreamBuilder(
          stream: firestore
              .collection('Users')
              .where('userID',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            userList =
                data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                //  vertical: MediaQuery.of(context).size.height,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                        width: MediaQuery.of(context).size.width),
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.2),
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.fill,
                            imageUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRucJf8SJrX0jvvpIR_65cZaITLZ1HFjMDweq0HqAD3Sg&usqp=CAU&ec=48665699",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              CupertinoIcons.person,
                              size: 30,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          height: 55,
                          child: MaterialButton(
                            onPressed: () {},
                            shape: const CircleBorder(),
                            color: Colors.white,
                            elevation: 10,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    const Center(
                      child: Text(
                        ' Current User Email Address',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(12)),
                          suffixIcon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          labelText: ('Name'),
                          hintText: ('eg. Alex'),
                          helperText:
                              'This is not your username or pin.this name will be visible\nto your WhatsApp contacts.'),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0035),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextFormField(
                      controller: _userPhotoController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: ('Photo'),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    TextFormField(
                      controller: _userBioController,

                      //initialValue: '',
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.error_outline,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(12)),
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        labelText: ('Bio'),
                        hintText: ('Urgent Calls Only !'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      initialValue: '',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: ('Phone Number'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
