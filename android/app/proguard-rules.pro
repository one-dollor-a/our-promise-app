# 에러프론 어노테이션 관련 규칙
-dontwarn com.google.errorprone.annotations.**
-keep class com.google.errorprone.annotations.** { *; }

# javax 어노테이션 관련 규칙
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Flutter 관련 기본 규칙
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Tink 암호화 라이브러리 관련 규칙
-keep class com.google.crypto.tink.** { *; }

# Play Core 라이브러리 관련 규칙
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Google API Client 관련 규칙
-keep class com.google.api.client.** { *; }
-dontwarn com.google.api.client.**

# Joda Time 관련 규칙
-keep class org.joda.time.** { *; }
-dontwarn org.joda.time.**
