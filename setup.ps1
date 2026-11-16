# Conure setup. Installs Conure for the current Windows user into %USERPROFILE%\Conure.
# Easiest way to run it: double-click Setup.bat in this folder.
# Running it again is safe: anything already downloaded is skipped.
# -NoStart: install without starting Conure at the end.
param([switch]$NoStart)

$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"   # Invoke-WebRequest is far faster without its progress bar

$Repo   = $PSScriptRoot
$Target = Join-Path $env:USERPROFILE "Conure"
$Py     = Join-Path $Target "venv\Scripts\python.exe"
$LlamaUrl = "https://github.com/ggml-org/llama.cpp/releases/download/b12418/llama-b12418-bin-win-vulkan-x64.zip"
$ModelUrl = "https://huggingface.co/unsloth/Qwen3-4B-Instruct-2507-GGUF/resolve/main/Qwen3-4B-Instruct-2507-Q4_K_M.gguf"
$ModelFile = Join-Path $Target "models\Qwen3-4B-Instruct-2507-Q4_K_M.gguf"

function Step($text) { Write-Host ""; Write-Host "==> $text" -ForegroundColor Green }

Write-Host ""
Write-Host "Conure setup" -ForegroundColor Green
Write-Host "This installs Conure into $Target and downloads, one time:"
Write-Host "  - uv and Python 3.11 (if you don't have uv yet)       ~ 40 MB"
Write-Host "  - Python packages                                      ~ 300 MB"
Write-Host "  - llama.cpp (runs the cleanup model on your GPU)       ~ 60 MB"
Write-Host "  - Qwen3 4B cleanup model (Apache 2.0)                  ~ 2.5 GB"
Write-Host "  - NVIDIA Parakeet speech model (CC BY 4.0)             ~ 670 MB"
Write-Host "After that, Conure works fully offline. Nothing you say is ever sent anywhere."
$answer = Read-Host "Continue? [Y/n]"
if ($answer -and $answer -notmatch '^(y|yes)$') { Write-Host "Setup cancelled."; exit 1 }

New-Item -ItemType Directory -Force -Path $Target, (Join-Path $Target "models") | Out-Null

Step "Python"
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "Installing uv (a small Python installer from astral.sh)..."
    Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
    $env:Path = "$env:USERPROFILE\.local\bin;$env:Path"
}
if (-not (Test-Path $Py)) { uv venv --python 3.11 (Join-Path $Target "venv") }

Step "Python packages"
uv pip install --python $Py -r (Join-Path $Repo "requirements.txt")
if ($LASTEXITCODE) { throw "Installing the Python packages failed." }

Step "llama.cpp"
if (-not (Test-Path (Join-Path $Target "llama\llama-server.exe"))) {
    $zip = Join-Path $env:TEMP "conure-llama.zip"
    Invoke-WebRequest $LlamaUrl -OutFile $zip
    Expand-Archive $zip -DestinationPath (Join-Path $Target "llama") -Force
    Remove-Item $zip
} else { Write-Host "already there" }

Step "Cleanup model (2.5 GB, this takes a while)"
if (-not (Test-Path $ModelFile)) {
    curl.exe -L --fail -C - -o "$ModelFile.part" $ModelUrl   # -C - resumes if the download was interrupted
    if ($LASTEXITCODE) { throw "Downloading the cleanup model failed. Run setup again to resume." }
    Move-Item "$ModelFile.part" $ModelFile
} else { Write-Host "already there" }

Step "Speech model"
& $Py -c "import onnx_asr; onnx_asr.load_model('nemo-parakeet-tdt-0.6b-v3', quantization='int8'); print('ready')"
if ($LASTEXITCODE) { throw "Downloading the speech model failed. Run setup again." }

Step "Installing Conure"
& $Py (Join-Path $Repo "dictate.py") --install
if ($LASTEXITCODE) { throw "Installing Conure failed." }

Step "Done"
Write-Host "Conure is installed. It starts with Windows and lives in the tray next to the clock."
if ($NoStart) { exit 0 }
Write-Host "Starting it now: a short welcome tour will open."
$exe = Join-Path $Target "app\Conure.exe"
if (Test-Path $exe) { Start-Process $exe } else { Start-Process (Join-Path $Target "venv\Scripts\pythonw.exe") -ArgumentList "`"$(Join-Path $Target 'app\dictate.py')`"" }
