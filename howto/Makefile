# PUBLIC DOMAIN https://github.com/hilbix/tino/blob/master/howto/Makefile

BINS=python3vim.sh bash2vim.sh
HOMES=.vimrc .tmux.conf
ROOTS=.apt

.PHONY:	love
love:	all

.PHONY:	all
all:	install

.PHONY:	install
install:
	[ -d "$$HOME/bin" ] || mkdir "$$HOME/bin"
	for a in $(BINS); do cmp -s "$$a" "$$HOME/bin/$$a" || ln --backup=t -vs --relative "$$a" "$$HOME/bin/$$a"; done
	MORE=; [ 0 = "`id -u`" ] && MORE="$(ROOTS)"; for a in $(HOMES) $$MORE; do cmp -s "$$a" "$$HOME/$$a" || ln --backup=t -vs --relative "$$a" "$$HOME/$$a"; done

