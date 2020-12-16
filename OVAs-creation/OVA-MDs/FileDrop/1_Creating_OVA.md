### This MD contains details on how to create SOW REST (FIleDrop) OVA from scratch.
### Prerequisite: VM on ESXi is created (first part of 2_StartingVM_ImportingOVA.md)

- Access the VM

- This step can be skipped. Network is already configured in previous section. Configure network to use DHCP on ESXi will not work. 
  
  ```bash
  sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"/g' /etc/default/grub
  update-grub
  rm /etc/netplan/*.yml /etc/netplan/*.yaml
  cat > /etc/netplan/network.yaml <<EOF
  network:
    version: 2
    ethernets:
      eth0:
        dhcp4: true
  EOF
  ```

- Install K3s: `curl -sfL https://get.k3s.io | sh -`

- Install helm: `curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash -`

- Clone the repo and change your working directory into the kubernetes directory: `git clone https://github.com/k8-proxy/sow-rest && cd sow-rest/kubernetes`

- Create kube config: `sudo ln -s /etc/rancher/k3s/k3s.yaml ~/.kube/config`

- Execute `./deploy.sh`

- Access the filedrop URL: `https://<VM IP>` and just click login (login details are not requiered)

- This VM once shutdown, can now be exported as OVA file.