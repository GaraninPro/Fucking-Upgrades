-include .env

deploy:
	forge script script/DeployBox.s.sol --rpc-url $(RPC2) --private-key $(KEY2) --broadcast --verify --etherscan-api-key $(SCAN) 

	
upgrade:
	forge script script/UpgradeBox.s.sol --rpc-url $(RPC2) --private-key $(KEY2) --broadcast --verify --etherscan-api-key $(SCAN) 
