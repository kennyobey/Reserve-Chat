#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keep class io.agora.**{*;}
 

-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }  
-keep class com.firebase.** { *; }



-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}