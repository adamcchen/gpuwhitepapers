#!/bin/bash

# 创建一个存放下载文件的目录
# mkdir -p pdfs
cd ../pdfs

# PDF 文件的 URL 列表
urls=(
    "https://images.nvidia.com/content/volta-architecture/pdf/volta-architecture-whitepaper.pdf"
    "https://images.nvidia.cn/aem-dam/en-zz/Solutions/data-center/nvidia-ampere-architecture-whitepaper.pdf"
    "https://images.nvidia.com/content/pdf/tesla/whitepaper/pascal-architecture-whitepaper.pdf"
    # 添加更多 PDF 文件的 URL
)

# 使用循环逐一下载每个PDF
for url in "${urls[@]}"; do
    filename=$(basename "$url")
    if [ -f "$filename" ]; then
        echo "文件已存在，跳过：$filename"
    else
        echo "正在下载文件：$filename"
        # 使用 curl 下载文件
        curl -O "$url"
    fi
done

# 将 URLs 转为换行符分隔，并传递给 xargs
#printf "%s\n" "${urls[@]}" | xargs -n 1 -P 4 -I {} bash -c '{
#    file=$(basename {})
#    if [ ! -f "$file" ]; then
#        echo "正在下载文件：$file"
#        curl -O "$@"
#    else
#        echo "文件已存在，跳过：$file"
#    fi
#}' _ {}

echo "所有文件已下载到 `pwd` 目录下。"

