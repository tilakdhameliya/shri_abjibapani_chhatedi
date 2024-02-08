class BooksModel {
  List<Ebooks>? ebooks;

  BooksModel({this.ebooks});

  BooksModel.fromJson(Map<String, dynamic> json) {
    if (json['ebooks'] != null) {
      ebooks = <Ebooks>[];
      json['ebooks'].forEach((v) {
        ebooks!.add(Ebooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ebooks != null) {
      data['ebooks'] = ebooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ebooks {
  String? name;
  String? url;
  String? image;
  bool? isLoader = false;
  bool? isDownload = false;

  Ebooks({this.name, this.url, this.image});

  Ebooks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}
