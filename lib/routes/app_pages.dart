import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/ui/audio/binding/audio_binding.dart';
import 'package:satsang/ui/audio/view/audio_view.dart';
import 'package:satsang/ui/audio_list/binding/audio_list_binding.dart';
import 'package:satsang/ui/audio_list/view/audio_list_view.dart';
import 'package:satsang/ui/books/binding/books_binding.dart';
import 'package:satsang/ui/books/view/books_screen.dart';
import 'package:satsang/ui/contact_us/binding/contact_us_binding.dart';
import 'package:satsang/ui/contact_us/view/contact_us_view.dart';
import 'package:satsang/ui/daily_satsang/binding/daily_satsang_binding.dart';
import 'package:satsang/ui/daily_satsang/view/daily_satsang_screen.dart';
import 'package:satsang/ui/divya_darshan/binding/divya_darshan_binding.dart';
import 'package:satsang/ui/divya_darshan/view/divya_darshan_screen.dart';
import 'package:satsang/ui/facebook/view/facebook_screen.dart';
import 'package:satsang/ui/home/view/home_screen.dart';
import 'package:satsang/ui/magazine/binding/magazine_binding.dart';
import 'package:satsang/ui/magazine/view/magazine_screen.dart';
import 'package:satsang/ui/news/binding/news_binding.dart';
import 'package:satsang/ui/news/view/news_screen.dart';
import 'package:satsang/ui/news_detail/binding/news_detail_binding.dart';
import 'package:satsang/ui/news_detail/view/news_detail_screen.dart';
import 'package:satsang/ui/nitya_niyam/view/nitya_niyam_screen.dart';
import 'package:satsang/ui/pdf/view/pdf_screen.dart';
import 'package:satsang/ui/photo/binding/photo_binding.dart';
import 'package:satsang/ui/photo/view/photo_screen.dart';
import 'package:satsang/ui/photo_view/binding/photo_view_binding.dart';
import 'package:satsang/ui/photo_view/view/photo_view_screen.dart';
import 'package:satsang/ui/registration/login/binding/login_binding.dart';
import 'package:satsang/ui/registration/login/view/login_screen.dart';
import 'package:satsang/ui/registration/register/binding/register_binding.dart';
import 'package:satsang/ui/registration/register/view/register_screen.dart';
import 'package:satsang/ui/sub_audio/binding/aub_audio_binding.dart';
import 'package:satsang/ui/sub_audio/view/sub_audio_screen.dart';
import 'package:satsang/ui/sub_image/binding/sub_image_binding.dart';
import 'package:satsang/ui/sub_image/view/sub_image_screen.dart';
import 'package:sizer/sizer.dart';
import '../ui/facebook/binding/facebook_binding.dart';
import '../ui/home/binding/home_binding.dart';
import '../ui/nitya_niyam/binding/nitya_niyam_binding.dart';
import '../ui/pdf/binding/pdf_binding.dart';
import '../ui/splash/binding/splash_binding.dart';
import '../ui/splash/view/splash_screen.dart';


class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: SplashScreen(),
          );
        },
      ),
      binding: SplashBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.subImage,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: SubImageScreen(),
          );
        },
      ),
      binding: SubImageBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.photoView,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: PhotoViewScreen(),
          );
        },
      ),
      binding: PhotoViewBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: HomeScreen(),
          );
        },
      ),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.audioScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: AudioViewScreen(),
          );
        },
      ),
      binding: AudioBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.contactScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: ContactScreen(),
          );
        },
      ),
      binding: ContactBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.dailySatsangScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: DailySatsangScreen(),
          );
        },
      ),
      binding: DailySatsangBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.subAudio,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: SubAudioScreen(),
          );
        },
      ),
      binding: SubAudioBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.audioList,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: AudioListScreen(),
          );
        },
      ),
      binding: AudioListBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.divyaDarshanScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: DivyaDarshanScreen(),
          );
        },
      ),
      binding: DivyaDarshanaBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.nityaNiyamScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: NityaNiyamScreen(),
          );
        },
      ),
      binding: NityaNiyamBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.eBooks,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: BookScreen(),
          );
        },
      ),
      binding: BookBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.pdfView,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: PdfScreen(),
          );
        },
      ),
      binding: PdfBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.registrationScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: RegisterScreen(),
          );
        },
      ),
      binding: RegisterBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: LoginScreen(),
          );
        },
      ),
      binding: LoginBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.facebookScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: FacebookScreen(),
          );
        },
      ),
      binding: FacebookBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.magazineScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: MagazineScreen(),
          );
        },
      ),
      binding: MagazineBinding(),
      transition: Transition.noTransition,
    ),
/*    GetPage(
      name: AppRoutes.newsDetailScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return  AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: SplashScreen(),
          );
        },
      ),
      binding: SplashBinding(),
      transition: Transition.noTransition,
    ),*/
    GetPage(
      name: AppRoutes.newsScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: NewsScreen(),
          );
        },
      ),
      binding: NewsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.photoScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: PhotosScreen(),
          );
        },
      ),
      binding: PhotosBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.newsDetailScreen,
      page: () => Sizer(
        builder: (context, orientation, deviceType) {
          return   const AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              // statusBarColor: isDarkMode ? CColor.black : CColor.white12,
            ),
            child: NewsDetail(),
          );
        },
      ),
      binding: NewsDetailBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
