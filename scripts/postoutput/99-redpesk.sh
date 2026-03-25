#!/bin/bash

# DO NOT DELETE - these outputs are necessary for a build in redpesk Factory
# If the compression of the image isn't enabled, it will increase your build time

[ "$REDPESK_BYPASS_POSTOUTPUT" ] && exit 0

# redpesk postoutput: bmap/compress/sha256

output=$OUTPUTDIR/$(jq -r '.output // "image"' $MKOSI_CONFIG).raw

{ # bmaptool
	! which bmaptool &> /dev/null && echo "no bmaptool found, no bmap file generation" && exit 0
	{ (set -x; bmaptool create $output > ${output}.bmap); echo "bmap done"; } &
}

{ #tar
	! which tar &> /dev/null && echo "no tar, no archive generation" && exit 0
	{ cd $OUTPUTDIR; (set -x; tar --sparse -cJf ${output}.tar.xz $(basename ${output})); echo "compression done"; } &
}

{ #sha256
	! which sha256sum &> /dev/null && echo "no sha256sum, no checksum file generation" && exit 0
	{ cd $OUTPUTDIR; (set -x; sha256sum $(basename ${output}) > ${output}.sha256); echo "sha256 done"; } &
}

wait

# Clean U-Boot tmp
rm -rf $UBOOT_DIR
