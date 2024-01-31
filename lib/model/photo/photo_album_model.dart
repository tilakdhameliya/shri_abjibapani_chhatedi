class PhotoAlbums {
  List<PhotoAlbumsItem>? photoAlbums;

  PhotoAlbums({this.photoAlbums});

  PhotoAlbums.fromJson(Map<String, dynamic> json) {
    if (json['photo_albums'] != null) {
      photoAlbums = <PhotoAlbumsItem>[];
      json['photo_albums'].forEach((v) {
        photoAlbums!.add(PhotoAlbumsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (photoAlbums != null) {
      data['photo_albums'] = photoAlbums!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PhotoAlbumsItem {
  String? name;
  String? description;
  String? previewImage;
  List<Images>? images;

  PhotoAlbumsItem({this.name, this.description, this.previewImage, this.images});

  PhotoAlbumsItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    previewImage = json['preview_image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['preview_image'] = previewImage;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? title;
  String? imageUrl;
  String? thumbUrl;
  String? imageDescription;
  bool? isSelected = false;

  Images({this.title, this.imageUrl, this.thumbUrl, this.imageDescription});

  Images.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['image_url'];
    thumbUrl = json['thumb_url'];
    imageDescription = json['image_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['thumb_url'] = thumbUrl;
    data['image_description'] = imageDescription;
    return data;
  }
}
