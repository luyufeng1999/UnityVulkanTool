set -e

if [ -n "$ANDROID_NDK" ]; then
    export NDK=${ANDROID_NDK}
elif [ -n "$ANDROID_NDK_HOME" ]; then
    export NDK=${ANDROID_NDK_HOME}
else
    echo "Please set ANDROID_NDK environment to the root of NDK."
    exit 1
fi

build()
{
    ABI=$1
    PLATFORM=$2
    PWD=`pwd`
    BUILD_PATH=build.$ABI

    if [ "$ABI" = "arm64-v8a" ]; then
        VULKAN_PATH="aarch64-linux-android"
    elif [ "$ABI" = "armeabi-v7a" ]; then
        VULKAN_PATH="arm-linux-androideabi"
    elif [ "$ABI" = "x86" ]; then
        VULKAN_PATH="i686-linux-android"
    elif [ "$ABI" = "x86_64" ]; then
        VULKAN_PATH="x86_64-linux-android"
    else
        echo "Unsupported ABI: $ABI"
        exit 1
    fi

    cmake -B$BUILD_PATH \
        -G "Ninja" \
        -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$ABI \
        -DANDROID_ARM_MODE=thumb \
        -DANDROID_PLATFORM=$PLATFORM \
        -DANDROID_STL=c++_static \
        -DCMAKE_BUILD_TYPE=Release \
        -DVulkan_LIBRARY=$NDK/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/lib/$VULKAN_PATH/$PLATFORM/libvulkan.so \
        -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=$PWD/Plugins/Android/$ABI \
        -DCMAKE_MAKE_PROGRAM=C:/Users/admin/AppData/Local/Android/Sdk/cmake/3.22.1/bin/ninja.exe
    
    cmake --build $BUILD_PATH --config Release
}

build armeabi-v7a 24
build arm64-v8a 24
build x86 24
build x86_64 24

