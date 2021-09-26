#!/usr/bin/env bash

set -euxo pipefail

# brewでrbenv, ruby-buildのインストールを行う
function distill() {
	brew update

	while read formula; do
		if [[ $(brew list --formula | grep -e ${formula}) ]]; then
			brew upgrade ${formula}
		else
			brew install ${formula}
		fi
	done < (rbenv ruby-build)

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

	rbenv install --skip-existing $1

	if [[ $1 = "2.6.7" ]]; then
		export -n warnflags
	fi

	echo $1 > .ruby-version
	ruby --version

	# rubygemsのインストール
	gem update --system $2
	gem environment

	shift
	shift

	# bundlerのインストール
	for VERSION in $@; do
		set +x

		CMD="gem install bundler --version ${VERSION}"

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

# 引数の例
#
# RUBY=2.7.3
# GEM=3.2.28
# BUNDLERS=(2.2.28)

declare -i argc=0
declare -a argv=()

while (( $# > 0 ))
do
    case $1 in
        -*)
            if [[ "$1" =~ 'ruby' ]]; then
                RUBY=$2
            fi
            if [[ "$1" =~ 'gem' ]]; then
                GEM=$2
            fi
            if [[ "$1" =~ 'bundlers' ]]; then
                BUNDLERS=$2
            fi
            shift
            shift
            ;;
        *)
            ((++argc))
            argv=("${argv[@]}" "$1")
            shift
            ;;
    esac
done

install ${RUBY} ${GEM} ${BUNDLERS[@]}

# rubyのグローバル環境
rbenv global ${RUBY}
rbenv versions