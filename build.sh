#!/bin/bash

export KERNELNAME=DesertEagle

export LOCALVERSION=reborn

export KBUILD_BUILD_USER=megazord

export KBUILD_BUILD_HOST=id

export TOOLCHAIN=clang

export DEVICES=whyred,tulip,a26x

export CI_ID=-1001277300644

export GROUP_ID=-1001277300644

source helper

gen_toolchain

send_msg "⏳ Start building ${KERNELNAME} ${LOCALVERSION} EAS | DEVICES: whyred - tulip"

send_pesan "⏳ Start building ${KERNELNAME} ${LOCALVERSION} EAS | DEVICES: whyred - tulip"

START=$(date +"%s")

for i in ${DEVICES//,/ }
do
	build ${i} -oldcam

	build ${i} -newcam
done

send_msg "⏳ Start building Overclock version | DEVICES: whyred - tulip"

send_pesan "⏳ Start building Overclock version | DEVICES: whyred - tulip"

git apply oc.patch

for i in ${DEVICES//,/ }
do
	if [ $i == "whyred" ] || [ $i == "tulip" ]
	then
		build ${i} -oldcam -overclock

		build ${i} -newcam -overclock
	fi
done

END=$(date +"%s")

DIFF=$(( END - START ))

send_msg "✅ Build completed in $((DIFF / 60))m $((DIFF % 60))s, get nightly builds in @deserteagle_channel | Last commit: $(git log --pretty=format:'%s' -5)"

send_pesan "✅ Build completed in $((DIFF / 60))m $((DIFF % 60))s | Last commit: $(git log --pretty=format:'%s' -5)"
