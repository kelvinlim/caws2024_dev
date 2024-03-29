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
3. Vscode installs:
   1. remote package
   2. containers?
4. Select the Blue connection button in lower left corner.
5. select "Add dev Container Configuration Files"
5. Select "Add configuration to user data folder"
6. Select "From Dockerfile"