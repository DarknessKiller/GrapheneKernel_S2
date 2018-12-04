    #!/bin/bash
    clear
    echo OverdoseKernel Compile Tool
    echo By MrDarkness
    echo Please Sit Back And Chill...
    export KERNELDIR=`readlink -f .`
    export CROSS_COMPILE=/home/$USER/aarch64-linux-android-4.9/bin/aarch64-linux-android-   
    export ARCH=arm64
    make overdose_s2_defconfig
    make -j8 | tee $KERNELDIR/built/kernel_output.txt
    rm -rf $KERNELDIR/built
    mkdir -p $KERNELDIR/built/
    mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/zImage
    find -name '*.ko' -exec mv -v {} $KERNELDIR/built/ \;
    if [ -f $KERNELDIR/built/*.ko ];
    then
    mkdir -p $KERNELDIR/built/system/lib/modules/
    mv $KERNELDIR/built/*.ko $KERNELDIR/built/system/lib/modules/
    fi

    echo ""
    echo "Compile Done"

