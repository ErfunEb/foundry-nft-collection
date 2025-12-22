# Makefile for Foundry NFT workflow
SAFE_JSON=script/deployments/basicNft.json


deploy:
	forge script ./script/DeployBasicNft.s.sol --rpc-url http://localhost:8545/ --account defaultKey --broadcast
	make copy-json


copy-json:
	@mkdir -p script/deployments
	@LATEST_JSON=$$(ls -t broadcast/DeployBasicNft.s.sol/31337/run-latest.json | head -n1); \
	cp "$$LATEST_JSON" $(SAFE_JSON); \
	echo "Copied $$LATEST_JSON to $(SAFE_JSON)"

mint:
	forge script .\script\Interactions.s.sol --rpc-url http://localhost:8545/ --broadcast --account defaultKey
