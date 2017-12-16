data "template_file" "kube-userdata" {
  template = <<JSON
	{
	  "userdata": {
  		"yum_repos": {
  		  "public-yum-ol7-addon": {
          "name": "Oracle Linux $releasever Add ons ($basearch)",
          "baseurl":"http://yum.oracle.com/repo/OracleLinux/OL7/addons/$basearch",
          "gpgkey": "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-oracle",
          "gpgcheck": "1",
          "enabled": "1"
        },
        "kubernetes": {
          "name": "Kubernetes",
          "baseurl": "https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64",
          "enabled": "1",
          "gpgcheck": "1",
          "repo_gpgcheck": "1",
          "gpgkey": "https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg"
        }
  		},
      "packages": ["docker-engine","kubeadm","kubectl","kubelet"],
      "package_upgrade": true
	  }
	}
	JSON
}
