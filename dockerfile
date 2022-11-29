FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

RUN apt-get update
RUN apt-get install -y \
    apt-utils \
    vim \
    git 
RUN apt-get install wget -y
RUN apt-get install gcc g++ -y
RUN apt-get install libsm6 libxext6 -y
RUN apt-get install -y libgl1-mesa-glx
RUN apt-get install libglib2.0-0 -y -qq
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && echo PATH="/root/miniconda3/bin":$PATH >> .bashrc \
    && exec bash \
    && conda --version

RUN conda --version
RUN pip install pycocotools
RUN pip3 install opencv-python
RUN pip install opencv-contrib-python -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install git+https://github.com/facebookresearch/fvcore
RUN pip install cython
RUN pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI
RUN python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
RUN git clone https://github.com/WongKinYiu/yolov7.git
RUN pip install -r yolov7/requirements.txt
RUN pip install onnx>=1.9.0
RUN pip install onnx-simplifier>=0.3.6
RUN pip install nvidia-pyindex
RUN pip install onnx-graphsurgeon
#segmentation_models_torch 依赖库 ---start---
RUN apt-get -qq install -y libfluidsynth1
RUN apt-get -qq install -y libarchive-dev
RUN apt-get -qq install -y graphviz
RUN apt-get -qq install -y libgeos++-dev libgeos-3.8.0 libgeos-c1v5 libgeos-dev libgeos-doc
#segmentation_models_torch 依赖库 ---end---
#segmentation_models_torch 依赖库 ---start---
RUN pip install matplotlib-venn
RUN pip install -U libarchive
RUN pip install pydot
RUN pip install cartopy
RUN pip install -U segmentation-models-pytorch albumentations --user
#segmentation_models_torch 依赖库 ---end---

WORKDIR /workspace
