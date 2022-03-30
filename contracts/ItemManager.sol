// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./Item.sol";
import "./Ownable.sol";
contract ItemManager{

    enum ItemStatus{Created,Paid,Delivered}

    struct ItemList{
        Item item;
        string _Identifier;
        ItemManager.ItemStatus state;
    }
    event SupplyChainStep(uint _index,uint _step,address _address);
    mapping(uint=>ItemList)public items;
    uint Index;
    function CreateItem(string memory _Identifier,uint _ItemPrice)public {
        Item item=new Item(_ItemPrice,Index,this);
        items[Index].item=item;
        items[Index]._Identifier=_Identifier;
        items[Index].state=ItemStatus.Created;
        emit SupplyChainStep(Index,uint(ItemStatus.Created),address(item));
        Index++;
        
    }

    function TriggerPayment(uint _index)payable public {
        Item item=items[_index].item;
        require(address(item)==msg.sender,"Only  items  are  allowed  to  update  themselves");
        require(item.Price()==msg.value,"only full payment accepted");
        require(items[_index].state==ItemStatus.Created,"It is already paid");
        items[_index].state=ItemStatus.Paid;
        emit SupplyChainStep(_index,uint(ItemStatus.Paid),address(item));

    }
    function TriggerDelivery(uint _index)public{
        require(items[_index].state==ItemStatus.Paid,"Item is already delivered");
        items[_index].state=ItemStatus.Delivered;
        emit SupplyChainStep(_index,uint(ItemStatus.Delivered),address(items[_index].item));
    }
}

