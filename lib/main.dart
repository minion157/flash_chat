import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isSaved = false;
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    print('flutter binding');
    print(e);
  }
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('not initialized');
    print(e);
  }
  isSaved = await getSavedData();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: isSaved ? ChatScreen.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

Future<bool> getSavedData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final String? email = pref.getString('savedEmail');
  final String? password = pref.getString('savedPassword');
  if (email != null && password != null) {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print('Sign-in error');
      print(e);
    }
  }
  return false;
}
