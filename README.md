# ignition-configs

Author: Brian Tomlinson <btomlins@redhat.com>


## Description

Ignition configs for my Fedora CoreOS based projects.


## Requirements
- [Fedora 35](https://getfedora.org/)+ (versions prior to 35 are untested)
- [Ansible v2.9](https://www.ansible.com/)+
- [make](https://www.gnu.org/software/make/manual/make.html)


## Microshift on Raspberry Pi 400

The repo is currently structured for creating configurations necessary for deploying to and preparing the
[Raspberry Pi 400](https://www.raspberrypi.com/products/raspberry-pi-400/) for [Microshift](https://microshift.io).


### All-in-one Automation

To generate the ignition configs simply clone the repo and execute `make ansible`.

The `make ansible` command will execute `ansible-playbook -i inventory/hosts.ini main.yaml -K` by default. This will
prompt you for your `sudo` password before ensuring running the `playbooks/fedora-prereqs.yaml` playbook to install
package dependencies and then immediately generate `dist/master.ign` and `dist/worker.ign` via the
`playbooks/generate-ign.yaml` playbook.

Once the command exits, check `dist/` and you will find the `etc` directory tree populated with configurations included
in the ignition configs, as well as the ignition files.


### Available `make` targets

- `make ansible`: All-in-one automation via Ansible
- `make clean`: Deletes the `build` and `dist` directories
- `make distribution`: Creates the `dist` directory, copies the `etc` directory tree, and processes the butane configs


### Playbook structure

- `main.yaml` imports the `fedora-prereqs.yaml` and `generate-ign.yaml` playbooks
- `fedora-prereqs.yaml` ensures package dependencies are present
- `generate-ign.yaml` processes the templates in `playbooks/templates` to `build` and copies the `etc` directory tree


### Inventory variables

```
state: defaults to 'present', 'absent' is also valid and will remove elements similar to 'make clean'

ssh_user: defaults to the current $USER, used for finding the public SSH key of the user

ssh_pub_key: the public SSH key of the user, used to enable SSH for the 'core' user in the resulting image

prereq_pkgs:  list of package dependencies necessary for generating and consuming ignition configs

worker_hostname: the desired hostname of the worker node(s)

worker_ip: defaults to 'false', if declared will add the ip to the microshift config.yaml

master_hostname: the desired hostname of the master node(s)

master_ip: defaults to 'false', if declared will add the ip to the microshift config.yaml
```


## LICENSE

MIT, see LICENSE file.
