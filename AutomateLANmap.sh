read -p "Introduce la direccion de red en este formato 192.168.0.1/24: " LANaddr
nmap -sP --min-rate 5000 $LANaddr  -oG LANAddrreport
mkdir reportes
ips = $("cat LANAddrreport | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u")
echo $ips >> reportes/host.txt
cat host.txt
while IFS= read -r ip
do
  echo "Escaneando $ip..."
  nmap -sV -O -sC --min-rate 5000 -T5 "$ip" --verbose -4 -oN "$ip.txt"
done < reportes/host.txt
for file in reportes/ip*
do
  cat file
done
