# ============================================================
# STAGE 1: Sistema base + uv
# Cambia solo si actualizas Ubuntu o CUDA
# ============================================================
FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV PATH="/root/.local/bin:$PATH"

RUN apt-get update && apt-get install -y \
    python3.12 \
    python3.12-dev \
    python3-pip \
    python3.12-venv \
    build-essential \
    gcc \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

WORKDIR /app


# ============================================================
# STAGE 2: Dependencias del pyproject.toml / uv.lock
# Cambia solo si modificas pyproject.toml o uv.lock
# ============================================================
FROM base AS deps

COPY pyproject.toml uv.lock ./

RUN uv venv --seed && uv sync --frozen --no-install-project

# ============================================================
# STAGE 3: vLLM + transformers
# Cambia solo si modificas setup.sh
# ============================================================
FROM deps AS venv

RUN uv pip install --upgrade pip

# El .venv ya existe del stage anterior, solo instalamos los extras
RUN /app/.venv/bin/pip install -U vllm --pre \
        --index-url https://pypi.org/simple \
        --extra-index-url https://wheels.vllm.ai/nightly \
    && /app/.venv/bin/pip install git+https://github.com/huggingface/transformers.git
# ============================================================
# STAGE 4: Imagen final
# Cambia cada vez que tocas serve.sh
# ============================================================
FROM base AS runtime

ENV HF_HOME=/models

COPY --from=venv /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/.venv"

COPY serve.sh .
RUN chmod +x serve.sh

VOLUME ["/models"]
EXPOSE 8000

CMD ["./serve.sh"]
