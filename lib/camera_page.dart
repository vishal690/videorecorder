import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:videorecorder/gallary_save_file.dart';
import 'package:videorecorder/utils/Common.dart';

import 'global_data.dart';
import 'log_helper.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  static const maxSeconds = 0;
  int seconds = maxSeconds;
  Timer? timer;
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  void stopTimer({bool reset = true}) {
    seconds = 0;
    timer?.cancel();
  }

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    _cameraController = CameraController(front, ResolutionPreset.low);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      stopTimer();
      var newFilePath =
          await Common.changeFileNameOnly(File(file.path), GlobalData.fileName);
      GallarySaveFile.save(newFilePath.path);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      GlobalData.fileName = Common.getFileName();
      startTimer();
      setState(() => _isRecording = true);
    }
  }

  _recordTime() {
    apiLogger(DateTime.now().millisecondsSinceEpoch.toString());
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    String fileno = "File Number: " + GlobalData.token;
    if (_isLoading) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(248, 131, 133, 131),
          title: Text(fileno),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: deviceHeight * 0.778,
                  width: deviceWidth * 1,
                  color: Color.fromARGB(248, 218, 219, 218),
                  child: CameraPreview(_cameraController),
                ),
                Container(
                  color: Color.fromARGB(248, 218, 219, 218),
                  height: deviceHeight * 0.09,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: Icon(_isRecording ? Icons.stop : Icons.circle),
                          onPressed: () {
                            _recordVideo();
                          }),
                      Text(Common.formatDuration(seconds),
                          style: TextStyle(color: Colors.black)),
                      FloatingActionButton(
                        backgroundColor: Color.fromARGB(248, 29, 184, 62),
                        child: Icon(_isRecording
                            ? Icons.access_time_filled_sharp
                            : Icons.access_alarms),
                        onPressed: () => _recordTime(),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
