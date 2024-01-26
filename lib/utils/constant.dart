
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../model/audio/audio_album_model.dart';
import '../model/books/books_model.dart';
import '../model/magazine/magazine_model.dart';
import '../model/news/news_model.dart';
import '../model/photo/photo_album_model.dart';

class Constant {
  static const responseFailureCode = 400;
  static const responseSuccessCode = 200;
  static const responseCreatedCode = 201;
  static const responseUnauthorizedCode = 401;
  static const responsePaymentRequired = 402;
  static const responseRequired = 422;
  static const responseNotFound = 404;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static bool isShowBottomSheet = false;


  static const idDateTimeController = 'idDateTimeController';
  static var mainURL = "";

  static bool isCreateResume = false;
  static bool isEdit = false;
  static String resumeId = "";
  static bool isEmail = false;
  static bool isNotification = false;
  static bool isStorage = false;
  static bool isGetNotificationPermission = false;
  static bool isGetStoragePermission = false;
  static bool isShowDropDown = false;
  static bool isOffline = true;

  static List<AudioAlbums> audioAlbum = [];
  static List<AudioSections> audioSection = [];
  static List<AudioAlbums> subAudio = [];
  static List<PhotoAlbumsItem> photoAlbum = [];
  static List<News> newsList = [];
  static List<MurtiMagazines> magazines = [];
  static List<Ebooks> eBooks = [];


  static PageController photoController = PageController(initialPage: 0,keepPage: true);

}
