# Fast Ruby Install

brew, rbenv, ruby-buildを用いて、任意のruby, rubygems, bundlerバージョンをインストールするスクリプトです。  

## Usage

任意のruby, rubygems, bundlerバージョンをインストールするために、run.bashに記述してある値を書き換えます。  
複数のrubyバージョンをインストールする場合にも対応しています。不要であれば1セットだけ残す様に、コメントアウトして下さい。

**Edit run.bash**

```ruby
# ruby 2.6.7の環境
RUBY=2.6.7
GEM=3.2.17
BUNDLERS=(1.17.3 2.2.17)
```

書き換えたらスクリプトを実行します。

**Run script**

```bash
$ bash run.bash
```
