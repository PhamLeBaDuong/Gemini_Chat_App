[33mcommit 767c6132702c0356670ac9610a5607cd9e309c2f[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmaster[m[33m)[m
Author: PhamLeBaDuong <duong1234da@gmail.com>
Date:   Tue Jul 9 19:40:00 2024 +0700

    Setting up firebase

[1mdiff --git a/android/app/build.gradle b/android/app/build.gradle[m
[1mindex 8cea0d9..744ca45 100644[m
[1m--- a/android/app/build.gradle[m
[1m+++ b/android/app/build.gradle[m
[36m@@ -3,6 +3,7 @@[m [mplugins {[m
     id "kotlin-android"[m
     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.[m
     id "dev.flutter.flutter-gradle-plugin"[m
[32m+[m[32m    id "com.google.gms.google-services"[m
 }[m
 [m
 def localProperties = new Properties()[m
[1mdiff --git a/android/app/google-services.json b/android/app/google-services.json[m
[1mnew file mode 100644[m
[1mindex 0000000..72ed32a[m
[1m--- /dev/null[m
[1m+++ b/android/app/google-services.json[m
[36m@@ -0,0 +1,29 @@[m
[32m+[m[32m{[m
[32m+[m[32m  "project_info": {[m
[32m+[m[32m    "project_number": "848107942944",[m
[32m+[m[32m    "project_id": "gemini-flutter-chat-app",[m
[32m+[m[32m    "storage_bucket": "gemini-flutter-chat-app.appspot.com"[m
[32m+[m[32m  },[m
[32m+[m[32m  "client": [[m
[32m+[m[32m    {[m
[32m+[m[32m      "client_info": {[m
[32m+[m[32m        "mobilesdk_app_id": "1:848107942944:android:4ec0babdea648c99cdb845",[m
[32m+[m[32m        "android_client_info": {[m
[32m+[m[32m          "package_name": "com.example.flutter_application_1"[m
[32m+[m[32m        }[m
[32m+[m[32m      },[m
[32m+[m[32m      "oauth_client": [],[m
[32m+[m[32m      "api_key": [[m
[32m+[m[32m        {[m
[32m+[m[32m          "current_key": "AIzaSyDPc56bxlSzbb4Z_fbFQE7a39Pbbl3V5XQ"[m
[32m+[m[32m        }[m
[32m+[m[32m      ],[m
[32m+[m[32m      "services": {[m
[32m+[m[32m        "appinvite_service": {[m
[32m+[m[32m          "other_platform_oauth_client": [][m
[32m+[m[32m        }[m
[32m+[m[32m      }[m
[32m+[m[32m    }[m
[32m+[m[32m  ],[m
[32m+[m[32m  "configuration_version": "1"[m
[32m+[m[32m}[m
\ No newline at end of file[m
[1mdiff --git a/android/settings.gradle b/android/settings.gradle[m
[1mindex 536165d..8953811 100644[m
[1m--- a/android/settings.gradle[m
[1m+++ b/android/settings.gradle[m
[36m@@ -20,6 +20,7 @@[m [mplugins {[m
     id "dev.flutter.flutter-plugin-loader" version "1.0.0"[m
     id "com.android.application" version "7.3.0" apply false[m
     id "org.jetbrains.kotlin.android" version "1.7.10" apply false[m
[32m+[m[32m    id "com.google.gms.google-services" version "4.4.2" apply false[m
 }[m
 [m
 include ":app"[m
[1mdiff --git a/ios/Runner/GoogleService-Info.plist b/ios/Runner/GoogleService-Info.plist[m
[1mnew file mode 100644[m
[1mindex 0000000..0d8d6e9[m
[1m--- /dev/null[m
[1m+++ b/ios/Runner/GoogleService-Info.plist[m
[36m@@ -0,0 +1,30 @@[m
[32m+[m[32m<?xml version="1.0" encoding="UTF-8"?>[m
[32m+[m[32m<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">[m
[32m+[m[32m<plist version="1.0">[m
[32m+[m[32m<dict>[m
[32m+[m	[32m<key>API_KEY</key>[m
[32m+[m	[32m<string>AIzaSyB9ZmfVv1PvEHWDpaY1AD01kh86pMNI2DE</string>[m
[32m+[m	[32m<key>GCM_SENDER_ID</key>[m
[32m+[m	[32m<string>848107942944</string>[m
[32m+[m	[32m<key>PLIST_VERSION</key>[m
[32m+[m	[32m<string>1</string>[m
[32m+[m	[32m<key>BUNDLE_ID</key>[m
[32m+[m	[32m<string>com.example.flutterApplication1</string>[m
[32m+[m	[32m<key>PROJECT_ID</key>[m
[32m+[m	[32m<string>gemini-flutter-chat-app</string>[m
[32m+[m	[32m<key>STORAGE_BUCKET</key>[m
[32m+[m	[32m<string>gemini-flutter-chat-app.appspot.com</string>[m
[32m+[m	[32m<key>IS_ADS_ENABLED</key>[m
[32m+[m	[32m<false></false>[m
[32m+[m	[32m<key>IS_ANALYTICS_ENABLED</key>[m
[32m+[m	[32m<false></false>[m
[32m+[m	[32m<key>IS_APPINVITE_ENABLED</key>[m
[32m+[m	[32m<true></true>[m
[32m+[m	[32m<key>IS_GCM_ENABLED</key>[m
[32m+[m	[32m<true></true>[m
[32m+[m	[32m<key>IS_SIGNIN_ENABLED</key>[m
[32m+[m	[32m<true></true>[m
[32m+[m	[32m<key>GOOGLE_APP_ID</key>[m
[32m+[m	[32m<string>1:848107942944:ios:e0338ed0394b2a9ecdb845</string>[m
[32m+[m[32m</dict>[m
[32m+[m[32m</plist>[m
\ No newline at end of file[m
[1mdiff --git a/lib/main.dart b/lib/main.dart[m
[1mindex bd1bffa..862ac56 100644[m
[1m--- a/lib/main.dart[m
[1m+++ b/lib/main.dart[m
[36m@@ -1,18 +1,32 @@[m
[31m-import 'dart:ffi';[m
[31m-import 'dart:io';[m
[31m-import 'dart:typed_data';[m
[32m+[m[32m// import 'dart:ffi';[m
[32m+[m[32m// import 'dart:io';[m
[32m+[m[32m// import 'dart:typed_data';[m
 [m
[31m-import 'package:dash_chat_2/dash_chat_2.dart';[m
[32m+[m[32m// import 'package:dash_chat_2/dash_chat_2.dart';[m
[32m+[m[32mimport 'package:flutter/foundation.dart';[m
 import 'package:flutter/material.dart';[m
[32m+[m
[32m+[m[32mimport 'package:firebase_core/firebase_core.dart';[m
 //import 'package:flutter_gemini/flutter_gemini.dart';[m
[31m-import 'package:google_generative_ai/google_generative_ai.dart';[m
[31m-import 'package:image_picker/image_picker.dart';[m
[31m-import 'package:provider/provider.dart';[m
[32m+[m[32m// import 'package:google_generative_ai/google_generative_ai.dart';[m
[32m+[m[32m// import 'package:image_picker/image_picker.dart';[m
[32m+[m[32m// import 'package:provider/provider.dart';[m
 [m
 import 'pages/homePages.dart';[m
 [m
[31m-void main() {[m
[31m-  //Gemini.init(apiKey: "AIzaSyAqa3TgDPWoGywDrm3poSg_pgtSRfCHMm0");[m
[32m+[m[32mFuture main() async {[m
[32m+[m[32m  WidgetsFlutterBinding.ensureInitialized();[m
[32m+[m
[32m+[m[32m  if (kIsWeb) {[m
[32m+[m[32m    await Firebase.initializeApp([m
[32m+[m[32m        options: FirebaseOptions([m
[32m+[m[32m            apiKey: "AIzaSyAcckXvsx5pbphrUVCMVMNK-Fy9Si2yRwc",[m
[32m+[m[32m            appId: "1:848107942944:web:cbbfd1649470244bcdb845",[m
[32m+[m[32m            messagingSenderId: "848107942944",[m
[32m+[m[32m            projectId: "gemini-flutter-chat-app"));[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  await Firebase.initializeApp();[m
   runApp(MyApp());[m
 }[m
 [m
[1mdiff --git a/lib/pages/createPassword.dart b/lib/pages/createPassword.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..8b13789[m
[1m--- /dev/null[m
[1m+++ b/lib/pages/createPassword.dart[m
[36m@@ -0,0 +1 @@[m
[32m+[m
[1mdiff --git a/lib/pages/forget.dart b/lib/pages/forget.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..e69de29[m
[1mdiff --git a/lib/pages/homePages.dart b/lib/pages/homePages.dart[m
[1mindex 01fe108..ff9dfdb 100644[m
[1m--- a/lib/pages/homePages.dart[m
[1m+++ b/lib/pages/homePages.dart[m
[36m@@ -55,7 +55,7 @@[m [mclass _HomePageState extends State<HomePage> {[m
           ),[m
           BottomNavigationBarItem([m
             icon: Icon(Icons.account_box),[m
[31m-            label: "blabla",[m
[32m+[m[32m            label: "Account",[m
           ),[m
         ],[m
       ),[m
[36m@@ -69,9 +69,9 @@[m [mclass _HomePageState extends State<HomePage> {[m
     try {[m
       //String question = chatMessage.text;[m
       List<Uint8List>? images;[m
[31m-      if (chatMessage.medias?.isNotEmpty ?? false) {[m
[31m-        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];[m
[31m-      }[m
[32m+[m[32m      // if (chatMessage.medias?.isNotEmpty ?? false) {[m
[32m+[m[32m      //   images = [File(chatMessage.medias!.first.url).readAsBytesSync()];[m
[32m+[m[32m      // }[m
       var response = await chat.sendMessage(Content.text(chatMessage.text));[m
       // gemini.streamGenerateContent(question, images: images).listen((event) {[m
       //   ChatMessage? lastMassage = messages.firstOrNull;[m
[1mdiff --git a/lib/pages/login.dart b/lib/pages/login.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..e69de29[m
[1mdiff --git a/lib/pages/signup.dart b/lib/pages/signup.dart[m
[1mnew file mode 100644[m
[1mindex 0000000..e69de29[m
[1mdiff --git a/macos/Flutter/GeneratedPluginRegistrant.swift b/macos/Flutter/GeneratedPluginRegistrant.swift[m
[1mindex 5321b91..07b5398 100644[m
[1m--- a/macos/Flutter/GeneratedPluginRegistrant.swift[m
[1m+++ b/macos/Flutter/GeneratedPluginRegistrant.swift[m
[36m@@ -6,6 +6,7 @@[m [mimport FlutterMacOS[m
 import Foundation[m
 [m
 import file_selector_macos[m
[32m+[m[32mimport firebase_core[m
 import path_provider_foundation[m
 import sqflite[m
 import url_launcher_macos[m
[36m@@ -13,6 +14,7 @@[m [mimport video_player_avfoundation[m
 [m
 func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {[m
   FileSelectorPlugin.register(with: registry.registrar(forPlugin: "FileSelectorPlugin"))[m
[32m+[m[32m  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))[m
   PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))[m
   SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))[m
   UrlLauncherPlugin.register(with: registry.registrar(forPlugin: "UrlLauncherPlugin"))[m
[1mdiff --git a/pubspec.lock b/pubspec.lock[m
[1mindex bb9d77b..05b9ac9 100644[m
[1m--- a/pubspec.lock[m
[1m+++ b/pubspec.lock[m
[36m@@ -177,6 +177,30 @@[m [mpackages:[m
       url: "https://pub.dev"[m
     source: hosted[m
     version: "0.9.3+1"[m
[32m+[m[32m  firebase_core:[m
[32m+[m[32m    dependency: "direct main"[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_core[m
[32m+[m[32m      sha256: "1e06b0538ab3108a61d895ee16951670b491c4a94fce8f2d30e5de7a5eca4b28"[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "3.1.1"[m
[32m+[m[32m  firebase_core_platform_interface:[m
[32m+[m[32m    dependency: transitive[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_core_platform_interface[m
[32m+[m[32m      sha256: "1003a5a03a61fc9a22ef49f37cbcb9e46c86313a7b2e7029b9390cf8c6fc32cb"[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "5.1.0"[m
[32m+[m[32m  firebase_core_web:[m
[32m+[m[32m    dependency: transitive[m
[32m+[m[32m    description:[m
[32m+[m[32m      name: firebase_core_web[m
[32m+[m[32m      sha256: "6643fe3dbd021e6ccfb751f7882b39df355708afbdeb4130fc50f9305a9d1a3d"[m
[32m+[m[32m      url: "https://pub.dev"[m
[32m+[m[32m    source: hosted[m
[32m+[m[32m    version: "2.17.2"[m
   fixnum:[m
     dependency: transitive[m
     description:[m
[1mdiff --git a/pubspec.yaml b/pubspec.yaml[m
[1mindex ee5ca92..fff3d82 100644[m
[1m--- a/pubspec.yaml[m
[1m+++ b/pubspec.yaml[m
[36m@@ -19,6 +19,7 @@[m [mdependencies:[m
 [m
   english_words: ^4.0.0[m
   provider: ^6.0.0[m
[32m+[m[32m  firebase_core: ^3.1.1[m
 [m
 dev_dependencies:[m
   flutter_test:[m
[1mdiff --git a/test/widget_test.dart b/test/widget_test.dart[m
[1mindex 2808800..1356379 100644[m
[1m--- a/test/widget_test.dart[m
[1m+++ b/test/widget_test.dart[m
[36m@@ -8,12 +8,12 @@[m
 import 'package:flutter/material.dart';[m
 import 'package:flutter_test/flutter_test.dart';[m
 [m
[31m-import 'package:flutter_application_1/main.dart';[m
[32m+[m[32mimport 'package:namer_app/main.dart';[m
 [m
 void main() {[m
   testWidgets('Counter increments smoke test', (WidgetTester tester) async {[m
     // Build our app and trigger a frame.[m
[31m-    await tester.pumpWidget(const MyApp());[m
[32m+[m[32m    await tester.pumpWidget(MyApp());[m
 [m
     // Verify that our counter starts at 0.[m
     expect(find.text('0'), findsOneWidget);[m
[1mdiff --git a/windows/flutter/generated_plugin_registrant.cc b/windows/flutter/generated_plugin_registrant.cc[m
[1mindex 043a96f..df0aa17 100644[m
[1m--- a/windows/flutter/generated_plugin_registrant.cc[m
[1m+++ b/windows/flutter/generated_plugin_registrant.cc[m
[36m@@ -7,11 +7,14 @@[m
 #include "generated_plugin_registrant.h"[m
 [m
 #include <file_selector_windows/file_selector_windows.h>[m
[32m+[m[32m#include <firebase_core/firebase_core_plugin_c_api.h>[m
 #include <url_launcher_windows/url_launcher_windows.h>[m
 [m
 void RegisterPlugins(flutter::PluginRegistry* registry) {[m
   FileSelectorWindowsRegisterWithRegistrar([m
       registry->GetRegistrarForPlugin("FileSelectorWindows"));[m
[32m+[m[32m  FirebaseCorePluginCApiRegisterWithRegistrar([m
[32m+[m[32m      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));[m
   UrlLauncherWindowsRegisterWithRegistrar([m
       registry->GetRegistrarForPlugin("UrlLauncherWindows"));[m
 }[m
[1mdiff --git a/windows/flutter/generated_plugins.cmake b/windows/flutter/generated_plugins.cmake[m
[1mindex a95e267..420205d 100644[m
[1m--- a/windows/flutter/generated_plugins.cmake[m
[1m+++ b/windows/flutter/generated_plugins.cmake[m
[36m@@ -4,6 +4,7 @@[m
 [m
 list(APPEND FLUTTER_PLUGIN_LIST[m
   file_selector_windows[m
[32m+[m[32m  firebase_core[m
   url_launcher_windows[m
 )[m
 [m
