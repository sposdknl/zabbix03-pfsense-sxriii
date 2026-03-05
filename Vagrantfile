# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # DŮLEŽITÉ:
  # Název pfSense boxu zadejte explicitně přes PF_BOX.
  # Tím se vyhneme 404 chybám kvůli neplatným/default názvům.
  #
  # Příklady spuštění:
  #   Windows CMD:        set PF_BOX=ORG/BOX && vagrant up
  #   Windows PowerShell: $env:PF_BOX="ORG/BOX"; vagrant up
  #   Linux/macOS:        export PF_BOX=ORG/BOX && vagrant up
  pf_box = ENV["PF_BOX"]
  if pf_box.nil? || pf_box.strip.empty?
    raise <<~MSG
      Chybí proměnná PF_BOX.
      Nastavte ji na přesný název boxu z vašeho zadání (např. ORG/BOX).
      Pozor na překlepy typu netgate/pfsense-c (chybí 'e').
    MSG
  end

  config.vm.box = pf_box

  # Volitelné: pokud škola poskytuje privátní/URL box, nastavte PF_BOX_URL.
  if ENV["PF_BOX_URL"] && !ENV["PF_BOX_URL"].strip.empty?
    config.vm.box_url = ENV["PF_BOX_URL"]
  end

  config.vm.hostname = "pfsense-box"

  # NAT interface je ve VirtualBox provideru implicitní (adapter 1).
  # LAN pro monitoring mezi pfSense a Zabbix VM:
  config.vm.network "private_network",
    ip: "192.168.1.1",
    virtualbox__intnet: "pfsense-lan"

  # Přístup z hosta:
  config.vm.network "forwarded_port", guest: 443, host: 8888, auto_correct: true
  config.vm.network "forwarded_port", guest: 22, host: 2222, auto_correct: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "pfsense-box"
    vb.memory = 2048
    vb.cpus = 2
  end
end