# Verzeichnisse
SYSTEMD_DIR = systemd/services
SBIN_DIR = sbin

# Zielverzeichnisse
SYSTEMD_DEST = /etc/systemd/system
SBIN_DEST = /usr/local/sbin

# Dateien zum Installieren
SYSTEMD_FILES = $(wildcard $(SYSTEMD_DIR)/*)
SBIN_FILES = $(wildcard $(SBIN_DIR)/*)

# Installations- und Deinstallationsziele
.PHONY: install deinstall

install: install_systemd install_sbin

install_systemd:
	@echo "Installing systemd service files..."
	@for file in $(SYSTEMD_FILES); do \
		sudo cp $$file $(SYSTEMD_DEST); \
		sudo systemctl daemon-reload; \
		echo "Installed $$file"; \
	done

install_sbin:
	@echo "Installing binaries to /usr/local/sbin..."
	@for file in $(SBIN_FILES); do \
		sudo cp $$file $(SBIN_DEST); \
		echo "Installed $$file"; \
	done

deinstall: deinstall_systemd deinstall_sbin

deinstall_systemd:
	@echo "Removing systemd service files..."
	@for file in $(SYSTEMD_FILES); do \
		sudo rm -f $(SYSTEMD_DEST)/$$file; \
		echo "Removed $$file"; \
	done
	@sudo systemctl daemon-reload

deinstall_sbin:
	@echo "Removing binaries from /usr/local/sbin..."
	@for file in $(SBIN_FILES); do \
		sudo rm -f $(SBIN_DEST)/$$file; \
		echo "Removed $$file"; \
	done
