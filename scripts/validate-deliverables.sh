#!/usr/bin/env bash
set -euo pipefail

fail=0

check_file() {
  if [[ ! -f "$1" ]]; then
    echo "[ERR] Chybí soubor: $1"
    fail=1
  else
    echo "[OK ] $1"
  fi
}

check_file "README.md"
check_file "Vagrantfile.pfsense"
check_file "pfsense-box.txt"
check_file "NetgateID.txt"
check_file "exports/Template_PFSense_by_SNMP.yaml"

if [[ -f pfsense-box.txt ]]; then
  if rg -q "sysContact\.0 = STRING: skolni\.email@sposdk\.cz" pfsense-box.txt; then
    echo "[OK ] pfsense-box.txt obsahuje sysContact se školním emailem"
  else
    echo "[ERR] pfsense-box.txt neobsahuje požadovaný sysContact"
    fail=1
  fi
fi

if [[ -f Vagrantfile.pfsense ]]; then
  if rg -q 'ENV\["PF_BOX"\]' Vagrantfile.pfsense; then
    echo "[OK ] Vagrantfile.pfsense vyžaduje PF_BOX (prevence 404 na špatném defaultu)"
  else
    echo "[ERR] Vagrantfile.pfsense nevyžaduje PF_BOX"
    fail=1
  fi

fi

if [[ -d screenshots ]]; then
  count=$(find screenshots -maxdepth 1 -type f | wc -l)
  if [[ "$count" -ge 3 ]]; then
    echo "[OK ] screenshots/ obsahuje alespoň 3 soubory"
  else
    echo "[WARN] screenshots/ obsahuje méně než 3 soubory ($count)"
  fi
else
  echo "[WARN] chybí adresář screenshots/"
fi

if [[ "$fail" -ne 0 ]]; then
  echo "VALIDACE: NEPROŠLA"
  exit 1
fi

echo "VALIDACE: PROŠLA"
