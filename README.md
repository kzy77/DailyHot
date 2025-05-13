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
    *   **框架预设**：选择 `Vite`。
    *   **构建命令**：Cloudflare 通常会自动检测到 `npm run build` 或 `yarn build`。如果您的项目使用 `pnpm`，请设置为 `pnpm run build`。根据 `package.json`，本项目使用 `pnpm`，因此构建命令应为 `pnpm run build`。
    *   **构建输出目录**：`dist` (Vite 默认输出目录)。
    *   **环境变量** (可选): 如果您的应用需要特定的环境变量（例如 API 地址），请在此处添加。对于本项目，如果 API 部署在其他地方，可能需要配置 `VITE_API_BASE_URL`。
5.  点击 **保存并部署**。

Cloudflare Pages 将会自动构建和部署您的站点。部署完成后，您将获得一个唯一的 `.pages.dev` 子域，或者您可以配置自定义域名。

**注意**：

*   确保您的项目中包含 `public/_redirects` 文件，内容为 `/* /index.html 200`，以确保 SPA 路由正常工作。
*   如果遇到构建问题，请检查 Cloudflare Pages 的构建日志以获取详细信息。
