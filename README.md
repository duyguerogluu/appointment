## Environment

```
Flutter (Channel stable, 3.7.8, on macOS 12.5.1 21G83 darwin-x64, locale en-TR)
```

## Prepare Project

1 - flutter pub get

2 - flutter packages pub run build_runner build --delete-conflicting-outputs
or
flutter packages pub run build_runner watch

## Hide Generated Files (optional)

In-order to hide generated files, navigate to `Android Studio` -> `Preferences` -> `Editor` -> `File Types` and paste the below lines under `ignore files and folders` section:

_.inject.summary;_.inject.dart;\*.g.dart;

In Visual Studio Code, navigate to `Preferences` -> `Settings` and search for `Files:Exclude`. Add the following patterns:

**/\*.inject.summary
**/_.inject.dart
\*\*/_.g.dart

## Run Project

flutter run
