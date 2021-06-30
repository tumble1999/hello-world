# hello-world
Porting hello world to every platform

## Seting up repo
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


## Building

## Cleaning
To clean run the following make command
```
make clean
```
## Linux
To build for linux run the following make command
```
make linux
```

# DOS
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

To build for dis run the following make command:
```
make dos
```