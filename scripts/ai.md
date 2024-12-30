# Download with python

要使用脚本从网址下载若干个 PDF 文件，你可以选择使用 Python，因为它提供了处理HTTP请求的强大库，并且易于编写和理解。下面我将为你详细介绍如何使用 Python 来下载 PDF 文件。

### 准备工作：

确保你的系统中已经安装了 Python。如果还未安装，可以从 [Python官网](https://www.python.org/downloads/) 下载并安装。

### 使用 Python 的 `requests` 模块：

我们将使用 `requests` 模块来处理 HTTP 请求。如果你的系统中未安装 `requests` 模块，请先通过以下命令安装：

```bash
pip install requests
```

### 编写 Python 脚本下载 PDF：

接下来，创建一个 Python 脚本来下载一个或多个 PDF 文件。首先创建一个包含所有 PDF 网址的列表，然后逐一下载每个文件。

1. 创建一个新的 Python 文件，例如 `download_pdfs.py`。
2. 使用以下脚本内容（记得替换 URL 列表中的 URL 为你需要下载的 PDF 的 URL）:

```python
import requests
import os

# PDF 文件的 URL 列表
pdf_urls = [
    "https://example.com/pdf1.pdf",
    "https://example.com/pdf2.pdf",
    # 添加更多 PDF 文件的 URL
]

# 设定下载文件夹
download_dir = "pdf_downloads"
os.makedirs(download_dir, exist_ok=True)

# 下载 PDF 文件的函数
def download_pdf(url):
    try:
        response = requests.get(url)
        response.raise_for_status()  # 会在响应状态码不是 200 时引发 HTTPError 异常

        # 提取 URL 中文件名部分来命名本地文件
        filename = url.split("/")[-1]
        save_path = os.path.join(download_dir, filename)

        # 以二进制写模式打开文件，并保存内容
        with open(save_path, 'wb') as f:
            f.write(response.content)
        print(f"{filename} 已下载到 {save_path}")
    except requests.exceptions.RequestException as e:
        print(f"下载失败：{url} - 错误信息: {e}")

# 逐一下载每个 PDF
for url in pdf_urls:
    download_pdf(url)
```

### 运行脚本：

使用命令行跳转到脚本所在目录，然后运行脚本：

```bash
python download_pdfs.py
```

这个脚本会下载列表中的每个 PDF 文件到同目录下的 `pdf_downloads` 文件夹中。如果文件夹不存在，脚本会自动创建它。

### 说明：

- 脚本中的 `requests.get()` 函数用于获取给定 URL 的内容。
- 通过检查响应异常来处理可能的下载错误，例如网络问题或文件不存在。
- 文件是以二进制写模式保存，确保 PDF 的格式不会在下载过程中被破坏。

如果需要处理更大的文件或更复杂的情况（例如认证保护的下载），你可能需要为 `requests.get()` 添加额外的参数或错误处理逻辑。

# Download with shell

使用 Shell 脚本来下载 PDF 文件的优势在于其简洁性和对大多数 Linux 及 Unix 系统的天然支持。我们可以使用常见的命令行工具如 `curl` 或 `wget` 来实现下载功能。这些工具在大多数 Linux 发行版和 macOS 中已预装，在 Windows 上也可通过安装相应的软件包来使用。

以下是一个使用 `wget` 的 Shell 脚本示例，用于下载若干个 PDF 文件：

### 1. 创建 Shell 脚本

首先，打开文本编辑器并创建一个新的 Shell 脚本文件，例如 `download_pdfs.sh`。

### 2. 脚本内容

在脚本中，你需要列出所有想要下载的 PDF 文件的 URL，然后用 `wget` 或 `curl` 来下载每个文件。下面是使用 `wget` 的一个示例：

```bash
#!/bin/bash

# 创建一个存放下载文件的目录
mkdir -p pdf_downloads
cd pdf_downloads

# PDF 文件的 URL 列表
urls=(
    "https://example.com/pdf1.pdf"
    "https://example.com/pdf2.pdf"
    # 添加更多 PDF 文件的 URL
)

# 使用循环逐一下载每个 PDF
for url in "${urls[@]}"; do
    echo "下载文件：$url"
    wget "$url"
done

echo "所有文件已下载到 `pwd` 目录下。"
```

### 3. 使脚本可执行

保存文件后，打开终端，转到脚本所在的目录。使用以下命令使脚本可执行：

```bash
chmod +x download_pdfs.sh
```

### 4. 运行脚本

现在，你可以通过以下命令运行脚本：

```bash
./download_pdfs.sh
```

### 使用 `curl` 替代 `wget`

如果你更喜欢使用 `curl` ，可以将下载命令替换为 `curl` 相应的命令行。修改后的下载部分如下：

```bash
# 使用循环逐一下载每个 PDF
for url in "${urls[@]}"; do
    echo "下载文件：$url"
    curl -O "$url"
done
```

### 注意事项

1. 确保你的网络连接是活跃的，且你有权访问列表中的 URL。
2. 该脚本假定你使用的是默认的无需身份验证的设置。如果 PDF 需要 HTTP 认证，你可能需要在 `wget` 或 `curl` 命令中添加额外的参数，如 `-u username:password`。
3. 如果你的 URL 遵循一定模式，你可能可以用脚本逻辑生成这些 URL，而不是手动列出每个。

这个方法为在 Unix-like 系统环境下简单快速地下载一系列文件提供了一个基本的脚本框架。

要修改脚本以避免重新下载已经存在的文件，可以在下载之前检查文件是否已存在于目标目录中。如果文件已存在，脚本可以跳过下载步骤。这个功能可以通过添加一个简单的条件检查来实现。

以下是更新后的脚本，利用 `wget` 的 `-nc` (no-clobber) 选项或者通过手动检查文件存在与否来阻止重复下载：

### 使用 `wget` 的 `-nc` 选项

`wget` 的 `-nc` 或 `--no-clobber` 选项可以避免下载已存在的文件，这是一个简单的解决方案：

```bash
#!/bin/bash

# 创建一个存放下载文件的目录
mkdir -p pdf_downloads
cd pdf_downloads

# PDF文件的URL列表
urls=(
    "https://example.com/pdf1.pdf"
    "https://example.com/pdf2.pdf"
    # 添加更多 PDF 文件的 URL
)

# 使用循环逐一下载每个PDF
for url in "${urls[@]}"; do
    echo "尝试下载文件：$url"
    wget -nc "$url"
done

echo "所有文件尝试下载完成，保存在 `pwd` 目录下。"
```

### 手动检查文件是否已存在

如果你希望有更多控制（比如记录哪些文件被跳过了），你可以手动添加检测逻辑：

```bash
#!/bin/bash

# 创建一个存放下载文件的目录
mkdir -p pdf_downloads
cd pdf_downloads

# PDF文件的URL列表
urls=(
    "https://example.com/pdf1.pdf"
    "https://example.com/pdf2.pdf"
    # 添加更多 PDF 文件的 URL
)

# 使用循环逐一下载每个PDF
for url in "${urls[@]}"; do
    filename=$(basename "$url")
    if [ -f "$filename" ]; then
        echo "文件已存在，跳过：$filename"
    else
        echo "下载文件：$url"
        wget "$url"
    fi
done

echo "所有文件尝试下载完成，保存在 `pwd` 目录下。"
```

这段脚本首先通过 `basename` 命令从 URL 提取文件名，然后检查该文件是否已存在于当前目录中。如果文件已存在，则跳过下载；否则，使用 `wget` 下载该文件。

### 提示

- 使用 `curl` 时没有内建的 `-nc` 相似选项，所以如果你使用 `curl`，你需要手动检查文件是否存在。
- 脚本中添加的消息提供了额外的信息，方便了解哪些文件被下载，哪些被跳过。

这些改动能有效地使脚本在处理大量文件时更加高效，避免不必要的网络传输和时间浪费。

