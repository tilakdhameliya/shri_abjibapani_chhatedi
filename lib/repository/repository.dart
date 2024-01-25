import 'dart:convert';
import 'package:dio/dio.dart';
import '../dio/dioclient.dart';
import '../model/audio/audio_album_model.dart';
import '../model/audio/audio_track_model.dart';
import '../model/books/books_model.dart';
import '../model/magazine/magazine_model.dart';
import '../model/news/news_model.dart';
import '../model/photo/photo_album_model.dart';
import '../utils/constant.dart';
import '../utils/debugs.dart';

class Repository {
  DioClient? dioClient;

  Repository([this.dioClient]);

  Future<AudioAlbum> getAudioAlbum() async {
    try {
      Response response = await dioClient!.dio.post<String>("",data: {
        "request":"get_audio_update"
      });

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return AudioAlbum.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return AudioAlbum.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return AudioAlbum();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return AudioAlbum.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return AudioAlbum();
      }
    }
  }

  Future<AudioTrackModel> getAudioTrack(String albumName) async {
    try {
      Response response = await dioClient!.dio.post<String>("",
          data: {"request": "get_audio_album_tracks", "album": albumName});

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return AudioTrackModel.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return AudioTrackModel.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return AudioTrackModel();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return AudioTrackModel.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return AudioTrackModel();
      }
    }
  }

  Future<PhotoAlbums> getPhotoAlbum() async {
    try {
      Response response = await dioClient!.dio.post<String>("",data: {
        "request":"get_photo_albums"
      });

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return PhotoAlbums.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return PhotoAlbums.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return PhotoAlbums();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return PhotoAlbums.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return PhotoAlbums();
      }
    }
  }

  Future<NewsModel> getNews() async {
    try {
      Response response = await dioClient!.dio.post<String>("",data: {
        "request":"get_news"
      });

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return NewsModel.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return NewsModel.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return NewsModel();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return NewsModel.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return NewsModel();
      }
    }
  }

  Future<MagazinesModel> getMagazine() async {
    try {
      Response response = await dioClient!.dio.post<String>("",data: {
        "request":"get_murti_magazines"
      });

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return MagazinesModel.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return MagazinesModel.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return MagazinesModel();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return MagazinesModel.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return MagazinesModel();
      }
    }
  }

  Future<BooksModel> getEBooks() async {
    try {
      Response response = await dioClient!.dio.post<String>("",data: {
        "request":"get_ebooks"
      });

      if (response.statusCode == Constant.responseSuccessCode) {
        var res = response.data;
        return BooksModel.fromJson(jsonDecode(res));
      } else if (response.statusCode == Constant.responseFailureCode) {
        var res = response.data;
        try {
          return BooksModel.fromJson(jsonDecode(res));
        } catch (e) {
          Debug.printLog(e.toString());
          return BooksModel();
        }
      } else {
        throw Exception('Exception -->> Failed to getInfo Please Try Again!');
      }
    } on DioError catch (ex) {
      try {
        var res = ex.response!.data;
        return BooksModel.fromJson(jsonDecode(res));
      } catch (e) {
        Debug.printLog(e.toString());
        return BooksModel();
      }
    }
  }

}
