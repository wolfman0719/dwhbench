# DWH DEMO

DWHベンチマークのDocker Build


## ビルドプロセス

### Build & Run
* ```docker-compose up -d --build```

### ローカルインストール(WindowsやMacOSにインストールしたIRISでセットアップする)

#### 関連クラスのロード

##### ターミナルでログイン

```
>zn "USER"
>set io = ##class(%SYS.NLS.Device).SetIO("UTF8")
>// ファイル一式をc:\git\dwh配下に置いてあると想定
>Do $system.OBJ.LoadDir("c:\git\dwh\","ck",,1)
>Do ##class(DWH.Patient).Populate(5000000)
>Do $SYSTEM.SQL.TuneSchema("DWH")
```

## 起動方法

### 管理ポータル

ローカルインストールの場合は、その環境に合わせたポート番号を指定

[localhost:52773/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS](http://localhost:52773/csp/sys/%25CSP.Portal.Home.zen?IRISUsername=_system&IRISPassword=SYS)

### Webターミナル

[localhost:52773/terminal/?IRISUsername=_system&IRISPassword=SYS](http://localhost:52773/terminal/?IRISUsername=_system&IRISPassword=SYS)

### ベンチマーク実施

ベンチマークはエクセルファイルに記載されている各SQLコマンドを実行して計測
