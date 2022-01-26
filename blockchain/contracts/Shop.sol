// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Shop {
    struct Product {
        string userId;
        string productName;
        string price;
        uint quantity;
        uint index;
    }
    uint currentIndex;
    
    mapping(uint => Product) public products;
    address[] private userIndex;
    
    constructor() public {
        currentIndex = 0;
    }
    
    function newProduct(
        //bytes32 index,
       // address userAddress,
        string memory userId,
        string memory productName,
        string memory price,
        uint quantity
    ) public returns(bool success) {
        //if (!userId || !productName || !price || !quantity) return false;
        products[currentIndex] = Product(userId, productName, price, quantity, currentIndex);
         currentIndex += 1;
        return true;
    }
    
    function getProductByName(string memory _name) public view returns (string memory userId, string memory productName, string memory price, uint quantity) {
        for (uint i = 0; i < currentIndex; i++) {
            if (keccak256(bytes(products[i].productName)) == keccak256(bytes(_name))){
                return (products[i].userId, products[i].productName, products[i].price, products[i].quantity);
            }
        }
    }
    function getProductsByUser(string memory _userId) public view returns (string memory userId, string memory productName, string memory price, uint quantity) {
        for (uint i = 0; i < currentIndex; i++) {
            if (keccak256(bytes(products[i].userId)) == keccak256(bytes(_userId))){
                return (products[i].userId, products[i].productName, products[i].price, products[i].quantity);
            }
        }
    }
    function deleteProduct(uint index) public {
        delete products[index];
    }
    
}