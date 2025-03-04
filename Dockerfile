FROM python:3.10-slim-bullseye

RUN rm -rf /usr/local/cuda/lib64/stubs

COPY requirements.txt /

RUN pip install -r requirements.txt \
  --extra-index-url https://download.pytorch.org/whl/cu117

RUN useradd -m huggingface

USER huggingface

WORKDIR /home/huggingface

ENV USE_TORCH=1

RUN mkdir -p /home/huggingface/.cache

COPY docker-entrypoint.py /usr/local/bin
#COPY token.txt /home/huggingface

ENTRYPOINT [ "docker-entrypoint.py" ]
