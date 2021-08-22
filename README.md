# AWS インフラ構築
## ブランチ別の構成
### [master branch](https://github.com/Hidemasa-Kajita/aws_terraform/tree/master)
[AWS single.pdf](https://github.com/Hidemasa-Kajita/aws_terraform/files/7026714/AWS.single.pdf)

### [develop branch](https://github.com/Hidemasa-Kajita/aws_terraform/tree/develop)
[AWS double.pdf](https://github.com/Hidemasa-Kajita/aws_terraform/files/7026738/AWS.double.pdf)

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
