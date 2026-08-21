# 瘦身记 - iPhone 安装使用指南

## 前置条件
- 你的 iPhone 和电脑连接**同一个 WiFi**
- 电脑上安装了 **Python** 或 **Node.js**（任选其一）

## 第一步：查看电脑 IP 地址
在电脑上按 `Win + R`，输入 `cmd`，回车，然后执行：
```
ipconfig
```
找到"无线局域网适配器 WLAN"下的 **IPv4 地址**，类似：
```
192.168.1.100
```

## 第二步：启动本地服务器
### 方法 A：双击运行
直接双击 `start-server.ps1`，脚本会自动启动服务器。

### 方法 B：手动启动
#### 如果你有 Python：
```powershell
cd C:\Users\ren12\.openclaw\workspace\weight-loss-tracker
python -m http.server 8080
```

#### 如果你有 Node.js：
```powershell
cd C:\Users\ren12\.openclaw\workspace\weight-loss-tracker
npx serve -l 8080
```

启动后，保持这个窗口不要关。

## 第三步：iPhone 上访问
1. 打开 iPhone 的 **Safari 浏览器**
2. 地址栏输入：
   ```
   http://<你的电脑IP>:8080
   ```
   例如：
   ```
   http://192.168.1.100:8080
   ```

## 第四步：添加到主屏幕（像 App 一样打开）
1. 页面加载后，点击 Safari 底部的 **分享按钮**（方框带箭头 ↑）
2. 选择 **"添加到主屏幕"**（Add to Home Screen）
3. 可以编辑名字，默认是"瘦身记"
4. 点击右上角 **"添加"**

完成后，iPhone 主屏幕就会出现一个 App 图标，点击后会：
- 全屏打开（没有 Safari 地址栏）
- 支持深色/液态玻璃 UI
- 数据保存在 iPhone 本地

## 常见问题

### 1. iPhone 打不开页面？
- 确认 iPhone 和电脑在同一个 WiFi
- 关闭电脑防火墙或放行 8080 端口
- 重新运行 `start-server.ps1`

### 2. 电脑重启后还能用吗？
电脑重启后需要重新运行 `start-server.ps1`。

### 3. 离开家还能用吗？
不能。这种方式依赖你的电脑和 WiFi。如果需要出门在外也能用，需要部署到服务器或云开发平台。

### 4. 如何让别人也能用？
需要把你的电脑暴露到公网（内网穿透），或者用 GitHub Pages/腾讯云开发等托管静态网页。
