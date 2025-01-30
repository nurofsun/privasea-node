# Privanetix Node Installation 

**This guide only Ubuntu users, or VPS Ubuntu.** No other distro.

- Open your VPS/Machine
- Run below command
- Wait installation success

``` bash
source <(wget -O - https://raw.githubusercontent.com/nurofsun/privasea-node/refs/heads/main/install.sh)
```

- After copying Container ID please check that your node is running correctly
  
```bash
docker logs -t <container_id_here>
```

- Final step, download your wallet keystore (wallet_keystore) on /privasea/config/.

After doing above step, you're ready to the 2nd step [on Tutorial Page](https://www.privasea.ai/privanetix-node)
