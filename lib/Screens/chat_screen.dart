import "package:flutter/material.dart";
import "package:prac_chat/Constants/fonts.dart";
import "package:prac_chat/Widgets/Chat/new_message.dart";
import "../Widgets/Chat/message.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        leading:  const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(

            radius: 1,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            //backgroundImage: const NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRu5FZuFGnw61FjM4bhIq97AXB2BexZZa145Df1oP9t5w&usqp=CAU&ec=48665699'),
            child:  Icon(Icons.person,size: 30,color: Colors.grey,),
          ),
        ),
        title: const Text("Person name"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam_rounded, size : 30)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call,size: 25,)),
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.contact_page_rounded, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("View contact", style: CustomizedTextStyle.bold ),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.perm_media_rounded, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Media,links and docs", style: CustomizedTextStyle.bold),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.search_rounded, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Search", style: CustomizedTextStyle.bold,),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.volume_mute_rounded, color: Colors.black),
                    SizedBox(width: 10),
                    Text("Mute notifications", style: CustomizedTextStyle.bold,),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.message_rounded,color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Disappearing messages", style: CustomizedTextStyle.bold,),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.wallpaper_rounded, color: Colors.black,),
                    SizedBox(width: 10),
                    Text("Wallpaper", style: CustomizedTextStyle.bold ),
                  ],
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.expand_more_rounded,color: Colors.black),
                    SizedBox(width: 10),
                    Text("More", style: CustomizedTextStyle.bold),
                  ],
                ),
                onTap: () {
                  PopupMenuButton(itemBuilder: (context) {
                    return [
                      const PopupMenuItem(child: Text("Report")),
                      const PopupMenuItem(child: Text("Block")),
                      const PopupMenuItem(child: Text("Clear chat")),
                      const PopupMenuItem(child: Text("Export chat")),
                      const PopupMenuItem(child: Text("Add shortcut"))
                    ];
                  });
                },
              )
            ];
          })
        ],
      ),

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration:const   BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessages()
          ],
        ),
      ),


    );
  }
}
