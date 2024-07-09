// import 'dart:ffi';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

import 'pages/homePages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAcckXvsx5pbphrUVCMVMNK-Fy9Si2yRwc",
            appId: "1:848107942944:web:cbbfd1649470244bcdb845",
            messagingSenderId: "848107942944",
            projectId: "gemini-flutter-chat-app"));
  }

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
