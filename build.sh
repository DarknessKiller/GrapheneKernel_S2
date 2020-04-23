	#!/bin/bash
	clear
	echo Overdose Kernel Compile Tool
	echo By MrDarkness
	echo Please Sit Back And Chill...
	export MAIN=`readlink -f ../`
	export KERNELDIR=`readlink -f .`
	rm $KERNELDIR/built/Image.gz-dtb
	rm $KERNELDIR/built/kernel_output.txt
	export CROSS_COMPILE=$MAIN/aarch64-linux-android-4.9/bin/aarch64-linux-android-   
	export ARCH=arm64
	make overdose_s2_defconfig
	make -j$(nproc --all) | tee $KERNELDIR/built/kernel_output.txt
	mv $KERNELDIR/arch/arm64/boot/Image.gz-dtb $KERNELDIR/built/zImage
	echo ""
	echo "Compile Done"
	echo ""
	cd $KERNELDIR/built
	zip -r Overdose-R3-Release-S2-`date +%Y%m%d_%H%M`.zip * -x "kernel_output.txt" "*.zip"
	cd $KERNELDIR/
	echo "Zip Done"
