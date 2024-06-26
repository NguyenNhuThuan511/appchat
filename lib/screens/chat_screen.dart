
//import 'dart:convert';
//import 'dart:developer';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


//import 'package:appchat/api/apis.dart';
import '../main.dart';
import '../models/chat_user.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
        Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        body: Column(
          children: [
            
            _chatInput()],
        ),
      ),
    );
  }

  Widget _appBar(){
    return InkWell(
      onTap: (){},
      child: Row(
        children: [
          IconButton(onPressed: () => Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back, color: Colors.black54)),
          ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * .03),
              child: CachedNetworkImage(              
                width: mq.height * .05,
                height: mq.height * .05,
                fit: BoxFit.cover,
                imageUrl: widget.user.image,
                      //placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => 
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                      ),
            ),
      
            const SizedBox(width: 10),
      
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.user.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500)),
      
      
                  const SizedBox(height: 2),
                  const Text('Last seen not available',
                style: TextStyle(
                  fontSize: 13, color: Colors.black54)),
              ],
            )
        ],
      ),
    );
  }

  Widget _chatInput() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: mq.height * .01, horizontal: mq.width * .025),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                IconButton(
                  onPressed: () {}, 
                    icon: const Icon(Icons.emoji_emotions, 
                      color: Colors.blueAccent, size: 25)),
                 const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Type Somethig ..', 
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: InputBorder.none),
                )),
              
                IconButton(
                  onPressed: () {}, 
                    icon: const Icon(Icons.image, 
                    color: Colors.blueAccent, size: 26)),
              
              
                IconButton(
                  onPressed: () {}, 
                    icon: const Icon(Icons.camera_alt_rounded, 
                    color: Colors.blueAccent, size: 26)),



                SizedBox(width: mq.width * .02,),
              ]),
            ),
          ),
      
      
          MaterialButton(
            onPressed: (){},
            minWidth: 0,
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 10),
            shape: const CircleBorder(),
            color: Colors.green, 
            child: const Icon(Icons.send, color: Colors.white, size: 28))
        ],
      ),
    );
  }
}

