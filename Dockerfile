FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

# Please contact with me if you have problems
LABEL maintainer="Zipeng Dai <daizipeng@bit.edu.cn>"
ENV DEBIAN_FRONTEND=noninteractive
# TODO：网络不好的话可以走代理
ENV http_proxy=http://127.0.0.1:8889
ENV https_proxy=http://127.0.0.1:8889

RUN apt-get update && apt-get install -y --no-install-recommends \
    git tmux vim gedit curl wget libgl1 ffmpeg libpng-dev libjpeg-dev

WORKDIR /workspace
RUN /opt/conda/bin/python3 -m pip install "pip<24.1"
RUN git clone https://github.com/motional/nuplan-devkit.git
WORKDIR /workspace/nuplan-devkit
RUN /opt/conda/bin/python3 -m pip install -e .
RUN /opt/conda/bin/python3 -m pip install -r requirements.txt

WORKDIR /workspace/
RUN git clone https://github.com/superboySB/metadrive.git
WORKDIR /workspace/metadrive
RUN /opt/conda/bin/python3 -m pip install -e .


WORKDIR /workspace/
RUN git clone https://github.com/superboySB/scenarionet.git
WORKDIR /workspace/scenarionet
RUN /opt/conda/bin/python3 -m pip install -e .
RUN /opt/conda/bin/python3 -m python -m scenarionet.list

COPY . /workspace/Diffusion-Planner
WORKDIR /workspace/Diffusion-Planner
RUN /opt/conda/bin/python3 -m pip install -e .
RUN /opt/conda/bin/python3 -m pip install -r requirements_torch.txt
RUN mkdir -p checkpoints && \
    wget -P ./checkpoints https://huggingface.co/ZhengYinan2001/Diffusion-Planner/resolve/main/args.json && \
    wget -P ./checkpoints https://huggingface.co/ZhengYinan2001/Diffusion-Planner/resolve/main/model.pth


# TODO：如果走了代理、但是想镜像本地化到其它机器，记得清空代理（或者容器内unset）
# ENV http_proxy=
# ENV https_proxy=
# ENV no_proxy=
WORKDIR /workspace
CMD ["/bin/bash"]
