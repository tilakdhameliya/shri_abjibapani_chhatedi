import 'dart:io';
import 'package:satsang/model/books/books_model.dart';

import '../dio/dioclient.dart';
import '../model/audio/audio_album_model.dart';
import '../model/audio/audio_track_model.dart';
import '../model/magazine/magazine_model.dart';
import '../model/news/news_model.dart';
import '../model/photo/photo_album_model.dart';
import '../repository/repository.dart';


class ResumeData {
  File? file;
  String? id = "";

  Future<AudioAlbum> getAudioAlbum() {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getAudioAlbum();
  }

  Future<AudioTrackModel> getAudioTrack(String albumName) {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getAudioTrack(albumName);
  }

  Future<PhotoAlbums> getPhotoAlbum() {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getPhotoAlbum();
  }

  Future<NewsModel> getNews() {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getNews();
  }

  Future<MagazinesModel> getMagazine() {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getMagazine();
  }

  Future<BooksModel> getEBooks() {
    DioClient dioClient = DioClient(isPassAuth: false);
    return Repository(dioClient).getEBooks();
  }
}
