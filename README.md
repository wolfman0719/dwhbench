# DWH DEMO

DWHベンチマークのDocker Build


## ビルドプロセス

### Build & Run
* ```docker-compose up -d --build```

### ローカルインストール(WindowsやMacOSにインストールしたIRISでセットアップする)

#### 関連クラスのロード

ターミナルでログイン

```
>zn "FAQ"
>set pDir = "c:\git\FAQDEMO\FAQ"
>Do $system.OBJ.Load(pDir_"\KB\Setup.cls","ck")
```

### SetupLocalの実行

```
>do ##class(KB.Setup).SetupLocal(pDir)
```



## 起動方法

### 管理ポータル

[localhost:52773/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS](http://localhost:52773/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS)

### Webターミナル

[localhost:52773/terminal/?IRISUsername=_system&IRISPassword=SYS](http://localhost:52773/terminal/?IRISUsername=_system&IRISPassword=SYS)
