import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propanochat/pages/chatscreen_page.dart';
import 'package:propanochat/utils/db_util.dart';
String urlImg='',name='',userID='';

class ChatRoomListTile extends StatefulWidget {
   final String lastMessage, chatRoomId, myUserID;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUserID);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  final DbUtil _db=DbUtil();
    

    @override
  void initState() {
    // TODO: implement initState

    _getUserInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

   
    return GestureDetector(
      onTap:(){

        Navigator.push(context, MaterialPageRoute(
   builder:(context)=>ChatScreenPage(userID,  name,) 
 
 ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical:8),
        child: Row(children: [
          ClipRRect(
            borderRadius:BorderRadius.circular(30),
            child:Image.network(
              urlImg,
              height:40,
              width:40
            )
          ),
          SizedBox(width:12),
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text(name, style:TextStyle(fontSize: 16)),
              SizedBox(height:3),
              Text(widget.lastMessage)
            ]
          )
        ],)),
    );

    
  }
 _getUserInfo() async{
 userID=widget.chatRoomId.replaceAll(widget.myUserID, "").replaceAll("_", "");
 DocumentSnapshot document= await _db.getUserById(userID);
 print(document.data());
 name=document.data()["name"];
 urlImg=document.data()["imgUrl"];
 }
_goToChat(){
 

}
}