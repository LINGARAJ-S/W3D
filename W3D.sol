// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ERC20 {

    
  
    mapping(address => uint256) private _balance;
    

    string internal _name="W3Dev";
    string internal _symbol="W3D";
    
    uint256 internal _totalSupply;

    uint256 internal _transferamount=_totalSupply;

    event Transfer(address indexed from,address indexed to,uint amount);
    event fees(address indexed from,address indexed to,uint amount);

     constructor(uint totalsupply_){
       _totalSupply=totalsupply_*10**18;
       
        _balance[msg.sender]=_totalSupply;
        _transferamount=uint(_totalSupply)*10/100;
   }
  
     function name() public view  returns (string memory) {
        return _name;
    }

    function symbol() public view   returns (string memory) {
        return _symbol;
    }


    function pec_totalsupply() public view returns(uint256 ){
        
       return _transferamount;
   }
   
   function balance() public view returns(uint256){
       return _balance[msg.sender];
   }


    function totalsupply() public view returns(uint ){
       return _totalSupply;
   }

    function transfer(address to) public returns (bool) {
        
         address  feereciver=msg.sender;
        address payable feereciver_=payable(feereciver);
        
        uint fee=10000000000;
        uint256 sendbalance=_balance[msg.sender];
        require(sendbalance>= _transferamount , "insuffcient tokens");

        _balance[to]= _transferamount-fee;
        _balance[msg.sender] -=  _transferamount;

        _balance[feereciver_]+=fee;

        emit Transfer(msg.sender,to, _transferamount);
        emit fees(to,feereciver,fee);
        return true;
    }
}
