import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rethink/gemini_util.dart';
import 'package:rethink/pages/item_info.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  bool loading = false;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras.first, ResolutionPreset.high);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<void>(
            future: initCamera(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return loading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(children: [
                        CameraPreview(controller),
                        Padding(
                            padding: const EdgeInsets.all(200),
                            child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.white, width: 4))))
                      ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final file = await controller.takePicture();
              final image = await file.readAsBytes();
              setState(() => loading = true);
              final info = await GeminiUtil.info(image);
              setState(() => loading = false);
              if (context.mounted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemInfo(info: info)));
              }
            },
            child: const Icon(Icons.camera_alt)));
  }
}
