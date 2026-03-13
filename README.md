# Build your redpesk OS image (x86_64) using mkosi

mkosi is a systemd tool that generates disk images [https://mkosi.systemd.io](https://mkosi.systemd.io).

For redpesk OS, the main goal is that it uses systemd-repart for making gpt
partitionning without any priviledge using libfdisk [https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html](https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html).

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
mkosi
```

The generated image will be available in the `output` directory.

## Other examples

You can find more details on the usage of `mkosi` in redpesk by going to [rp-mkosi](https://github.com/redpesk-infra/rp-mkosi) repository.
