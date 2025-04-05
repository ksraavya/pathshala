# Preserve all AR Sceneform-related classes
-keep class com.google.ar.** { *; }
-dontwarn com.google.ar.**

-keep class com.google.ar.sceneform.** { *; }
-dontwarn com.google.ar.sceneform.**

# Prevent desugaring issues with ThrowableExtension
-keep class com.google.devtools.build.android.desugar.runtime.** { *; }

# Needed to keep animation-related classes
-keep class com.google.ar.sceneform.animation.** { *; }

# Keep model/asset loaders
-keep class com.google.ar.sceneform.assets.** { *; }

# Keep ARCore / Sceneform classes
-keep class com.google.ar.** { *; }
-keep class com.google.devtools.build.android.desugar.runtime.** { *; }
-dontwarn com.google.ar.**
-dontwarn com.google.devtools.build.android.desugar.runtime.**
