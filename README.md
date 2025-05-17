<div align="center">
<img alt="logo" height="120" src="./public/favicon.png" width="120"/>
<h2>今日热榜</h2>
<p>汇聚全网热点，热门尽览无余</p>
<br />
<img src="./screenshots/main.jpg" style="border-radius: 16px" />
</div>


## 示例

> 这里是示例站点

- [今日热榜 - https://hot.imsyy.top/](https://hot.imsyy.top/)


## 部署

```bash
// 安装依赖
pnpm install

// 开发
pnpm dev

// 打包
pnpm build
```

## Vercel 部署

现已支持 Vercel 一键部署，无需服务器

> 请注意，需要修改环境变量中的 API 地址

![Powered by Vercel](./public/ico/powered-by-vercel.svg)

## Cloudflare Pages 部署

项目同样支持通过 Cloudflare Pages 进行部署。

### 配置步骤：

1.  登录到您的 Cloudflare 仪表板并选择您的帐户。
2.  在帐户主页中，选择 **Workers & Pages** > **创建应用程序** > **Pages** > **连接到 Git**。
3.  选择您的项目仓库并点击 **开始设置**。
4.  在 **设置构建和部署** 部分，进行以下配置：
    *   **框架预设**：选择 `Vite` (Cloudflare Pages 通常会自动检测到 Vite 项目，或者您可以选择“静态站点”或类似的通用预设)。
    *   **构建命令**：Cloudflare 通常会自动检测到 `npm run build` 或 `yarn build`。如果您的项目使用 `pnpm`，请设置为 `pnpm run build`。根据 `package.json`，本项目使用 `pnpm`，因此构建命令应为 `pnpm run build`。
    *   **构建输出目录**：`dist` (Vite 默认输出目录，通常会被自动检测到)。
    *   **环境变量** (可选): 如果您的应用需要特定的环境变量（例如 API 地址），请在此处添加。对于本项目，如果 API 部署在其他地方，可能需要配置 `VITE_API_BASE_URL`。
5.  点击 **保存并部署**。

Cloudflare Pages 将会自动构建和部署您的站点。部署完成后，您将获得一个唯一的 `.pages.dev` 子域，或者您可以配置自定义域名。

**注意**：

*   确保您的项目中包含 `public/_redirects` 文件，内容为 `/* /index.html 200`。这对于单页面应用 (SPA) 在 Cloudflare Pages 上正确处理客户端路由非常重要。
*   如果遇到构建问题，请检查 Cloudflare Pages 的构建日志以获取详细信息。

## Docker 部署

项目支持通过 Docker 进行部署。

### 构建 Docker 镜像

在项目根目录下执行以下命令来构建 Docker 镜像：

```bash
docker build -t dailyhot .
```

### 运行 Docker 容器

构建完成后，可以使用以下命令来运行 Docker 容器：

```bash
docker run -d -p 8080:80 --name dailyhot-app dailyhot
```

这会将容器的 80 端口映射到主机的 8080 端口。您可以通过访问 `http://localhost:8080` 来查看应用。

### 使用预构建的 Docker Hub 镜像

您也可以直接使用 Docker Hub 上预构建的 `chuck4j/dailyhot:latest` 镜像进行部署。

拉取镜像：
```bash
docker pull chuck4j/dailyhot:latest
```

运行容器：
```bash
docker run -d -p 8080:80 --name dailyhot-app chuck4j/dailyhot:latest
```
同样，这会将容器的 80 端口映射到主机的 8080 端口。您可以通过访问 `http://localhost:8080` 来查看应用。
使用预构建镜像时，同样可以通过环境变量进行运行时配置，请参考下面的“运行时配置”部分。

### 后端 API 服务部署 (Docker)

如果您需要独立部署后端 API 服务，可以使用 Docker Hub 上预构建的 `chuck4j/dailyhot-api:latest` 镜像。

拉取 API 镜像：
```bash
docker pull chuck4j/dailyhot-api:latest
```

运行 API 容器：
```bash
docker run -d -p 6688:6688 --name dailyhot-api chuck4j/dailyhot-api:latest
```
上述命令会将 API 服务运行在容器的 6688 端口，并映射到主机的 6688 端口。您可以根据需要修改主机端口。

**API 服务配置：**

API 服务通常也支持通过环境变量进行配置（例如数据库连接信息、第三方服务密钥等）。请查阅 `chuck4j/dailyhot-api` 镜像的文档或源码以了解具体的环境变量配置方式。

### 运行时配置

应用支持通过环境变量在容器运行时进行配置。这些环境变量会在容器启动时被 `entrypoint.sh` 脚本用来生成 `/usr/share/nginx/html/config.js` 文件，从而动态配置应用。

支持的环境变量包括：

*   `VITE_GLOBAL_API`: 后端 API 的地址。例如：`https://your-api.com`
*   `VITE_ICP`: ICP 备案号。例如：`京ICP备XXXXXXXX号-X`
*   `VITE_DIR`: 应用的部署子目录。例如：`/myapp/` (如果应用部署在根目录，则为 `/`)

**示例：**

```bash
docker run -d -p 8080:80 \
  -e VITE_GLOBAL_API="https://api.example.com" \
  -e VITE_ICP="某ICP备XXXXXXXX号" \
  -e VITE_DIR="/" \
  --name dailyhot-app-custom \
  dailyhot
```

如果未提供这些环境变量，`entrypoint.sh` 会使用 `docker/config.template.js` 中定义的或者脚本内部设定的默认值。

**注意：**

*   确保 Dockerfile 中的 `COPY docker/config.template.js /usr/share/nginx/html/config.template.js` 这一行存在，以便 `entrypoint.sh` 能够找到模板文件。
*   `entrypoint.sh` 脚本会用环境变量的值替换 `config.template.js` 中的占位符 (如 `${VITE_GLOBAL_API}`)。
*   修改 `.env` 文件不会影响 Docker 容器内的配置，因为 `.env` 文件通常被 `.dockerignore` 排除，并且 Docker 容器的配置是通过运行时环境变量注入的。
