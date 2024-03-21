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
>// ファイル一式をc:\git\dwhbench\src配下に置いてあると想定
>do $system.OBJ.Load("c:\get\dwhbench\src\dwh\bitutil.inc")
>Do $system.OBJ.LoadDir("c:\git\dwhbench\src","ck",,1)
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

ベンチマークはエクセルファイル（query-result.xlsx）に記載されている各SQLコマンドを実行して計測

#### 注意事項

bitsliceベンチマークとcolumnarベンチマークを実施する際には、DWH.Patient.clsのインデックス定義を変更してコンパイルする。

コンパイル後、以下を実行し、その後でベンチマークを実施する

```
>zn "USER"
>Do ##class(DWH.Patient).%BuildIndices()
```
