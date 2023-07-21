import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/pictures_repository.dart';

part 'pictures_controller.g.dart';

@riverpod
class PicturesController extends _$PicturesController {
  @override
  Future<bool> build() {
    return Future.value(false);
  }

  Future<bool> _savePicture(PicturesRepository repository) async {
    final directory = Directory.systemTemp;
    final imagesFolder = directory
        .listSync(recursive: true)
        .firstWhere((element) => element.path.contains('images'));

    final files = (imagesFolder as Directory).listSync();

    final picture = await repository.savePicture(files.last as File);
    return picture;
  }

  Future<bool> commandSave() async {
    final repository = ref.read(picturesRepositoryProvider);
    state = const AsyncLoading();
    final response = await _savePicture(repository);
    state = const AsyncData(true);

    return response;
  }
}
