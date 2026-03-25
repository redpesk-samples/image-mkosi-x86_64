#!/bin/bash

# DO NOT DELETE - these outputs are necessary for a build in redpesk Factory
# This creates a file which is used for SBOM generation

rpm -qa --root $BUILDROOT |sort > $OUTPUTDIR/manifest.log
