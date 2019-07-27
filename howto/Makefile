# PUBLIC DOMAIN https://github.com/hilbix/tino/blob/master/howto/Makefile

BINS=python3vim.sh
HOMES=.vimrc .tmux.conf
ROOTS=.apt

.PHONY:	love
love:	all

.PHONY:	all
all:	install

.PHONY:	install
install:
	[ -d "$$HOME/bin" ] || mkdir "$$HOME/bin"
	for a in $(BINS); do cmp -q "$$a" "$$HOME/bin/$$a" || ln --backup=t --relative "$$a" "$$HOME/bin/$$a"; done
	MORE=; [ 0 = "`id -u`" ] && MORE="$(ROOTS)"; for a in $(HOMES) $$MORE; do cmp -q "$$a" "$$HOME/$$a" || ln --backup=t --relative "$$a" "$$HOME/$$a"; done

