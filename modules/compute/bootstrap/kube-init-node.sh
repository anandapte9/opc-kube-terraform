#!/bin/bash
sudo systemctl enable docker
sudo systemctl start docker
sudo setenforce 0
cd /etc/systemd/system/kubelet.service.d/
sudo sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo touch 90-local-extras.conf
sudo chmod 777 90-local-extras.conf
sudo echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' > /etc/systemd/system/kubelet.service.d/90-local-extras.conf
sudo chmod 755 90-local-extras.conf
sudo swapoff -a
sudo systemctl daemon-reload
sudo systemctl enable kubelet
