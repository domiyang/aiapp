#!/bin/bash
# to pre download the models from https://hf-mirror.com once only
# - 0. install wget, jq for your git-bash
# - 1. locate to the the preparation folder, e.g: C:\data\github\aiapp\preparation
# - 2. change the download_to_dir in hfd_models.sh if default value (~/hfd) is not suitable for you.
# - 3. start git-bash from this preparation folder
# - 4. run this: export HF_ENDPOINT="https://hf-mirror.com" && sh hfd_models_list.sh ; unset HF_ENDPOINT

# the location of hfd.sh
hfd_sh=./hfd.sh
# the location for local model storage
download_to_dir=~/hfd
# the tool used to download (wget or aria2c)
download_tool=wget
# common include_files for type1 (include model.safetensors)
include_files_type_safetensors="config.json merges.txt model.safetensors special_tokens_map.json tokenizer.json tokenizer_config.json vocab.json vocab.txt"
# common exclude_files for type2 (include pytorch_model.bin)
include_files_type_pytorch="config.json merges.txt pytorch_model.bin special_tokens_map.json tokenizer.json tokenizer_config.json vocab.json vocab.txt"

# single line command download sample
## download model w/o --include --exclude
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="facebook/detr-resnet-50" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} ; unset HF_ENDPOINT

## download model with --exclude
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="facebook/detr-resnet-50" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} --exclude pytorch_model.bin ; unset HF_ENDPOINT

## download model with include
### export HF_ENDPOINT="https://hf-mirror.com" && model_name="tabularisai/multilingual-sentiment-analysis" ; hfd_sh=./hfd.sh ; download_to_dir=~/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name} --include config.json merges.txt model.safetensors special_tokens_map.json tokenizer.json tokenizer_config.json vocab.json vocab.txt ; unset HF_ENDPOINT

## download dataset
### export HF_ENDPOINT="https://hf-mirror.com" && dataset_name="Yelp/yelp_review_full" ; hfd_sh=./hfd.sh ; download_to_dir=/d/hfd ; download_tool=wget ; sh +x ${hfd_sh} ${dataset_name} --tool $download_tool --local-dir ${download_to_dir}/datasets/${dataset_name} --dataset ; unset HF_ENDPOINT

function hfd_download() {
    local model_name=$1
    local include_files="$2"
    local exclude_files="$3"
    local dataset="$4"
    
    local download_cmd="sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/${model_name}"
    
    if [ -n "$include_files" ]; then
        download_cmd+=" --include ${include_files}"
    fi
    
    if [ -n "$exclude_files" ]; then
        download_cmd+=" --exclude ${exclude_files}"
    fi

    if [ -n "$dataset" ]; then
        # download dataset
        download_cmd="sh +x ${hfd_sh} ${model_name} --tool $download_tool --local-dir ${download_to_dir}/datasets/${model_name} --dataset"
        echo "Downloading dataset: $model_name using tool: $download_tool to directory: ${download_to_dir}/datasets/${model_name}"
    else
        # download model
        echo "Downloading model: $model_name using tool: $download_tool to directory: ${download_to_dir}/${model_name}"

        if [ -n "$include_files" ]; then
            echo "Including files: $include_files"
        fi

        if [ -n "$exclude_files" ]; then
            echo "Excluding files: $exclude_files"
        fi
    fi
    
    eval $download_cmd
}

# Example usage with include and exclude parameters
#hfd_download "tabularisai/multilingual-sentiment-analysis" "pytorch_model.bin,config.json" "tokenizer.json,vocab.txt"
#hfd_download "ProsusAI/finbert" "" "*.h5"  # Exclude all .h5 files
#hfd_download "boltuix/bert-emotion" "*.bin" "*.txt"  # Include binaries, exclude text files

hfd_download "tabularisai/multilingual-sentiment-analysis" "${include_files_type_safetensors}"
hfd_download "ProsusAI/finbert" "${include_files_type_pytorch}"
hfd_download "finiteautomata/bertweet-base-sentiment-analysis" "${include_files_type_safetensors}"
hfd_download "boltuix/bert-emotion" "${include_files_type_safetensors}"
hfd_download "cardiffnlp/twitter-roberta-base-sentiment-latest" "${include_files_type_pytorch}"
hfd_download "distilbert/distilbert-base-uncased-finetuned-sst-2-english" "${include_files_type_safetensors}"

hfd_download "dbmdz/bert-large-cased-finetuned-conll03-english" "${include_files_type_safetensors}"
hfd_download "Jean-Baptiste/roberta-large-ner-english" "${include_files_type_safetensors}"
hfd_download "deepset/tinyroberta-squad2" "${include_files_type_safetensors}"
hfd_download "distilbert/distilbert-base-cased-distilled-squad" "${include_files_type_safetensors}"

hfd_download "Falconsai/text_summarization" "${include_files_type_safetensors}"
hfd_download "google-t5/t5-base" "${include_files_type_safetensors}"

hfd_download "MIT/ast-finetuned-audioset-10-10-0.4593" "${include_files_type_safetensors}"
hfd_download "superb/hubert-base-superb-er" "${include_files_type_pytorch}"

hfd_download "openai/whisper-tiny" "${include_files_type_safetensors}"
hfd_download "openai/whisper-small" "${include_files_type_safetensors}"

hfd_download "Falconsai/nsfw_image_detection" "${include_files_type_safetensors}"
hfd_download "google/vit-base-patch16-224" "${include_files_type_safetensors}"

hfd_download "facebook/detr-resnet-50" "${include_files_type_safetensors}"
hfd_download "microsoft/conditional-detr-resnet-50" "${include_files_type_safetensors}"

hfd_download "google-bert/bert-base-cased" "${include_files_type_safetensors}"

# datasets
hfd_download "Yelp/yelp_review_full" "" "" --dataset
