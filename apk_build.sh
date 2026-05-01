#Hello World Build
javac -classpath $ANDROID_SDK_ROOT/platforms/android-34/android.jar -d build/obj app/src/pkg/com/dspdriver/MainActivity.java
cd build/obj
rm classes.dex classes.jar
jar cf classes.jar .
d8 classes.jar --lib $ANDROID_SDK_ROOT/platforms/android-34/android.jar --output .
cd ../..
aapt package -f -M app/src/AndroidManifest.xml -I $ANDROID_SDK_ROOT/platforms/android-34/android.jar -F build/apk/unaligned.apk app/src/pkg
cd build/obj
zip ../apk/unaligned.apk classes.dex
cd ../..
rm build/apk/aligned.apk
zipalign -v 4 build/apk/unaligned.apk build/apk/aligned.apk
apksigner sign --ks build/debug.keystore --ks-pass pass:android --key-pass pass:android --out build/apk/dspdriver.apk build/apk/aligned.apk
