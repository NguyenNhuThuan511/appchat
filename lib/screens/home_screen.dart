import '../models/chat_user.dart';
import 'package:appchat/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:appchat/witgets/chat_user_card.dart';
import '../api/apis.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> _list = [];
  final List<ChatUser> _seachlist = [];
  bool _isSearChing = false;
  @override
  void initState(){
    super.initState();
    APIs.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () {
          if(_isSearChing){
            setState(() {
              _isSearChing = !_isSearChing;
            });
          return Future.value(false);  
          } else{}
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
              leading: const Icon(CupertinoIcons.home),
              title: _isSearChing 
              ? TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Name, Email, ...'),
                autofocus: true,
                style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                onChanged: (val){
                  _seachlist.clear();
        
                  for (var i in _list) {
                    if(i.name.toLowerCase().contains(val.toLowerCase()) || 
                        i.email.toLowerCase().contains(val.toLowerCase())) {
                      _seachlist.add(i);
                    }
                    setState(() {
                      _seachlist;
                    });
                    
                  }
                },
              ) : const Text('AppChat'),
              actions: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      _isSearChing = !_isSearChing;
                    });
                  }, 
                  icon: Icon(_isSearChing
                ? CupertinoIcons.clear_circled_solid
                : Icons.search)),
                
                IconButton(
                  onPressed: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                    builder: (_) => ProfileScreen(user: APIs.me)));
                }, 
                icon: const Icon(Icons.more_vert)),
              ],
            ),
            // ignore: prefer_const_constructors
          floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                onPressed: () async {
                  await APIs.auth.signOut();
                  await GoogleSignIn().signOut;
                }, 
                child: const Icon(Icons.add_comment_rounded)),
            ),
        
          body: StreamBuilder(
            stream: APIs.getAllUsers(),
            builder: (context, snapshot) {   
        
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());
        
                case ConnectionState.active:
                case ConnectionState.done:
        
                
        
              
                final data = snapshot.data?.docs;
                _list = 
                data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];   
              
                if(_list.isNotEmpty){
                  return ListView.builder(
                  itemCount: _isSearChing ? _seachlist.length : _list.length,
                  padding: EdgeInsets.only(top: mq.height * .01),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return  ChatUserCard(user:
                    _isSearChing ? _seachlist[index] : _list[index]);
                    // return Text('Name: ${list[index]}');
                  }); 
                }
                else {
                  return const Center(
                    child: Text('Không tìm thấy kết nối nào!',
                        style: TextStyle(fontSize: 20)),
                  );
                }
              }
            }, 
          ),
        ),
      ),
    );
  }
}