# 
#

.PHONY: ansible
ansible:
	ansible-playbook -i inventory/hosts.ini main.yaml -K

.PHONY: clean
clean:
	rm -rf build dist

.PHONY: distribution 
distribution:
	rm -rf dist
	mkdir dist
	cp -r build/etc dist/
	butane --files-dir dist --pretty --strict build/master.bu > dist/master.ign
	butane --files-dir dist --pretty --strict build/worker.bu > dist/worker.ign
