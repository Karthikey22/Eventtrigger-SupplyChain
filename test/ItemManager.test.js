const  ItemManager  =  artifacts.require("./ItemManager.sol");

contract("ItemManager",  accounts  =>  {
it("...  should  let  you  create  new  Items.",  async  ()  =>  { 
const  itemManagerInstance  =  await  ItemManager.deployed();
const  itemName  =  "Sample test Product";
const  itemPrice  =  500;

const  result  =  await  itemManagerInstance.CreateItem(itemName,  itemPrice,  {  from:  accounts[0]  });
console.log(result);
assert.equal(result.logs[0].args._index,  0,  "There  should  be  one  item  index  in  there")
const  item  =  await  itemManagerInstance.items(0);
assert.equal(item._Identifier,  itemName,  "The  item  has  a  different  identifier");
});
});
