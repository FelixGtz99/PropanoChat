

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:propanochat/pages/home_page.dart';
import 'package:propanochat/pages/signin.dart';
import 'package:propanochat/utils/auth_util.dart';
import 'package:propanochat/utils/prefs_util.dart';
 
void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
  final prefs = PrefsUtil();
  await prefs.initPrefs();
runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme(),
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthUtil().getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
 return HomePage();

          }else{
 return SigninPage();

          }
         
        },
      ),
    );
    
  }
    ThemeData myTheme() {
    //green
    final accentColor = Color.fromRGBO(49, 232, 93, 1);
    final primaryColor = Colors.white;
    //gray
    final altColor = Color.fromRGBO(210, 210, 210, 1);
    return ThemeData(
        iconTheme: IconThemeData(color: altColor),
        primaryColor: primaryColor,
        accentColor: primaryColor,
        buttonTheme: ButtonThemeData(
            buttonColor: accentColor, textTheme: ButtonTextTheme.accent));
  }
}