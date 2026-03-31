#!/bin/bash
# Script para iniciar el servidor vLLM con el modelo GLM-4.7

# Activar el entorno virtual del proyecto
source .venv/bin/activate

# Comando para iniciar el servidor vLLM
# vllm serve QuantTrio/GLM-4.7-Flash-AWQ \
#      --quantization awq_marlin \
#      --dtype float16 \
#      --max-model-len 100768 \
#      --max-num-seq 8 \
#      --gpu-memory-utilization 0.90 \
#      --tool-call-parser glm47 \
#      --reasoning-parser glm45 \
#      --enable-auto-tool-choice \
#      --trust-remote-code \
#      --served-model-name glm \
#      --host 0.0.0.0 \
#      --port 8000

vllm serve QuantTrio/Qwen3.5-27B-AWQ \
     --max-model-len 81920 \
     --max-num-seq 6 \
     --gpu-memory-utilization 0.94 \
     --kv-cache-dtype fp8 \
     --enable-chunked-prefill \
     --reasoning-parser qwen3 \
     --trust-remote-code \
     --enable-auto-tool-choice \
     --tool-call-parser qwen3_coder \
     --served-model-name qwen3.5 \
     --host 0.0.0.0 \
     --port 8000
#     --max-num-batched-tokens 4096 \
