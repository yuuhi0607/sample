# Sample

GitHubAPIからリポジトリ一覧を取得して表示するサンプルプログラム。


This project is using __Carthage__  for external library management.

```
//first time or git branche switched
carthage bootstrap --platform iOS --cache-builds

//update library
carthage update --platform iOS --cache-builds
```


## External Library with Carthage

### 以下の外部ライブラリを使用しています

```
github "realm/realm-cocoa"
github "ReactiveX/RxSwift" ~> 4.0 
github "SVProgressHUD/SVProgressHUD"
github "DaveWoodCom/XCGLogger" ~> 6.0.2
github "SnapKit/SnapKit"
```
### テストプロジェクトで参照

```
github "AliSoftware/OHHTTPStubs"
github "Quick/Quick"
github "Quick/Nimble"
```

## Framework分割

CleanArchitectureを参考にApplication層にBuilder, Router, Configuratorを追加

### Application層

- RouterProtocol - 画面遷移の定義

### Presentation層

- PresenterProtocol
- PresenterImpl

### Domain層

- UseCaseProtocol
- UseCaseImpl
- RepositoryProtocol - RepositoryのProtocolをまとめる(Data層のRepositoryImpleのInterface)
- Model - ViewのModel
- Translator - EntityからModelに変換する


### Data層

- RepositoryImpl - Repositoryの実装をまとめる(NetworkApiまたはLocalStorage等の永続化をラップする)
- NetworkApi - API通信をまとめる
- NetworkApiImpl
- Entity - Data層用のEntityをまとめる


### その他

- Enum - Enum、Errorをまとめる(全てのレイヤーから参照可能とする)
- Environment - 環境設定をまとめる(全てのレイヤーから参照可能とする)。
- Logger - ロギングLibのラップクラス

