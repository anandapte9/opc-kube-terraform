# opc-kube-terraform
Terraform scripts for standing up Kubernetes Cluster consisting of one Master and user-defined number of Nodes on Oracle Public Cloud (compute classic).

Key Points to note:
1) Use this only to learn to test out the capabilities & little bit about Terraform and Kubernetes. Not to be used for production workloads.
2) Only works for OPC compute classic.
3) Currently made only for 1 master and multi node Kubernetes cluster (multi master scripts will be uploaded in sometime).
4) Will not work on Ubuntu (will add the Ubuntu version a little later). Try it out on Oracle Linux, CentOS etc.

Pre-Requisite:

Mandatory: 

    1) An account on Oracle Public Cloud (You can create 1 month trial account).
    
    2) Known identity domain & rest end point and ofcopurse your user ID/password for the OPC account.
    
    3) Terraform locally installed. 
    
    4) ssh keys locally generated and copied as per the steps mentioned below.
    
Nice-to-have:

    1) Atom edition to edit Terraform scripts to suit your needs.
    
How to user this:

    1) Generate ssh key to be used for your compute instances.  -->  ssh-keygen -t rsa (Don't use passphrase as you need auto login to have Terraform configure the K8S cluster automatically)
    
    2) Save the generated private key under key folder of every module (I would have wanted to save files under one single folder outside of the modules but shame that the relative path doesn't work on Windows, it would work on mac however would need a couple of updates to be made under each of the modules configuration files - easier in this instance is to copy the files under each "keys" folder).
    
    3) Initialize Terraform from within the root folder.
    
        terraform init
    
    4) Run terraform get from within the root folder. 
    
       terraform get
       
    5) Update 
    
    
     
