# Fast Ruby Install

[Homebrew](https://brew.sh/index_ja) を用いて、rbenv, ruby-build, ruby, rubygems, bundlerをインストールするスクリプトです。  

rbenv, ruby-buildは最新バージョンを、ruby, rubygems, bundlerは指定したバージョンをインストールします。

## Installation

後述の `-ruby 2.7.3` `-gem 3.2.28` `-bundlers 2.2.28` にインストールしたいソフトウェアバージョンを指定して、ターミナルで実行して下さい。

※ bundlerを複数インストールしたい場合は `-bundlers '1.17.3 2.2.28'` の様にします。

**Run Example**

```
curl -fsSL https://raw.githubusercontent.com/Tea-and-Coffee/fast-ruby-install/master/install.sh | bash -s -- --ruby 2.7.3 --gem 3.2.28 --bundlers 2.2.28
```

## Other Usage

スクリプトファイルを編集して実行したい場合のために、run.shを用意しています。

run.shを開き、RUBY, GEM, BUNDLERSのバージョンナンバーを書き換えます。  

※ bundlerを複数インストールしたい場合は BUNDLERS=(1.17.3 2.2.28) の様にします。  

**Edit run.bash**

```ruby
# ruby 2.7.3の環境
RUBY=2.7.3
GEM=3.2.28
BUNDLERS=(2.2.28)
```

書き換えたらスクリプトを実行します。

**Run script**

```bash
$ bash run.sh
```
