#!/bin/bash
# Script para iniciar el servidor vLLM con el modelo GLM-4.7

# Activar el entorno virtual del proyecto
source .venv/bin/activate

# Comando para iniciar el servidor vLLM
vllm serve QuantTrio/GLM-4.7-Flash-AWQ \
     --quantization awq_marlin \
     --dtype float16 \
     --max-model-len 80768 \
     --max-num-seq 6 \
     --gpu-memory-utilization 0.90 \
     --tool-call-parser glm47 \
     --reasoning-parser glm45 \
     --enable-auto-tool-choice \
     --trust-remote-code \
     --served-model-name glm \
     --host 0.0.0.0 \
     --port 8000