import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../ui/audio_list/view/audio_list_view.dart';

class AudioTrackModel {
  List<AudioAlbumTracks>? audioAlbumTracks;

  AudioTrackModel({this.audioAlbumTracks});

  AudioTrackModel.fromJson(Map<String, dynamic> json) {
    if (json['audio_album_tracks'] != null) {
      audioAlbumTracks = <AudioAlbumTracks>[];
      json['audio_album_tracks'].forEach((v) {
        audioAlbumTracks!.add(AudioAlbumTracks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audioAlbumTracks != null) {
      data['audio_album_tracks'] =
          audioAlbumTracks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AudioAlbumTracks {
  String? name;
  String? url;
  bool isPlay = false;
  bool isLoader = false;
  bool isPlayLoader = false;
  bool isDownload = false;
  bool isIndicator = false;


  AudioAlbumTracks({this.name, this.url});

  AudioAlbumTracks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
