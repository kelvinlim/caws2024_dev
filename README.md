# caws2024_dev

Has python3.11, openjdk-18-jdk, jpype
causal-cmd and tetrad

To build the container

```
docker build -t python-java-dev .
`
```

To run the container

```
docker run -it --rm python-java-dev 

# this will place you int the shell
# to run causal-cmd

java -jar causal-cmd-1.12.0-jar-with-dependencies.jar --help

```

## Using container with vscode

You can use the container to write and run code using vscode.

## tetrad gui

This works fine under windows.  In vscode terminal,

```
cd /app
java -jar  tetrad-gui-7.6.3-launch.jar 
```

On Mac, tetrad windows comes up but after moving mouse the window turns black making it hard to visualize anything.

This is a known issue for many years for the M1 Mac.
https://github.com/XQuartz/XQuartz/issues/31

Recommend setting some options for display

This works for M1 Mac

```
java -Dsun.java2d.xrender=false -Dsun.java2d.pmoffscreen=false -jar tetrad-gui-7.6.3-launch.jar
```

## git crlf conversion problem

To turn this off:
git config --global core.safecrlf false

## configuring container with docker on mac and windows

1. Install Docker Desktop https://www.docker.com/products/docker-desktop/
2. Start up docker
3. Vscode extensions:
   1. remote development for containers
   2. python
   3. java
   4. docker
   5. How to have a configuration file for this?
      1. Can be placed into  devcontainers.json file
4. Select the Blue connection button in lower left corner.
5. select "Add dev Container Configuration Files"
6. Select "Add configuration to user data folder"
7. Select "From Dockerfile"
8. Don't select additional options, click on blue OK box.

To rebuild a container
Use the following command (View/Command Palette)
DevContainers:Rebuild Without Cache and Reopen in Container

## Installing R

I
Current (20240330) ubuntu 22 Rstudio https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb

```
wget https://download1.rstudio.org/electron/jammy/amd64/rstudio-2023.12.1-402-amd64.deb
apt install -f rstudio-2023.12.1-402-amd64.deb
```

## building container for upload to hub.docker.com

```
for arm
docker build -f Dockerfile_m1 -t kelvinolim/caws2024_m1:latest --build-arg ARCH=arm64 .

for amd64
docker build -f Dockerfile_m1 -t kelvinolim/caws2024:latest .

docker login

docker push kelvinolim/caws2024:latest


```
