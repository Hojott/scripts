all: generate

generate:
	ifeq ($(strip $(XDG_CONFIG_HOME)),)
	cp backups.conf $(XDG_CONFIG_HOME)/backups.conf
	else
	cp backups.conf ~/.config/backups.conf
	endif

	install create_backups.sh  ~/.local/bin/backup

clean:
	rm  ~/.config/backups.conf
