FROM ncr.nioint.com/docker.io/fedirz/faster-whisper-server:0.3.2-cuda
ENV HF_ENDPOINT=https://hf-mirror.com
COPY ./faster_whisper_server ./faster_whisper_server
COPY ./hfd.sh ./hfd.sh
RUN apt update && \
    apt-get install aria2 git git-lfs vim curl -y && \
    chmod a+x ./hfd.sh && \
    ./hfd.sh Systran/faster-whisper-large-v3 --tool aria2c -x 16 --local-dir /workspace/model/faster-whisper-large-v3
ENV WHISPER__MODEL=/workspace/model/faster-whisper-large-v3
ENV WHISPER__INFERENCE_DEVICE=cuda
ENV UVICORN_HOST=0.0.0.0
ENV UVICORN_PORT=7234
CMD ["uvicorn", "faster_whisper_server.main:app"]
