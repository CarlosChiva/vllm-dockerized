#!/bin/bash
# Script para inicializar el entorno virtual con las dependencias necesarias

set -e

echo "Creando entorno virtual con uv..."
uv venv

echo "Activando entorno virtual..."
source .venv/bin/activate

echo "Sincronizando dependencias..."
uv sync

echo "Actualizando pip a la última versión..."
uv pip install --upgrade pip

echo "Instalando vllm y transformers..."
pip install -U vllm --pre --index-url https://pypi.org/simple --extra-index-url https://wheels.vllm.ai/nightly
pip install git+https://github.com/huggingface/transformers.git

echo "¡Entorno inicializado correctamente!"
echo "Para activar el entorno, ejecuta: source .venv/bin/activate"
echo "Para iniciar el servidor vLLM, ejecuta: vllm serve zai-org/GLM-4.7-Flash --tool-call-parser glm47"