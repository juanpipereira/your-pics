// import 'package:cloud_firestore/cloud_firestore.dart';

class Picture {
  const Picture({
    required this.createdDate,
    this.url,
  });

  final String? url;
  final String createdDate;

  factory Picture.fromJson(
    Map<String, dynamic> json,
  ) {
    return Picture(
      createdDate: json['createdDate'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdDate': createdDate,
      'url': url,
    };
  }

  // factory Picture.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return Picture(
  //     createdDate: data?['createdDate'],
  //     url: data?['url'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     'createdDate': createdDate,
  //     'url': url,
  //   };
  // }

  // factory Picture.fromJson(Map<String, dynamic> json) {
  //   return Picture(
  //     createdDate: json['createdDate'],
  //     url: json['url'],
  //   );
  // }

  // factory Picture.fromDocument(DocumentSnapshot doc) {
  //   final data = doc.get(field);
  //   return Picture.fromJson(data)
  // }
}
