## Repository VLLM
This repository is only built for running VLLM server via docker compose with configuration that works in RTX 5090 Blackwell

### Structure

I set a configuration using uv to manage better the changes about python version and some dependencies necesaries to launch vllm
- uv files: there are some uv files to handle better the python version and some dependencies
- Dockerfile: file to make the image that launches the service:
    1. First: build image with the dependenci