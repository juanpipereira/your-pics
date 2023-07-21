import 'dart:io';

import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pictures/presentation/controllers/pictures_controller.dart';

class CameraPage extends StatelessWidget {
  const CameraPage(
    this.tabController, {
    super.key,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(
          pathBuilder: () async {
            final tempDirectory = Directory.systemTemp;
            final path = DateTime.now().millisecondsSinceEpoch.toString();
            final imagesDir = await Directory('${tempDirectory.path}/images')
                .create(recursive: true);
            final fileName = '${imagesDir.path}/$path.jpg';

            return fileName;
          },
        ),
        enablePhysicalButton: true,
        flashMode: FlashMode.none,
        aspectRatio: CameraAspectRatios.ratio_16_9,
        previewFit: CameraPreviewFit.fitWidth,
        onMediaTap: (mediaCapture) {
          OpenFile.open(mediaCapture.filePath);
        },
        topActionsBuilder: (state) => Consumer(
          builder: (_, ref, __) {
            final isLoading = ref.watch(
                picturesControllerProvider.select((value) => value.isLoading));
            return Container(
              color: Colors.black45,
              height: 60.0,
              width: double.infinity,
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () async {
                          final result = await ref
                              .read(picturesControllerProvider.notifier)
                              .commandSave();
                          if (result) {
                            tabController.index = 0;
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
