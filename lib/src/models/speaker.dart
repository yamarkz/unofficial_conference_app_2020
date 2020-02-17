import 'package:flutter/material.dart';

class Speaker {
  final String id;
  final String name;
  final String tagLine;
  final String bio;
  final String imageUrl;
  final bool isTopSpeaker;

  const Speaker({
    @required this.id,
    @required this.name,
    @required this.tagLine,
    @required this.bio,
    @required this.imageUrl,
    @required this.isTopSpeaker,
  });

  factory Speaker.fromJson(Map<dynamic, dynamic> json) {
    return Speaker(
      id: json['id'],
      name: json['fullName'],
      tagLine: json['tagLine'],
      bio: json['bio'],
      imageUrl: json['profilePicture'],
      isTopSpeaker: json['isTopSpeaker'],
    );
  }
}
