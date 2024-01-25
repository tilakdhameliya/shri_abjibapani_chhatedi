class AudioAlbum {
  List<AudioSections>? audioSections;
  List<AudioAlbums>? audioAlbums;
  List<AudioAlbumTracks>? audioAlbumTracks;
  String? lastUpdatedDate;

  AudioAlbum(
      {this.audioSections,
        this.audioAlbums,
        this.audioAlbumTracks,
        this.lastUpdatedDate});

  AudioAlbum.fromJson(Map<String, dynamic> json) {
    if (json['audio_sections'] != null) {
      audioSections = <AudioSections>[];
      json['audio_sections'].forEach((v) {
        audioSections!.add(AudioSections.fromJson(v));
      });
    }
    if (json['audio_albums'] != null) {
      audioAlbums = <AudioAlbums>[];
      json['audio_albums'].forEach((v) {
        audioAlbums!.add(AudioAlbums.fromJson(v));
      });
    }
    if (json['audio_album_tracks'] != null) {
      audioAlbumTracks = <AudioAlbumTracks>[];
      json['audio_album_tracks'].forEach((v) {
        audioAlbumTracks!.add(AudioAlbumTracks.fromJson(v));
      });
    }
    lastUpdatedDate = json['last_updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (audioSections != null) {
      data['audio_sections'] =
          audioSections!.map((v) => v.toJson()).toList();
    }
    if (audioAlbums != null) {
      data['audio_albums'] = audioAlbums!.map((v) => v.toJson()).toList();
    }
    if (audioAlbumTracks != null) {
      data['audio_album_tracks'] =
          audioAlbumTracks!.map((v) => v.toJson()).toList();
    }
    data['last_updated_date'] = lastUpdatedDate;
    return data;
  }
}

class AudioSections {
  String? sectionId;
  String? name;
  String? image;
  String? sortId;
  String? isDeleted;

  AudioSections(
      {this.sectionId, this.name, this.image, this.sortId, this.isDeleted});

  AudioSections.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    name = json['name'];
    image = json['image'];
    sortId = json['sort_id'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['name'] = name;
    data['image'] = image;
    data['sort_id'] = sortId;
    data['is_deleted'] = isDeleted;
    return data;
  }
}

class AudioAlbums {
  String? albumId;
  String? name;
  String? image;
  String? sectionId;
  String? sortId;
  String? isDeleted;

  AudioAlbums(
      {this.albumId,
        this.name,
        this.image,
        this.sectionId,
        this.sortId,
        this.isDeleted});

  AudioAlbums.fromJson(Map<String, dynamic> json) {
    albumId = json['album_id'];
    name = json['name'];
    image = json['image'];
    sectionId = json['section_id'];
    sortId = json['sort_id'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['album_id'] = albumId;
    data['name'] = name;
    data['image'] = image;
    data['section_id'] = sectionId;
    data['sort_id'] = sortId;
    data['is_deleted'] = isDeleted;
    return data;
  }
}

class AudioAlbumTracks {
  String? trackId;
  String? name;
  String? url;
  String? albumId;
  String? sortId;
  String? isDeleted;

  AudioAlbumTracks(
      {this.trackId,
        this.name,
        this.url,
        this.albumId,
        this.sortId,
        this.isDeleted});

  AudioAlbumTracks.fromJson(Map<String, dynamic> json) {
    trackId = json['track_id'];
    name = json['name'];
    url = json['url'];
    albumId = json['album_id'];
    sortId = json['sort_id'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['track_id'] = trackId;
    data['name'] = name;
    data['url'] = url;
    data['album_id'] = albumId;
    data['sort_id'] = sortId;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
