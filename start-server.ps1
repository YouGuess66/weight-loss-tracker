# 瘦身记本地服务器启动脚本
# 在 iPhone 上像 App 一样使用

$host.ui.RawUI.WindowTitle = "瘦身记本地服务器"

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$port = 8080
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

# 尝试用 Python 启动
$python = Get-Command python.exe -ErrorAction SilentlyContinue
if (-not $python) {
    $python = Get-Command python3 -ErrorAction SilentlyContinue
}

if ($python) {
    Write-Host "使用 Python 启动服务器..." -ForegroundColor Green
    $cmd = "$($python.Source) -m http.server $port --directory `"$scriptPath`""
    Write-Host "地址: http://<你的电脑IP>:$port" -ForegroundColor Cyan
    Invoke-Expression $cmd
} else {
    Write-Host "未找到 Python，尝试使用 Node.js..." -ForegroundColor Yellow
    $node = Get-Command node.exe -ErrorAction SilentlyContinue
    if (-not $node) {
        Write-Error "未找到 Python 或 Node.js，请安装其中一个。"
        pause
        exit 1
    }

    $serverCode = @"
const http = require('http');
const fs = require('fs');
const path = require('path');
const port = $port;
const dir = process.cwd();

const mime = {
  '.html': 'text/html; charset=utf-8',
  '.js': 'application/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.svg': 'image/svg+xml'
};

http.createServer((req, res) => {
  let file = path.join(dir, req.url === '/' ? '/index.html' : req.url);
  const ext = path.extname(file).toLowerCase();
  fs.readFile(file, (err, data) => {
    if (err) {
      res.writeHead(404);
      res.end('Not found');
      return;
    }
    res.writeHead(200, { 'Content-Type': mime[ext] || 'application/octet-stream' });
    res.end(data);
  });
}).listen(port, '0.0.0.0', () => {
  console.log('服务器运行在 http://0.0.0.0:' + port);
});
"@
    $tmp = [System.IO.Path]::GetTempFileName() + '.js'
    [System.IO.File]::WriteAllText($tmp, $serverCode, [System.Text.Encoding]::UTF8)
    Write-Host "地址: http://<你的电脑IP>:$port" -ForegroundColor Cyan
    node $tmp
}
