# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "docker-base"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
   end
  config.vm.network "forwarded_port", guest: 3000, host:3000,
    auto_correct: true
$bootstrap_script = <<BOOTS
echo "Get some Coffee -- this is going to take a while"
echo "------------------------------------------------"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
sudo apt-get -y update
sudo apt-get -y -q install linux-image-extra-`uname -r`
sudo apt-get -y -q install git lxc-docker
sudo usermod -G docker vagrant
BOOTS
  config.vm.provision :shell, inline: $bootstrap_script
end
