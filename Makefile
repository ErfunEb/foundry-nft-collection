# Makefile for Foundry NFT workflow
-include .env
export

SAFE_JSON=script/deployments/basicNft.json

CHAIN_ID=31337
RPC_URL=http://localhost:8545/
KEY_NAME=$(ANVIL_KEY_NAME)

ifeq ($(SEPOLIA),true)
	CHAIN_ID=11155111
	RPC_URL=$(SEPOLIA_RPC_URL)
	KEY_NAME=$(SEPOLIA_KEY_NAME)
endif

BROADCAST_PATH=broadcast/DeployBasicNft.s.sol/$(CHAIN_ID)/run-latest.json


deploy-basic-nft:
	forge script ./script/DeployBasicNft.s.sol --rpc-url $(RPC_URL) --account $(KEY_NAME) --broadcast
	make copy-json

copy-json:
	@mkdir -p script/deployments
	@cp $(BROADCAST_PATH) $(SAFE_JSON)
	@echo "Copied $(BROADCAST_PATH) to $(SAFE_JSON)"

mint-basic-nft:
	forge script .\script\Interactions.s.sol --rpc-url $(RPC_URL) --account $(KEY_NAME) --broadcast

deploy-mood-nft:
	forge script ./script/DeployMoodNft.s.sol --rpc-url $(RPC_URL) --account $(KEY_NAME) --broadcast
