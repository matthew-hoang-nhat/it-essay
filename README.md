# Book Ecommerce

<p align="center">
  <a href="https://flutter.io/">
    <img src="https://storage.googleapis.com/cms-storage-bucket/ec64036b4eacc9f3fd73.svg" alt="Logo" width=320 height=72>
  </a>

  <!-- <h3 align="center">Book Ecommerce</h3> -->

  <p align="center">
    Fork this project then start you project with a lot of stuck prepare
    <br>
    Base project made with much  :heart: . Contains CRUD, patterns, and much more!
    <br>
    <br>
    <a href="https://github.com/matthew-hoang-nhat/it-essay/issues/new">Report bug</a>
    ·
    <a href="https://github.com/matthew-hoang-nhat/it-essay/issues/new">Request feature</a>
  </p>
</p>

## Table of contents

- [How to Use](#how-to-use)
- [Feature](#feature)
- [Code Conventions](#code-conventions)
- [Dependencies](#dependencies)
- [Code structure](#code-structure)

## How to Use 

1. Download or clone this repo by using the link below:
  ```
  https://github.com/matthew-hoang-nhat/it-essay.git
  ```
2. Go to project root and execute the following command in console to get the required dependencies: 

  ```
  flutter pub get 
  ```
3. Now run the generator
  ```
  flutter packages pub run build_runner build
  ```
  
# Code Conventions
- [analysis_options.yaml](analysis_options.yaml)
- [About code analytics flutter](https://medium.com/flutter-community/effective-code-in-your-flutter-app-from-the-beginning-e597444e1273)

  In Flutter, Modularization will be done at a file level. While building widgets, we have to make sure they stay independent and re-usable as maximum. Ideally, widgets should be easily extractable into an independent project.


# Dependencies

## Helper
- [Logger](https://pub.dev/packages/logger): Small, easy to use and extensible logger which prints beautiful logs.
- [Url Launcher](https://pub.dev/packages/url_launcher): A Flutter plugin for launching a URL in the mobile platform. Supports iOS, Android, web, Windows, macOS, and Linux.
- [intl](https://pub.dev/packages/intl): This package provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

## Management router
- [Go router](https://pub.dev/packages/go_router): Uses the Router API to provide a convenient, url-based API for navigating between different screens. Don't generate code.

## Dependency injection
- [Get it](https://pub.dev/packages/get_it): This is a simple Service Locator

## State Management
  > State Management is still the hottest topic in Flutter Community. There are tons of choices available and it’s super intimidating for a beginner to choose one. Also, all of them have their pros and cons. So, what’s the best approach

![](resources/images/state.png) 
- [Flutter bloc](https://pub.dev/packages/flutter_bloc): Widgets that make it easy to integrate blocs and cubits into Flutter. [Learn more](https://bloclibrary.dev/#/) 

## Local Database
- [Hive](https://pub.dev/packages/hive): Hive is a lightweight and blazing fast key-value database written in pure Dart

## Notification
- [Flutter toast](https://pub.dev/packages/fluttertoast)
- [Flutter smart dialog](https://pub.dev/packages/flutter_smart_dialog)
- [Flutter local notification](https://pub.dev/packages/flutter_local_notifications)

## HTTP, API, Socket
- [Dio](https://pub.dev/packages/dio): A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc
- [Retrofit](https://pub.dev/packages/retrofit): Retrofit.dart is a type conversion dio client generator using source_gen and inspired by Chopper and Retrofit.
- [Socket](https://pub.dev/packages/socket_io_client)

## Firebase
- [Flutter Fire](https://firebase.flutter.dev/)
- crashlytics
- firebase_auth
- firebase_core
- sign_in

## Widget
- [Loading animation widget](https://pub.dev/packages/loading_animation_widget): Loading animation
- [Flutter slidable](https://pub.dev/packages/flutter_slidable): implementation of slidable list item with directional slide actions that can be dismissed.
- [Flutter rating bar](https://pub.dev/packages/flutter_rating_bar)

## Image
- [Cached network image](https://pub.dev/packages/cached_network_image): show images from the internet and keep them in the cache directory.
- [Photo view](https://pub.dev/packages/photo_view): enables images to become able to zoom and pan with user gestures such as pinch, rotate and drag.
- [Image picker](https://pub.dev/packages/image_picker): A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.



# Code structure
Here is the core folder structure which flutter provides.
```
flutter-app/
|- android/
|- ios/
|- lib/
|- assets/
|- modules/
|- test/
```
Here is the folder structure we have been using in this project


```
lib/
|- src/
  |- config/
    |- constant/
    |- locates/
    |- routes/
  |- features/
    |- address/
    |- app/
    |- category/
    |- login_register/
    |- main/
    |- order/
    |- product/
    |- profile/
    |- search/
    |- seller/
    |- shopping_cart/
    |- walk_throught/

  |- local/
    |- dao/
  |- utils/
    |- helps/
    |- remote/
      |- model/
      |- services/
    |- repository/
    |- app_shared.dart
  |- widgets/

|- locator.dart
|- app.dart
|- main.dart
```
