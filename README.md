# ichigyo

メモを最速でとれる！　一行メモ

# 開発の動機

インターネットの通信を介さないシンプルな構成で実用的なアプリをつくりたい。そのアプリを通して入門者に向けた解説本と解説動画を作成し、より多くの人が Flutter によるアプリ開発の魅力に触れられることを目指す。

# iOS TestFlight

下記のリンクから誰でも参加可能です。  
https://testflight.apple.com/join/mClKpp4S

# アイコンの生成

`flutter pub run flutter_launcher_icons:main`

# iOS のビルドとアップロード

`flutter build ipa --export-options-plist=ExportOptions.plist`

# Android のビルドとアップロード

`flutter build appbundle && cd android && ./gradlew publishReleaseBundle --artifact-dir ../build/app/outputs/bundle/release/app-release.aab && cd ../`
