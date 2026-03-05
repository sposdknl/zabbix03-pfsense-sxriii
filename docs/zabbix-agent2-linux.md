# Linux VM + Zabbix Agent2 (Zabbix 7.0.23 LTS)

## Cíl



## Síť

- VM musí být routovatelná ze Zabbix serveru.
- Ověřit ping oběma směry.
- Otevřít TCP/10050 na Linux hostu.

## Instalace Agent2

### Debian/Ubuntu

```bash
wget https://repo.zabbix.com/zabbix/7.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest+debian$(lsb_release -rs)_all.deb
sudo dpkg -i zabbix-release_latest+debian*.deb
sudo apt update
sudo apt install -y zabbix-agent2 zabbix-agent2-plugin-*
```

### RHEL/Rocky/Alma

```bash
sudo rpm -Uvh https://repo.zabbix.com/zabbix/7.0/rhel/9/x86_64/zabbix-release-latest-7.0.el9.noarch.rpm
sudo dnf clean all
sudo dnf install -y zabbix-agent2 zabbix-agent2-plugin-*
```

## Konfigurace

Soubor: `/etc/zabbix/zabbix_agent2.conf`

- `Server=<IP_ZABBIX_SERVERU>`
- `ServerActive=<IP_ZABBIX_SERVERU>`
- `Hostname=<hostname_linux_vm>`



```bash
sudo systemctl enable --now zabbix-agent2
sudo systemctl status zabbix-agent2
```

## Zabbix GUI

1. Vytvořit hosta se stejným jménem jako `Hostname`.
2. Přidat Agent interface (IP Linux VM, port 10050).
3. Nalinkovat šablonu např. `Linux by Zabbix agent`.
4. Ověřit "Latest data" a dostupnost hosta.
