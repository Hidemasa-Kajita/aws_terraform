# AWS インフラ構築
## ブランチ別の構成
### [master branch](https://github.com/Hidemasa-Kajita/aws_terraform/tree/master)
![AWS single](https://user-images.githubusercontent.com/54725215/130346605-ca547e9d-4473-48db-8ba9-9728a880fbdc.jpeg)

### [develop branch](https://github.com/Hidemasa-Kajita/aws_terraform/tree/develop)
![AWS double](https://user-images.githubusercontent.com/54725215/130346578-6c46d298-e234-4106-83cb-ec77de028e8d.jpeg)

## setup
1. AWSマネジメントコンソールからIAMユーザーを作成

2. `terraform.tfvars_sample`を参考に環境に合わせた変数を定義
```
cp terraform.tfvars_sample terraform.tfvars
```

3. sshキーを生成し、`.ssh/`に公開鍵と秘密鍵を配置（EC2にアクセスするための鍵ファイル）
- 公開鍵の命名: `key.pub`
- 秘密鍵の命名: `key.pem`

4. terraform 初期化
```
terraform init
```

5. 作成される構成の確認
```
terraform plan
```

6. 構成を反映
```
terraform apply
```

7. 構成を削除
```
terraform destroy
```
