# プロジェクトオイラー回答リポジトリ

- scheme 言語
- 処理系は gauche

## 結果発表スクリプト

```
 for file in $(find . -type f -name 'euler*.scm' | sort -t 'r' -k2.1n); do 
     echo "::::::::::::::::::::::::::";
     echo "::::::::::::::::::::::::::";
     echo "$file";
     time gosh $file > /dev/null
 done
```

