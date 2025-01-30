# Privanetix Node Installation 

**This guide only Ubuntu users, or VPS Ubuntu.** No other distro.

- Open your VPS/Machine
- Run below command
- Wait installation success

``` bash
source <(wget -O - https://raw.githubusercontent.com/nurofsun/privasea-node/refs/heads/main/install.sh)
```
- Enter password and verify it
- Enter again password to begin running the node
- After copying Container ID please check that your node is running correctly
  
```bash
docker logs -t <container_id_here>
```

- Final step, download your wallet keystore (wallet_keystore) on /privasea/config/.
- Go to [privanetix dashboard](https://deepsea-beta.privasea.ai/)
- Connect wallet
- Request [Arbitrum Sepolia Faucet](https://faucet.quicknode.com/arbitrum/sepolia)
- Request [Privanetix Test Token](https://deepsea-beta.privasea.ai/deepSeaFaucet)
- Now, go to **My Privanetix Node**

![This is example](https://i.ibb.co.com/21mK9cPb/Screenshot-20250130-181142.png)

- Setup your node
- Enter node name (anything)
- Enter your node address (you got it from installation before)
- Click Setup my node & Confirm transaction
- 
