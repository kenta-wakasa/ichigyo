# ichigyo

メモを最速で書ける。一行メモアプリ。

## アイコンの生成

`flutter pub run flutter_launcher_icons:main`

## iOS のビルドとアップロード

`flutter build ipa --export-options-plist=ExportOptions.plist`

## Android のビルドとアップロード

`flutter build appbundle && cd android && ./gradlew publishReleaseBundle --artifact-dir ../build/app/outputs/bundle/release/app-release.aab && cd ../`
