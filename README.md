# Deployment example to Azure Container Apps using bicep, GitHub Container Registry, GitHub Actions

![diagram](https://res.cloudinary.com/dt8zu6zzd/image/upload/blog/azure-container-bicep/zu1.png)

Azure Container Apps へ bicep,GitHub Container Registry,GitHub Actions を使ってデプロイの Example です。

<br />

Web アプリは、create-react-app で作成したものそのままです。

<br />

GitHub Actions の deploy ジョブで作成されるリソースは、以下です。  
・ログ分析ワークスペース  
・Application Insights  
・Azure Container Apps の環境  
・Azure Container Apps のアプリ

<br />

詳細な手順は、こちらのブログ記事に書きました。（外部リンクです。）  
[Azure Container Apps へ bicep,GitHub Container Registry,GitHub Actions を使ってデプロイ](https://itc-engineering-blog.netlify.app/blogs/azure-container-bicep)

<br />

<br />

This is an example of deploying to Azure Container Apps using bicep, GitHub Container Registry, and GitHub Actions.

<br />

The web app is the same as the one created with create-react-app.

<br />

The resources created by the GitHub Actions deploy job are:  
・Log analysis workspace  
・Application Insights  
・Azure Container Apps environment  
・Azure Container Apps

<br />

For detailed instructions, check out this blog post. (External link, In Japanese)  
[Deploy to Azure Container Apps using bicep, GitHub Container Registry, GitHub Actions](https://itc-engineering-blog.netlify.app/blogs/azure-container-bicep)
