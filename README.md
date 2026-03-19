# Build your redpesk OS image (x86_64) using mkosi

redpesk factory allows to create redpesk OS image with your custom applications and settings based on mkosi tool.

The full documentation to create an image is available online at [docs.redpesk.bzh](https://docs.redpesk.bzh/docs/en/master/redpesk-factory/images-management/01-create-an-image.html) section `Images management`.

mkosi is a systemd tool that generates disk images [https://mkosi.systemd.io](https://mkosi.systemd.io).

For redpesk OS, the main goal is that it uses systemd-repart for making gpt
partitioning without any privilege using libfdisk [https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html](https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html).

Have a look on the man page for more information:

```
mkosi --help
```

or directly online on mkosi GitHub
[https://github.com/systemd/mkosi/blob/main/mkosi/resources/man/mkosi.1.md](https://github.com/systemd/mkosi/blob/main/mkosi/resources/man/mkosi.1.md)

## Simple example

In this repository, you will find a **flat configuration** for generating a redpesk OS image for Intel (x86) 64 bits platforms.

The idea is to make it easier to understand and to modify than in the root configuration of the repository.
There is only one configuration file and no profiles.

To build a redpeskOS image for x86_64 targets, run:

```bash
mkosi -I mkosi-generic.conf --debug --force --debug-workspace
```

The generated image will be available in the `output` directory.

## Boot the built image in QEMU

Please follow [some prerequisites](https://docs.redpesk.bzh/docs/en/master/download/boards/docs/boards/qemu.html#launch-an-x86_64-image) to have what is needed for setting QEMU.

Then you can boot the image with these commands:

```bash
# For Fedora
OVMF="/usr/share/OVMF/OVMF_CODE.fd"
# Uncomment/change for Ubuntu
#OVMF="/usr/share/qemu/OVMF.fd"
# Uncomment/change for openSUSE
#OVMF="/usr/share/qemu/ovmf-x86_64-4m.bin"

PORT_SSH=3333

qemu-system-x86_64 \
    -hda "output/image.raw" \
    -enable-kvm -m 2048 \
    -cpu Skylake-Client-v4 \
    -smp 4 \
    -vga virtio \
    -device virtio-rng-pci \
    -serial mon:stdio \
    -net nic \
    -net user,hostfwd=tcp::$PORT_SSH-:22 \
    -bios $OVMF
```

And after you will have your redpesk OS x86 image ready:

```bash
BdsDxe: loading Boot0002 "UEFI QEMU HARDDISK QM00001 " from PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
BdsDxe: starting Boot0002 "UEFI QEMU HARDDISK QM00001 " from PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
Booting `redpesk-6.12.0-54.baseos.rpcorn.x86_64'

[...]

redpesk Linux corn LTS
Kernel 6.12.0-54.baseos.rpcorn.x86_64 on an x86_64
localhost login:
```

## Other examples

You can find more details on the usage of `mkosi` in redpesk by going to [rp-mkosi](https://github.com/redpesk-infra/rp-mkosi) repository.
