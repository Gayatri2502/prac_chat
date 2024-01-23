import 'package:flutter/material.dart';
import 'package:prac_chat/Screens/store_page_view.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff2f2f2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.tealAccent.shade700,
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.link_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                title: const Text(
                  "Create call link",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: const Text("Share a link for your WhatsApp call",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "recent calls",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.call),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Gayatri Samal",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 125,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Outgoing(2)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Alia",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 185,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Outgoing(2)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.call_missed_sharp,
                      color: Colors.red,
                    ),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Aishwarya",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 145,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Incoming(2)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Yash",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 180,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Incoming",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.call),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Aman",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 170,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Outgoing(2)",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.call_missed_sharp,
                      color: Colors.red,
                    ),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage:
                    //       AssetImage('images/phone-call_597177.png'),
                    // ),
                    title: const Row(
                      children: [
                        Text(
                          "Omkar",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 165,
                        ),
                        // Icon(
                        //   Icons.call,
                        //   size: 13,
                        // ),
                        Text(
                          "Incoming",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                    subtitle: const Text("Today, 20:16 PM"),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryPageView())),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
