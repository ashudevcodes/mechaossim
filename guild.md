# Mecha OS in QEMU Sim

QEMU raw image is what we need to simulate the Mecha ecosystem
This will help [mecha-make](https://github.com/ashudevcodes/mecha-make) build the image file

build instructions are in the README

```sh
mkosi --profile=mqs -f build
```

after building the `.raw` image, move it into the `image/` folder in the project root directory `this was require because qemu script need this`

```sh
# find -name mechanix-os-qemu-sim.raw

mv mecha-make/mechanix-os-qemu-sim.raw image/
```

# compile mecha apps or services

apps and services are compiled by ourselves for x86 cpus. then create an RPM package,
which is used by the `dnf` package manager to install inside qemu.
the source code of the mechanix first party applications and services is here [mechanix-gui](https://github.com/ashudevcodes/mechanix-gui)

```sh
cargo install cargo-generate-rpm
cargo build --release -p [mechanix-package-name]
cargo generate-rpm
```

# sharing files and folders between host and QEMU

this will setup automatically if you build image with the `mqs` mkosi profile

> run this command inside QEMU, **not** on the host machine
```sh
sudo mount -t 9p -o trans=virtio,version=9p2000.L share /mnt
```
