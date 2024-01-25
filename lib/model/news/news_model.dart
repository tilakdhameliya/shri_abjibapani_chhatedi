class NewsModel {
  List<News>? news;

  NewsModel({this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  int? id;
  String? title;
  String? excerpt;
  String? content;
  String? author;
  String? time;
  String? thumb;

  News(
      {this.id,
        this.title,
        this.excerpt,
        this.content,
        this.author,
        this.time,
        this.thumb});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    excerpt = json['excerpt'];
    content = json['content'];
    author = json['author'];
    time = json['time'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['excerpt'] = excerpt;
    data['content'] = content;
    data['author'] = author;
    data['time'] = time;
    data['thumb'] = thumb;
    return data;
  }
}
