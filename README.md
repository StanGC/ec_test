## 題目描述

簡易購物系統:

1. 包含使用者建立帳號、登入驗證的功能 (可用gem)，
2. 登入後可建立訂單或管理自己所建立過的訂單，
3. 每個訂單中包含1個或多個訂購的商品項目，
4. 商品項目可以預先建立，不需要設計商品的事前管理或上架介面。
5. 訂單頁面必須列出訂單內的所有商品項目包含名稱、單價、數量，以及訂單總金額
6. 訂單下訂前後都必須能修改商品。

## Setup

### step 1

安裝 Rails 所需依賴

```
$ bundle install
```

### step 2

建立數據庫與所需檔案

```
$ rake dev:rebuild
```

### step 3

`config/database.yml` 與 `config/app.yml` 填入所需 password、SITE_KEY、SECRET_KEY

### step 4

運行 server

```
$ rails server
```

查看 `localhost:3000` 可以看到符合 spec 的畫面
