import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rethink/config/extensions.dart';
import 'package:rethink/config/gemini.dart';

import '../config/routes.dart';

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
                    : Stack(fit: StackFit.expand, children: [
                        CameraPreview(controller),
                        Center(
                            child: Opacity(
                                opacity: 0.5,
                                child: Column(
                                  spacing: 8,
                                  children: [
                                    Text('Make sure item is within frame',
                                        textAlign: TextAlign.center),
                                    Icon(Icons.eco,
                                        color: context.colorScheme.surface),
                                  ],
                                )))
                      ]);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        floatingActionButton: loading
            ? SizedBox.shrink()
            : FloatingActionButton(
                onPressed: () async {
                  final file = await controller.takePicture();
                  final image = await file.readAsBytes();
                  setState(() => loading = true);
                  final info = await Gemini.info(image);
                  setState(() => loading = false);
                  if (context.mounted) {
                    context.pushNamed(Routes.itemInfoPage, extra: info);
                  }
                },
                child: const Icon(Icons.camera_alt)));
  }
}
