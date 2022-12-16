# Fast Ruby Install

[Homebrew](https://brew.sh/index_ja) を用いて、[rbenv](https://github.com/rbenv/rbenv), [ruby-build](https://github.com/rbenv/ruby-build), [ruby](https://github.com/ruby/ruby), [rubygems及びbundler](https://github.com/rubygems/rubygems) をインストールするスクリプトです。  

rbenv, ruby-buildの最新バージョンをインストールした後、指定したバージョンのruby, rubygems, bundlerをインストールします。

## Installation

後述の `--ruby 2.7.6` `--gem 3.3.22` `--bundlers 2.3.22` にインストールしたいソフトウェアバージョンを指定して、ターミナルで実行して下さい。

**Run Example**

```
curl -fsSL https://raw.githubusercontent.com/Tea-and-Coffee/fast-ruby-install/master/install.sh | bash -s -- --ruby 2.7.6 --gem 3.3.22 --bundlers 2.3.22
```

※ rubygemsの最新バージョンをインストールしたい場合は `--gem latest` と入力します。  
※ bundlerの最新バージョンをインストールしたい場合は `--bundlers latest` と入力します。  
※ bundlerを複数インストールしたい場合は `--bundlers '1.17.3 2.3.22'` の様にします。 

## Other Installation

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
