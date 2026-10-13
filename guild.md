# Mecha OS in QEMU

- first you need qemu raw image file you can build using this [mecha-make](./mecha-make) repo
- you can find full build instruction in readme

```sh
mkosi --profile=mqs -f build
```

after having .raw file move it into `image` folder. project `root directory`
```sh
#find -name mechanix-os-qemu-simu.raw

mv mecha-make/mechanix-os-qemu-simu.raw image/

```

# for using mecha app or services

i need to compile it myself and create an rpm package to install using `dnf`
inside `qemu` [mechanix-gui](./mechanix-gui/)

``` sh
cargo install cargo-generate-rpm
cargo build --release -p [mechanix-package-name]
cargo generate-rpm

```
# share file and folder between host and qemu

- this thing was automatic done if you build image using `mqs` mkosi profile

> command will run inside qemu `not in host machine`
```sh
sudo mount -t 9p -o trans=virtio,version=9p2000.L share /mnt
```
