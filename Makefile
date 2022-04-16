# 
#

.PHONY: all
all:
	ansible-playbook -i inventory/hosts.ini -c local main.yaml -K

.PHONY: fedora-prereqs
fedora-prereqs:
	ansible-playbook -i inventory/hosts.ini -c local playbooks/fedora-prereqs.yaml -K

.PHONY: generate-ignition
generate-ignition:
	ansible-playbook -i inventory/hosts.ini -c local playbooks/generate-ign.yaml

.PHONY: prepare-sdcard
prepare-sdcard:
	ansible-playbook -i inventory/hosts.ini -c local playbooks/prepare-sdcard.yaml -K

.PHONY: clean
clean: clean-build clean-dist clean-cache

.PHONY: clean-build
clean-build:
	rm -rf build

.PHONY: clean-dist
clean-dist:
	rm -rf dist

.PHONY: cache-clean
clean-cache:
	rm -rf cache

.PHONY: distribution 
distribution:
	rm -rf dist
	mkdir dist
	cp -r build/etc dist/
	butane --files-dir dist --pretty --strict build/master.bu > dist/master.ign
	butane --files-dir dist --pretty --strict build/worker.bu > dist/worker.ign
