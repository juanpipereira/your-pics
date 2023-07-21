import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_pics/features/camera/presentation/pages/camera_page.dart';
import 'package:your_pics/features/core/presentation/widgets/custom_scaffold.dart';

import 'features/pictures/presentation/pages/pictures_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    ProviderScope(
      child: MainApp(
        camera: firstCamera,
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    required this.camera,
    super.key,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomScaffold(
        tabs: const [
          Tab(
            icon: Icon(Icons.photo_camera_back_rounded),
            text: 'Your Pics',
          ),
          Tab(
            icon: Icon(Icons.camera_alt_rounded),
            text: 'Take a Pic',
          ),
        ],
        tabsViews: (TabController tabController) => [
          PicturesPage(tabController),
          CameraPage(
            tabController,
            // camera: camera,
          ),
        ],
      ),
    );
  }
}
