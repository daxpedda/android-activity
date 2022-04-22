#!/bin/sh


while read ARCH && read TARGET ; do

    # --module-raw-line 'use '
    bindgen wrapper.h -o src/ffi_$ARCH.rs \
        --blocklist-item 'JNI\w+' \
        --blocklist-item 'C?_?JNIEnv' \
        --blocklist-item '_?JavaVM' \
        --blocklist-item '_?j\w+' \
        --blocklist-item 'ALooper\w*' \
        --blocklist-function 'ALooper\w*' \
        --blocklist-item 'AAsset\w*' \
        --blocklist-item 'AAssetManager\w*' \
        --blocklist-function 'AAssetManager\w*' \
        --blocklist-item 'ANativeWindow\w*' \
        --blocklist-function 'ANativeWindow\w*' \
        --blocklist-item 'AConfiguration\w*' \
        --blocklist-function 'AConfiguration\w*' \
        --blocklist-function 'android_main' \
        --blocklist-item 'GameActivity_onCreate' \
        --blocklist-function 'GameActivity_onCreate_C' \
        --newtype-enum '\w+_(result|status)_t' \
        -- \
        -Icsrc \
        --sysroot="${ANDROID_NDK_ROOT}"/toolchains/llvm/prebuilt/linux-x86_64/sysroot/ --target=$TARGET
done << EOF
arm
arm-linux-androideabi
aarch64
aarch64-linux-android
i686
i686-linux-android
x86_64
x86_64-linux-android
EOF
