import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:propanochat/utils/prefs_util.dart';


class DbUtil {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }
  
  Future getAllUsers() async {
    return FirebaseFirestore.instance
        .collection("users").get();
        
  }
  

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageInfoMap);
  }

  Future updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) async {
    print('deberia entrar en update');
    print(chatRoomId);
    return  FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .update(lastMessageInfoMap).then((value) => print('en teoria funciono'));
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUserID= await PrefsUtil().getUserId();
    print('fafaaf');
    //print('El user es $myUsername');
    return FirebaseFirestore.instance
        .collection("chatrooms")
       // .orderBy("lastMessageSendTs", descending: true)
        //.where("users", arrayContains: myUserID)
        .snapshots();
  }
  Future<QuerySnapshot> getAllChatRooms() async {
    String myUsername = await PrefsUtil().getUserId();
    print('fafaaf');
    print('El user es $myUsername');
    return FirebaseFirestore.instance.collection("chatrooms").get();
      } 

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).get();
  }
    Future<DocumentSnapshot> getUserById(String userID) async {
    return await FirebaseFirestore.instance.collection("users").doc(userID).get();
  }
}
