# opc-kube-terraform
Terraform scripts for standing up Kubernetes Cluster consisting of one Master and user-defined number of Nodes on Oracle Public Cloud (compute classic).

Key Points to note:
1) Use this only to learn to test out the capabilities & little bit about Terraform and Kubernetes. Not to be used for production workloads.
2) Only works for OPC compute classic.
3) Currently made only for 1 master and multi node Kubernetes cluster (multi master scripts will be uploaded in sometime).
4) Will not work on Ubuntu (will add the Ubuntu version a little later). Try it out on Oracle Linux, CentOS etc.

Pre-Requisite:

Mandatory:

    1) An account on Oracle Public Cloud (You can create 1 month trial account, if you have a paid account, its up to you to make sure you know that you are going to spend on creating these resources on the cloud). (https://cloud.oracle.com/en_US/tryit)
    2) Known identity domain & rest end point and ofcopurse your user ID/password for the OPC account. User that is expected to be used should have compute_operations role assigned (if you are using your root user, it will have this role by default).
    3) Terraform locally installed. (https://www.terraform.io/intro/getting-started/install.html)
    4) ssh keys locally generated and copied as per the steps mentioned below.

Nice-to-have:

    1) Atom editor to edit Terraform scripts to suit your needs.
    2) Git Bash if you are on windows.

Infrastructure:

These Terraform scripts create the following resources on Oracle cloud.

    - Networking resources
        - One single IP network with a user defined IP address prefix (or the CIDR range).
        - ssh-keys to be associated to the instances.
        - Security rules & access control list for access control.
    - Compute resources -
        - 1 Master and user defined number of node instances.
        - IP Address reservation to assign a public IP to each of the instances.
        - Virual NIC set assigned to each instance to expose the public IP to be used.
    - Kube resources -
       - Instances bootstraped to update yum repos and install kubernetes and related dependencies.
       - Kube master initialization.
       - Kube node addition to the master.
    - Output -
       - Public IPs of master and node instances for you to login to and confirm the cluster status.

How to user this:

    1) Clone this repository first.
    2) Copy terraform.examples.tfvars to terraform.tfvars and set appropriate initialization parameters.
    3) Generate ssh key to be used for your compute instances.  -->  ssh-keygen -t rsa (Don't use passphrase as you need auto login to have Terraform configure the K8S cluster automatically).
    4) Save the generated private key under keys folder of every module (I would have wanted to save files under one single folder outside of the modules but shame that the relative path doesn't work on Windows, it would work on mac however would need a couple of updates to be made under each of the modules configuration files - easier in this instance is to copy the files under each "keys" folder).Also you will have to create keys folder under every module and copy the private key there.
    5) Initialize Terraform from within the root folder. --> terraform init
    6) Run terraform get from within the root folder. --> terraform get
    7) Run terraform plan from within the root folder to see if it generates the plan that you want.
    8) Run terraform apply from within the root folder to create the appropriate resources (this takes anywhere from 10-15 mins).
    9) Get the public IP for your master instance from the output and login using the private key corresponding to the key that you supplied in terraform.tfvars file.
    10) Run following commands to confirm the kubernetes cluster health.
       - kubectl get nodes --> should show the nodes as Ready.
       - kubectl get pods --all-namespaces --> Should show all the kube-system pods including apiserver,   controller-manager, dns, kube-proxy and Calico pod network PODs as running.
