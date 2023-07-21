import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/pictures_repository.dart';
import '../../domain/picture.dart';
part 'pictures_stream.g.dart';

@riverpod
Stream<Iterable<Picture>> picturesStream(Ref ref) {
  final repository = ref.read(picturesRepositoryProvider);

  return repository.getAllPictures();
}
