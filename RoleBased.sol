

pragma solidity 0.8.6;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControl.sol";
contract rolebased is AccessControl{
    bytes32 public constant admin = keccak256("admin");
    bytes32 public constant user = keccak256("user");
    
    mapping(address=>uint)balances;
    
    constructor() public {
        _setupRole(admin,msg.sender);
    }
    
    function deposit() public payable{
        if(!(hasRole(admin,msg.sender))){
            _setupRole(user,msg.sender);
        }
        balances[msg.sender]=balances[msg.sender]+msg.value;
    }
    function withdrawl(uint amount) public payable{
        require(hasRole(user,msg.sender),"Needs to be an user of the bank");
        require(balances[msg.sender]>=amount);
        msg.sender.transfer(amount);

    }
    
    function kill() public{
        require(hasRole(admin,msg.sender),"Not an admin");
        selfdestruct(msg.sender);
    }
    
    
}
