// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ItemManager.sol";
contract Item{
    uint public Price;
    uint public AmountPaid;
    uint public Index;

    ItemManager Imcontract;

    constructor(uint _price,uint _index,ItemManager _Im){
        Price=_price;
        Index=_index;
        Imcontract=_Im;
    }
    receive()  external  payable  {
        require(msg.value  == Price,  "We  don't  support  partial  payments"); 
        require(AmountPaid  ==  0,  "Item  is  already  paid!");
        AmountPaid  +=  msg.value;
        (bool  success,  )  =  address(Imcontract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)", Index));
        require(success,  "Delivery  did  not  work");
    }

    fallback  ()  external  {

    }


}