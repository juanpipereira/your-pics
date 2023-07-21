import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/picture.dart';
part 'pictures_repository.g.dart';

class PicturesRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<bool> savePicture(File file) async {
    final filePath = file.path.split('/').last.split('.').first;
    final date = DateTime.now();
    final formattedDate =
        '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';

    try {
      final TaskSnapshot taskSnapshot =
          await _storage.ref('images/$filePath').putFile(file);
      final downloadUrl = await taskSnapshot.ref.getDownloadURL();

      final picture = Picture(
        createdDate: formattedDate,
        url: downloadUrl,
      );

      await _addPicture(picture);

      return true;
    } catch (e) {
      debugPrint(e.toString());

      return false;
    }
  }

  Stream<Iterable<Picture>> getAllPictures() {
    return _firestore.collection('pictures').snapshots().map(
          (snapshot) => snapshot.docs.map(
            (d) => Picture.fromJson(d.data()),
          ),
        );
  }

  Future<bool> _addPicture(Picture picture) async {
    final picturesCollection = _firestore.collection('pictures');

    try {
      await picturesCollection.add(picture.toJson());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

@riverpod
PicturesRepository picturesRepository(Ref ref) => PicturesRepository();
