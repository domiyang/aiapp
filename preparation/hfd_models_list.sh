#!/bin/bash

# the location of hfd.sh
hfd_sh=./hfd.sh
# the location for local model storage
download_to_dir=~/hfd
# the tool used to download (wget or aria2c)
download_tool=wget
# single line command download sample
## w/o --include --exclude
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="facebook/detr-resnet-50" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} ; unset HF_ENDPOINT
## with --exclude
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="facebook/detr-resnet-50" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} --exclude pytorch_model.bin ; unset HF_ENDPOINT
## with include
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="Jean-Baptiste/roberta-large-ner-english" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} --include config.json merges.txt model.safetensors special_tokens_map.json tokenizer_config.json vocab.json ; unset HF_ENDPOINT

function hfd_download() {
    local model_name=$1
    local include_files="$2"
    local exclude_files="$3"
    
    local download_cmd="sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name}"
    
    if [ -n "$include_files" ]; then
        download_cmd+=" --include ${include_files}"
    fi
    
    if [ -n "$exclude_files" ]; then
        download_cmd+=" --exclude ${exclude_files}"
    fi
    
    echo "Downloading model: $model_name using tool: $download_tool to directory: ${download_to_dir}/${model_name}"
    if [ -n "$include_files" ]; then
        echo "Including files: $include_files"
    fi
    if [ -n "$exclude_files" ]; then
        echo "Excluding files: $exclude_files"
    fi
    
    eval $download_cmd
}

#//TODO - to upate exclude or include to reduce the download size of models.
# Example usage with include and exclude parameters
#hfd_download "tabularisai/multilingual-sentiment-analysis" "pytorch_model.bin,config.json" "tokenizer.json,vocab.txt"
#hfd_download "ProsusAI/finbert" "" "*.h5"  # Exclude all .h5 files
#hfd_download "boltuix/bert-emotion" "*.bin" "*.txt"  # Include binaries, exclude text files

hfd_download "tabularisai/multilingual-sentiment-analysis"
hfd_download "ProsusAI/finbert"
hfd_download "finiteautomata/bertweet-base-sentiment-analysis"
hfd_download "boltuix/bert-emotion"

hfd_download "cardiffnlp/twitter-roberta-base-sentiment-latest"
hfd_download "distilbert/distilbert-base-uncased-finetuned-sst-2-english"

hfd_download "dbmdz/bert-large-cased-finetuned-conll03-english"
hfd_download "Jean-Baptiste/roberta-large-ner-english" "config.json merges.txt model.safetensors special_tokens_map.json tokenizer_config.json vocab.json"

hfd_download "deepset/tinyroberta-squad2"
hfd_download "distilbert/distilbert-base-cased-distilled-squad"

hfd_download "Falconsai/text_summarization"
hfd_download "google-t5/t5-base"

hfd_download "MIT/ast-finetuned-audioset-10-10-0.4593"
hfd_download "superb/hubert-base-superb-er"

hfd_download "openai/whisper-tiny"
hfd_download "openai/whisper-small"

hfd_download "Falconsai/nsfw_image_detection"
hfd_download "google/vit-base-patch16-224"

hfd_download "facebook/detr-resnet-50" "" "pytorch_model.bin"
hfd_download "microsoft/conditional-detr-resnet-50" "" "pytorch_model.bin"
