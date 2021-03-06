<!doctype html>
<html>
<head>

<script
    src="https://code.jquery.com/jquery-2.2.4.js"
    integrity="sha256-iT6Q9iMJYuQiMWNd9lDyBUStIq/8PuOW33aOqmvFpqI="
    crossorigin="anonymous"></script>

<!-- have to use web3 0.20 (the same version as the one used in remix.  using web3 0.18 doesn't work. -->
<script src="web3.min.js"></script>
</head>

<body>

<button id="btnMint">mint</button>
<br/>
<button id="btnTransfer">transfer</button>
<br/>
<button id="btnBalance">read balance</button>
<br/>
<p>it may take sometime after transfer for the balance to show up.</p>

</body>

<script>
    

        if (typeof web3 !== 'undefined') {
          console.log("web3 already defined");
            web3 = new Web3(web3.currentProvider);
        } else {
            // set the provider you want from Web3.providers
            console.log("new web3");
            //web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        }
        
        //web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        //web3 = new Web3(new Web3.providers.HttpProvider("https://sokol.poa.network"));
        
        
        web3.eth.defaultAccount = web3.eth.accounts[0];
        var defaultAccount = web3.eth.accounts[0];
        console.log("default account: ", defaultAccount);
        
        
        var abi = [
                {
                "constant": true,
                "inputs": [
                  {
                    "name": "_owner",
                    "type": "address"
                  }
                ],
                "name": "tokensOf",
                "outputs": [
                  {
                    "name": "",
                    "type": "uint256[]"
                  }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "approvedFor",
                "outputs": [
                  {
                    "name": "",
                    "type": "address"
                  }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "ownerOf",
                "outputs": [
                  {
                    "name": "",
                    "type": "address"
                  }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [],
                "name": "totalSupply",
                "outputs": [
                  {
                    "name": "",
                    "type": "uint256"
                  }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": true,
                "inputs": [
                  {
                    "name": "_owner",
                    "type": "address"
                  }
                ],
                "name": "balanceOf",
                "outputs": [
                  {
                    "name": "",
                    "type": "uint256"
                  }
                ],
                "payable": false,
                "stateMutability": "view",
                "type": "function"
              },
              {
                "constant": false,
                "inputs": [
                  {
                    "name": "_to",
                    "type": "address"
                  },
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "mint",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "anonymous": false,
                "inputs": [
                  {
                    "indexed": true,
                    "name": "_owner",
                    "type": "address"
                  },
                  {
                    "indexed": true,
                    "name": "_approved",
                    "type": "address"
                  },
                  {
                    "indexed": false,
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "Approval",
                "type": "event"
              },
              {
                "constant": false,
                "inputs": [
                  {
                    "name": "_to",
                    "type": "address"
                  },
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "transfer",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "anonymous": false,
                "inputs": [
                  {
                    "indexed": true,
                    "name": "_from",
                    "type": "address"
                  },
                  {
                    "indexed": true,
                    "name": "_to",
                    "type": "address"
                  },
                  {
                    "indexed": false,
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "Transfer",
                "type": "event"
              },
              {
                "constant": false,
                "inputs": [
                  {
                    "name": "_to",
                    "type": "address"
                  },
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "approve",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              },
              {
                "constant": false,
                "inputs": [
                  {
                    "name": "_tokenId",
                    "type": "uint256"
                  }
                ],
                "name": "takeOwnership",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
              }
            ];
        
        
        var contractAddr = "0x4e14360b7dfbf6bbf97fd773983bd3ce5020111e";
        
        var erc721Contract = web3.eth.contract(abi);
        var erc721 = erc721Contract.at(contractAddr);
        console.log(erc721);

        
        var fromAddr = "0xDb7B6029B531Be675733DeC2AA5554Ca457BD6F6";
        var toAddr = "0x19eD4B1F0EF47306a72ea5A093e7F73a8d70F359";
        
        var tokenId = 2;
        $("#btnMint").click(function() {
          erc721.mint(fromAddr, tokenId++, function(error, result){
            if(!error) {
                    console.log(result);
                } else {
                    console.error(error);
                }
          });
        })
        
        $("#btnTransfer").click(function() {
          
          // does not work until a later time (presumably has to wait until all elements loaded).
          erc721.transfer(toAddr, tokenId, function(error, result){
              if(!error) {
                    console.log(result);
                } else {
                    console.error(error);
                }
              
              
            });
            
        });
        
        
        function readBalance(contract, addr) {
          contract.balanceOf(addr, function(error, result){
                if(!error) {
                    console.log(result);
                    console.log("balance=" + result.c[0]);
                } else {
                    console.error(error);
                }
            });
        }
        
        $("#btnBalance").click(function() {
          readBalance(erc721, toAddr);
        })
/*      
var greeterContract = new web3.eth.contract([{"constant":true,"inputs":[],"name":"getData","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_data","type":"string"}],"name":"setData","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]);
var greeter = greeterContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff160217905550610394806100536000396000f300606060405260043610610057576000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff1680633bc5de301461005c57806341c0e1b5146100ea57806347064d6a146100ff575b600080fd5b341561006757600080fd5b61006f61015c565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100af578082015181840152602081019050610094565b50505050905090810190601f1680156100dc5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b34156100f557600080fd5b6100fd610204565b005b341561010a57600080fd5b61015a600480803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091905050610295565b005b6101646102af565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156101fa5780601f106101cf576101008083540402835291602001916101fa565b820191906000526020600020905b8154815290600101906020018083116101dd57829003601f168201915b5050505050905090565b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff161415610293576000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b565b80600190805190602001906102ab9291906102c3565b5050565b602060405190810160405280600081525090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061030457805160ff1916838001178555610332565b82800160010185558215610332579182015b82811115610331578251825591602001919060010190610316565b5b50905061033f9190610343565b5090565b61036591905b80821115610361576000816000905550600101610349565b5090565b905600a165627a7a723058200972152f185a84c6c2bca5835ef47939de16aa9635efdfcc33a7746ad3356f430029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
*/
        
        
/*        
        
        //web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        abi = JSON.parse('[{"constant":false,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"totalVotesFor","outputs":[{"name":"","type":"uint8"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"validCandidate","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"bytes32"}],"name":"votesReceived","outputs":[{"name":"","type":"uint8"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"x","type":"bytes32"}],"name":"bytes32ToString","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"candidateList","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"candidate","type":"bytes32"}],"name":"voteForCandidate","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"contractOwner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"inputs":[{"name":"candidateNames","type":"bytes32[]"}],"payable":false,"type":"constructor"}]')
        VotingContract = web3.eth.contract(abi);
        // In your nodejs console, execute contractInstance.address to get the address at which the contract is deployed and change the line below to use your deployed address
        contractInstance = VotingContract.at('0x2a9c1d265d06d47e8f7b00ffa987c9185aecf672');
        candidates = {"Rama": "candidate-1", "Nick": "candidate-2", "Jose": "candidate-3"}

        function voteForCandidate() {
          candidateName = $("#candidate").val();
          contractInstance.voteForCandidate(candidateName, {from: web3.eth.accounts[0]}, function() {
            let div_id = candidates[candidateName];
            $("#" + div_id).html(contractInstance.totalVotesFor.call(candidateName).toString());
          });
        }

        $(document).ready(function() {
          candidateNames = Object.keys(candidates);
          for (var i = 0; i < candidateNames.length; i++) {
            let name = candidateNames[i];
            let val = contractInstance.totalVotesFor.call(name).toString()
            $("#" + candidates[name]).html(val);
          }
        });
*/        
        
</script>


</html>
