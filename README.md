# caws2024_dev

Has python3.10, openjdk-18-jdk, jpype
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


