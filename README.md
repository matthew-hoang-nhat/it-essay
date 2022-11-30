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

  ![](resources/images/dependencies.jpg) 

## Helper
- [logger](https://pub.dev/packages/logger): Small, easy to use and extensible logger which prints beautiful logs.

- [url_launcher](https://pub.dev/packages/url_launcher): A Flutter plugin for launching a URL in the mobile platform. Supports iOS, Android, web, Windows, macOS, and Linux.

- [go_router](https://pub.dev/packages/go_router): Uses the Router API to provide a convenient, url-based API for navigating between different screens

- [get_it](https://pub.dev/packages/get_it): This is a simple Service Locator

- [intl](https://pub.dev/packages/intl): This package provides internationalization and localization facilities, including message translation, plurals and genders, date/number formatting and parsing, and bidirectional text.

- [Hive](https://pub.dev/packages/hive): Hive is a lightweight and blazing fast key-value database written in pure Dart

- [package_info_plus](https://pub.dev/packages/package_info_plus): This Flutter plugin provides an API for querying information about an application package.

- [device_info_plus](https://pub.dev/packages/device_info_plus): Get current device information from within the Flutter application.

- [permission_handler](https://pub.dev/packages/permission_handler): Permission plugin for Flutter. This plugin provides a cross-platform (iOS, Android) API to request and check permissions.

## HTTP, API
- [dio](https://pub.dev/packages/dio): A powerful Http client for Dart, which supports Interceptors, Global configuration, FormData, Request Cancellation, File downloading, Timeout etc
- [retrofit](https://pub.dev/packages/retrofit): Retrofit.dart is a type conversion dio client generator using source_gen and inspired by Chopper and Retrofit.




## Flutter Fire
  > The official Firebase plugins for Flutter. sign_in, analytics, crashlytics, storage, firestore
- [Flutter Fire](https://firebase.flutter.dev/)


## State Management
  > State Management is still the hottest topic in Flutter Community. There are tons of choices available and it’s super intimidating for a beginner to choose one. Also, all of them have their pros and cons. So, what’s the best approach

![](resources/images/state.png) 

**A recommended approach**
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): Widgets that make it easy to integrate blocs and cubits into Flutter. [Learn more](https://bloclibrary.dev/#/) 


**Other favorite package**
- [provider](https://pub.dev/packages/provider): A wrapper around InheritedWidget to make them easier to use and more reusable.

- [rxdart](https://pub.dev/packages/rxdart): RxDart adds additional capabilities to Dart Streams and StreamControllers. Using as bloc pattens

- [RiverPod](https://pub.dev/packages/riverpod): This project can be considered as a rewrite of provider to make improvements that would be otherwise impossible.

- [Get](https://pub.dev/packages/get): A simplified reactive state management solution.
- [stacked](https://pub.dev/packages/stacked): This architecture was initially a version of MVVM.

- [get](https://pub.dev/packages/get): GetX Ecosystem (State, Router, Dependency management, Theme, Utils)

- [More about state management](https://flutter.dev/docs/development/data-and-backend/state-mgmt/options)

## Widget
- [loading_animation_widget](https://pub.dev/packages/loading_animation_widget): Loading animation

## Image
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager)

# Code structure
Here is the core folder structure which flutter provides.
```
flutter-app/
|- android
|- ios
|- lib
|- assets
|- modules
|- test
```
Here is the folder structure we have been using in this project

```
lib/
|- src/
  |- config/
    |- constant/
    |- locates/
    |- routes/
  |- di/
  |- features/
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
