#!/bin/bash
branch_name=$(git rev-parse --abbrev-ref HEAD)
branch_name=${branch_name//\//-}
commit_id=$(git rev-parse HEAD)
dockerfile=${1:-'local_cuda.dockerfile'}
nohup sudo docker build -t faster-whisper-server:${branch_name}-${commit_id} -f ${dockerfile} . &