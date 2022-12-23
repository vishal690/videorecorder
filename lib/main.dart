import 'package:flutter/material.dart';
import 'package:videorecorder/camera_page.dart';
import 'package:videorecorder/utils/HttpClintHelper.dart';
import 'package:videorecorder/utils/UrlConfig.dart';

import 'global_data.dart';

void main() {
  getstartuptoken();
  runApp(MyApp());
}

getstartuptoken() async {
  try {
    GlobalData.token = await HttpClientHelper.Get(UrlConfig.AppStartURL,
        contentType: ContentType.string);
    GlobalData.token = int.parse(GlobalData.token).toString();
    print(GlobalData.token);
  } catch (e) {
    print("Exception raised !! $e");
    AlertDialog(title: Text("Server Error"));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CameraPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
