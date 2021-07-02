# hello-world

Porting hello world to every platform

Download: https://ci.appveyor.com/project/tumble1999/hello-world/build/artifacts

## Setting up repo

```
git clone https://github.com/tumble1999/hello-world.git`
cd hello-world
chmod +x ./scripts/gitflow.sh
./scripts/gitflow.sh
```

and then to start development on something

```
git flow feature start platform-name
```

## Rules for implementing a new platform

- Try to have all build intermediate files to be created in the `build` folder.
- Try to have the output be created in `build/run` folder.
- Any extra makefiles that are needed to be created in `targets/` folder.
- Must create a new make a new section in the main make file so that `make platform-name` can be ran.
- Create a section in the readme file for instructions on how to setup the sdk and stuff to build for the platform.

## Building

To simutainiusly build for all platforms at the same time, run the following command.

```
make all
```

### Cleaning

To clean run the following make command

```
make clean
```

### Linux

To build for linux run the following make command

```
make linux
```

### DOS

Install DosBox and from [DJGPP](http://www.mirrorservice.org/sites/ftp.delorie.com/pub/djgpp/current/) download:

```
v2/djdev205.zip
v2gnu/bnu2351b.zip
v2gnu/gcc930b.zip
v2gnu/gpp930b.zip
v2gnu/mak43b.zip
v2misc/csdpmi7b.zip
```

and extract these into /opt/DJGPP without it creating a subdirectory for each archive file.

To build for DOS run the following make command:

```
make dos
```

### Nintendo DS

Either buy a flash cart or download a DS emulator and install [DevKitPro (`dkp-pacman`)](https://devkitpro.org/wiki/Getting_Started). Then run the following command;

```
dkp-pacman -S nds-dev
```

To build for Nintendo DS please run the following command.

```
make nds
```

### Ninetndo Wii

Either homebew your or download a Wii Emulator and install [DevKitPro (`dkp-pacman`)](https://devkitpro.org/wiki/Getting_Started). Then run the following command;

```
dkp-pacman -S wii-dev
```

To build for Nintendo DS please run the following command.

```
make wii
```
