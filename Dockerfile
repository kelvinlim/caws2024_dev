# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Install Python 3.11 and OpenJDK 11
RUN apt-get update && \
    apt-get install -y python3.11 openjdk-18-jdk

RUN apt-get install -y vim python3-pip wget git

# install jpype
RUN pip install JPype1

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-18-openjdk-amd64

# Install any additional tools or dependencies you need
# ...

# Set the working directory
WORKDIR /app

# get the tetrad version
RUN wget https://s01.oss.sonatype.org/content/repositories/releases/io/github/cmu-phil/tetrad-gui/7.6.3/tetrad-gui-7.6.3-launch.jar

# get causal-cmd
RUN wget https://s01.oss.sonatype.org/content/repositories/releases/io/github/cmu-phil/causal-cmd/1.12.0/causal-cmd-1.12.0-jar-with-dependencies.jar

# get the pytetrad 
RUN git clone https://github.com/cmu-phil/py-tetrad.git

# Copy your code into the container
COPY . /app

# Specify the default command to run (e.g., start your Python app)
#CMD ["python3.11", "your_python_script.py"]

