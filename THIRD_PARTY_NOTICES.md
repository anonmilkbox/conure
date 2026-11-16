# Third-party notices

Conure's own code is MIT licensed (see `LICENSE`). It builds on the work below. The models and llama.cpp are not
part of this repository: `setup.ps1` downloads them from their official sources on your computer.

## Models (downloaded by setup)

| Model | Used for | License |
|---|---|---|
| [NVIDIA Parakeet TDT 0.6B v3](https://huggingface.co/nvidia/parakeet-tdt-0.6b-v3), ONNX conversion by [istupakov](https://huggingface.co/istupakov/parakeet-tdt-0.6b-v3-onnx) | Speech to text | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |
| [Qwen3-4B-Instruct-2507](https://huggingface.co/Qwen/Qwen3-4B-Instruct-2507) by the Qwen team, GGUF by [Unsloth](https://huggingface.co/unsloth/Qwen3-4B-Instruct-2507-GGUF) | Text cleanup | [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) |

## Runtime (downloaded by setup)

| Project | License |
|---|---|
| [llama.cpp](https://github.com/ggml-org/llama.cpp) | MIT |

## Python packages (installed by setup from PyPI)

| Package | License |
|---|---|
| [onnx-asr](https://github.com/istupakov/onnx-asr) | MIT |
| [onnxruntime](https://github.com/microsoft/onnxruntime) | MIT |
| [NumPy](https://numpy.org) | BSD 3-Clause |
| [sounddevice](https://github.com/spatialaudio/python-sounddevice) | MIT |
| [keyboard](https://github.com/boppreh/keyboard) | MIT |
| [uiautomation](https://github.com/yinkaisheng/Python-UIAutomation-for-Windows) | Apache 2.0 |
| [pywebview](https://github.com/r0x0r/pywebview) | BSD 3-Clause |
| [pystray](https://github.com/moses-palmer/pystray) | LGPL 3.0 (used unmodified, installed as a separate package) |
| [Pillow](https://python-pillow.org) | MIT-CMU |
| [huggingface_hub](https://github.com/huggingface/huggingface_hub) | Apache 2.0 |
| [PyWinRT](https://github.com/pywinrt/pywinrt) | MIT |

## Fonts (included in `fonts/`)

| Font | License |
|---|---|
| [Fredoka](https://github.com/hafontia/Fredoka-One) | SIL Open Font License 1.1 (`fonts/OFL-Fredoka.txt`) |
| [Figtree](https://github.com/erikdkennedy/figtree) | SIL Open Font License 1.1 (`fonts/OFL-Figtree.txt`) |
