
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(frontCamera, ResolutionPreset.max);
    await _cameraController.initialize();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Example'),
      ),
      body: _cameraController.value.isInitialized
         ? CameraPreview(_cameraController)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}