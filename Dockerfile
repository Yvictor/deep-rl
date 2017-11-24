FROM ubuntu:16.04

MAINTAINER yvictor

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        git \
        make \
        cmake \
        zlib1g-dev \
        libjpeg-dev \
        xvfb \
        libav-tools \
        xorg-dev \
        python-opengl \
        libboost-all-dev \
        libsdl2-dev \
        swig \
        wget \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

      
ENV PYENV_ROOT /root/.pyenv
ENV PATH /root/.pyenv/shims:/root/.pyenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
RUN pyenv install anaconda3-4.3.0
RUN pyenv global anaconda3-4.3.0

# fixed liggcc
RUN conda install libgcc -y

# Install package
RUN pip  install --no-cache-dir matplotlib==2.0.2 numpy==1.13.1 Pillow==3.4.2 seaborn==0.7.1 tensorflow==1.3.0 tensorflow-tensorboard==0.1.5 keras==2.0.8 scipy==0.19.0 gym[atari]



# Install TensorFlow CPU version.
#RUN pip --no-cache-dir install \
#    https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.2.1-cp36-cp36m-linux_x86_64.whl

# Tensorflow GPU version
# http://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.0.1-cp36-cp36m-linux_x86_64.whl


# RUN ln -s /usr/bin/python3 /usr/bin/python#


# For CUDA profiling, TensorFlow requires CUPTI.
# ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

ADD codes /home/codes
ADD slides /home/slides

WORKDIR "/home"

CMD jupyter notebook --ip 0.0.0.0 --allow-root
