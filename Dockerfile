FROM debian:stretch

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates python3 

RUN mkdir /opt/src

RUN wget --quiet https://raw.githubusercontent.com/keras-team/keras/master/examples/mnist_cnn.py -O /opt/src/mnist_cnn.py

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean


RUN conda config --append channels conda-forge && conda install -y \
    jupyter \
    pip \
    python=3.8 \
    keras

RUN jupyter notebook --generate-config

COPY source_codes/* /opt/src/

EXPOSE 8888

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD ["/opt/conda/bin/jupyter", "notebook", "--port=8888", "--allow-root", "--notebook-dir='/opt/src'", "--NotebookApp.token=kerasexample", "--no-browser", "--ip=0.0.0.0"]
