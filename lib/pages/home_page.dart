import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:propanochat/pages/chatscreen_page.dart';
import 'package:propanochat/pages/signin.dart';
import 'package:propanochat/utils/auth_util.dart';
import 'package:propanochat/utils/db_util.dart';
import 'package:propanochat/utils/prefs_util.dart';
import 'package:propanochat/widgets/ChatRoomListTile_widget.dart';
import 'package:propanochat/widgets/UserListTile_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbUtil _db=DbUtil();
  final PrefsUtil _prefs=PrefsUtil();
  Stream chatRoomsStream;
  @override
  void initState() {
    // TODO: implement initState
    _getChatRooms();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 49.0,
            title: TabBar(
              indicatorColor: Colors.lightGreenAccent[700],
              tabs: [
                Container(
                  height: 47.0,
                  child: new Tab(text: 'Chats'),
                ),
                Container(
                  height: 47.0,
                  child: new Tab(text: 'Usuarios'),
                ),
                  Container(
                  height: 47.0,
                  child: new Tab(icon:Icon(Icons.account_box) ,),
                ),
              ],
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: Colors.grey[600],
            ),
          ),
          body: TabBarView(
            children: [
               _chatRoomsList(),
              _getUserList(),
               logout()
                 
            ],
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );

  }
  Widget logout(){
    return Column(
      children: [
        TextButton(child:Text('Salir'),
        onPressed: () {
              AuthUtil().signOut().then((s) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SigninPage()));
              });
            },)
      ],
    
      
    );
  }
Widget _chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        print("vuil");
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  print(ds.data());
                  List users=ds["users"];
                  if(users.contains(PrefsUtil().getUserId())){
                  
  return ChatRoomListTile(ds["lastMessage"], ds.id, PrefsUtil().getUserId());
                  }else{
                    return Container();
                  }
                
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }
 _getChatRooms() async{
chatRoomsStream=await _db.getChatRooms();

}
Widget _getUserList(){
return FutureBuilder(
    future: DbUtil().getAllUsers(),
   
    builder: (BuildContext context, AsyncSnapshot snapshot) {
  
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  if(_prefs.getUserId()!=ds.id){
  return UserListTile(
                    id: ds.id,
                      imgUrl: ds["imgUrl"],
                      name: ds["name"],
                      email: ds["email"],
                      );
                  }else{

                    return Container();
                  }
                
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
     
    },
  );
}



}



