import 'package:flutter/material.dart';

import 'camera_page.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CameraPage())),
            child: const Icon(Icons.photo_camera_back)));
  }
}
