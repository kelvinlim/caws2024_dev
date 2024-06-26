# Use Ubuntu 22.04 LTS as the base image
FROM ubuntu:22.04

# Install Python 3.11 and OpenJDK 11
RUN apt-get update 
RUN apt-get upgrade -y
RUN apt-get install -y python3.11 openjdk-18-jdk

RUN apt-get install -y vim 
RUN apt-get install -y python3-pip wget git 

# default architecture is amd64
ARG ARCH=amd64

# Install dos2unix only if not on arm64
# dos2unix # error on m1
RUN if [ "$ARCH" != "arm64" ]; then \
    apt-get install -y dos2unix; \
  fi

#RUN apt-get curl

# install vscode server
# see https://stackoverflow.com/questions/63354237/how-to-install-vs-code-extensions-in-a-dockerfile
#RUN curl -fsSL https://code-server.dev/install.sh | sh

# To have systemd start code-server now and restart on boot:
# RUN systemctl enable --now code-server@$USER

# Install VS Code extensions
#RUN code-server --install-extension redhat.vscode-yaml --install-extension ms-python.python

# RUN EXT_LIST="ms-python.python" && \
#     for EXT in $EXT_LIST; do code-server --install-extension $EXT; done

# install jpype
RUN pip install JPype1

# install R  
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt install -y --no-install-recommends r-base 
# RUN apt install -y --no-install-recommends r-base-dev

# get key
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc |  gpg --dearmor -o /usr/share/keyrings/r-project.gpg
# add repository
RUN echo "deb [signed-by=/usr/share/keyrings/r-project.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" |  tee -a /etc/apt/sources.list.d/r-project.list
# update
RUN apt update
ENV DEBIAN_FRONTEND=noninteractive
#RUN echo "2" | apt install -y r-base-core
RUN apt install -y --no-install-recommends r-base-core
#RUN apt install -y --no-install-recommends r-base


# install R on arm
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
# RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/'
# RUN apt install r-base r-base-dev -y


# Set JAVA_HOME environment variable based on architecture
# If architecture is amd64, set ARCH to amd64
ARG ARCH=${ARCH:-amd64}

# If architecture is arm64, set ARCH to arm64
ARG ARCH=${ARCH:-arm64}

ENV JAVA_HOME=/usr/lib/jvm/java-18-openjdk-${ARCH}


# Install any additional tools or dependencies you need
# ...

# Set the working directory
WORKDIR /caws2024/bin

# get the tetrad version
RUN wget https://s01.oss.sonatype.org/content/repositories/releases/io/github/cmu-phil/tetrad-gui/7.6.4/tetrad-gui-7.6.4-launch.jar

# get causal-cmd
RUN wget https://s01.oss.sonatype.org/content/repositories/releases/io/github/cmu-phil/causal-cmd/1.12.0/causal-cmd-1.12.0-jar-with-dependencies.jar

# get the pytetrad 
WORKDIR /caws2024
RUN git clone https://github.com/cmu-phil/py-tetrad.git

# copy the day directories to working directory
ADD Day1 /caws2024/Day1
ADD Day2 /caws2024/Day2
ADD Day3 /caws2024/Day3
ADD Day4 /caws2024/Day4
ADD Day5 /caws2024/Day5


# Copy your code into the container
#RUN mkdir /caws2024/bin
COPY run_tetrad.sh /caws2024/bin
# add this to path
ENV PATH=/caws2024/bin:$PATH

# set home directory
ENV HOME=/caws2024

# change the home for root to be /caws2024
# this insures that tetrad opens the /caws2024 directory
RUN sed -i 's/\/root/\/caws2024/g' /etc/passwd

# add a directory for MyStuff so that a local directory can be mounted here
RUN mkdir /caws2024/MyStuff

RUN pip install pandas
