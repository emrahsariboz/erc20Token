pragma solidity ^0.8.10;

// Instead of writing IER20 interface, we could import openzeppelin interface.
// For learning purpose, we do this way!

interface IERC20 {
    // Returns the amount of tokens in existence.
    function totalSupply() external view returns (uint256);

    // Balance of specific address.
    function balanceOf(address account) external returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    // Allows owner to define spender to spend token of owner.
    function allowence(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);

    event Approval(
        address indexed owener,
        address indexed spender,
        uint256 amount
    );
}

contract EmrahToken is IERC20 {
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowence;

    string public name = "Test";
    string public symbol = "EMR";

    // How many decimals used to represent 1 EMR token == 18!
    uint256 public decimals = 18;

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowence[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        allowence[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint256 amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint256 amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
