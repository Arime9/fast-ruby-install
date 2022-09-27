#!/usr/bin/env bash

set -euxo pipefail

cd "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# brewでrbenv, ruby-buildのインストールを行う
function distill() {
	brew update

	while read formula; do
		if [[ $(brew list --formula | grep -e ${formula}) ]]; then
			brew upgrade ${formula}
		else
			brew install ${formula}
		fi
	done < ./list.csv

	brew cleanup
}

distill

# ruby, rubygems, bundlerのインストールを行う
function install() {
	# rubyのインストール
	if [[ $1 = "2.6.7" ]]; then
		# see: https://www.fixes.pub/program/444466.html
		export warnflags=-Wno-error=implicit-function-declaration
	fi

	if [[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'x86_64' ]] ; then
		rbenv install --skip-existing $1
	elif [[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] ; then
		RUBY_CFLAGS=-DUSE_FFI_CLOSURE_ALLOC rbenv install --skip-existing $1
	fi

	if [[ $1 = "2.6.7" ]]; then
		export -n warnflags
	fi

	echo $1 > .ruby-version
	ruby --version

	# rubygemsのインストール
	if [[ $2 = "latest" ]]; then
		gem update --system
	else
		gem update --system $2
	fi
	gem environment

	shift
	shift

	# bundlerのインストール
	for VERSION in $@; do
		set +x

		if [[ ${VERSION} = "latest" ]]; then
			CMD="gem install bundler"
		else
			CMD="gem install bundler --version ${VERSION}"
		fi

		expect -c "
		set timeout -1
		spawn ${CMD}
		expect -re \"Overwrite the executable?.*\"
		send \"y\n\"
		expect eof
		exit
		"

		set -x

		rbenv rehash
	done

	# bundlerのdefault .gemspecを取り除く
	GEM_DIR=$(gem environment gemdir)
	rm -f $(find ${GEM_DIR} -name 'bundler*.gemspec' | grep -e '/specifications/default/')
	find ${GEM_DIR} -name 'bundler*.gemspec' | grep -e '/specifications/'

	gem list
	bundler --version

	rm .ruby-version
}

# ruby 2.6.7の環境
RUBY=2.6.7
GEM=3.2.17
BUNDLERS=(1.17.3 2.2.17)

install ${RUBY} ${GEM} ${BUNDLERS[@]}

# ruby 2.7.3の環境
RUBY=2.7.3
GEM=3.2.28
BUNDLERS=(2.2.28)

install ${RUBY} ${GEM} ${BUNDLERS[@]}

# グローバルrubyバージョンを設定する
rbenv global ${RUBY}
rbenv versions

# bundlerのconfigを設定する
bundler config set path vendor/bundle
