pragma solidity >= 0.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract FelixCoin is ERC20, AccessControl {

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address minter, string memory name, string memory symbol, uint supply) ERC20(name, symbol) {
        _mint(msg.sender, supply);
        _setupRole(MINTER_ROLE, minter);
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "ERROREEEEEEEE");
        _mint(to, amount);
    }
    
    function testingRole(address addr) public view virtual returns (bool) {
        return hasRole(MINTER_ROLE, addr);
    }
}
