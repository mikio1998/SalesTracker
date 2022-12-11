
# Sales Tracker

洋服屋の為に作った、販売履歴を記録と在庫の補充ができる店員用アプリ。


## 環境
・MacbookPro M1 version.12.4  
・Swift 5  
・Xcode ver.13.4.1  
実機  
・iPhone11 Pro iOS 15.3



## 機能一覧
#### ユーザーログイン  
・FirebaseAuthを使用してメールとパスワードでログインを実施した。  
![](https://github.com/mikio1998/mikio1998.github.io/blob/master/images/Gifs/AppDemo5_AdobeExpress.gif?raw=true)

#### 商品検索  
・Cloud Firestoreを使用してデータを取得し、商品一覧を表示した。  
![](https://github.com/mikio1998/mikio1998.github.io/blob/master/images/Gifs/AppDemo1_MP4_AdobeExpress.gif?raw=true) 

・Nukeを使用して商品の画像を表示した。選択された商品のカラーの画像を表示した。  
![](https://github.com/mikio1998/mikio1998.github.io/blob/master/images/Gifs/AppDemo2_AdobeExpress%20(2).gif?raw=true)      

#### 在庫補充依頼一覧  
・Cloud Firestoreを使用して販売履歴のデータを取得し、在庫補充リストを表示した。  
・データは商品・サイズ・色・数で表示される。  
・補充数調整や補充済変更の操作も可能。  
![](https://github.com/mikio1998/mikio1998.github.io/blob/master/images/Gifs/AppDemo4_AdobeExpress.gif?raw=true)

#### 商品バーコードリーダー  
・AVFoundationを使用し、カメラで販売した商品のバーコードを読み取って登録する事が可能。  
![](https://github.com/mikio1998/mikio1998.github.io/blob/master/images/Gifs/AppDemo3_AdobeExpress.gif?raw=true)

#### Firebaseログアウト  
・FirebaseAuthのログアウト機能を実装した。




## Tech Stack
・Firebase  
・Firebase/Auth  
・Firebase/Firestore  
・FirebaseFirestoreSwift  
・SVProgressHUD  
・Nuke  
・AVFoundation
