pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SelfCheckIn is Ownable {

    mapping(string  => bool) userCheckedIn;
    mapping(string  => address) destination;
    mapping(string  => address) customer;
    mapping(string  => string) asset;

    constructor() {

    }

    function authenticateUsers(address user, address hotel, string memory  assetUri, string  memory reservationNumber) public onlyOwner 
    {
        require(user != hotel, "User address is the same as hotel");
        destination[reservationNumber] = hotel;
        customer[reservationNumber]=user;
        asset[reservationNumber]=assetUri;
        userCheckedIn[reservationNumber]=false;
    }

   function checkIn(address user, address hotel, string memory  reservationNumber) public onlyOwner ()
      {
           require(customer[reservationNumber] == user && destination[reservationNumber] == hotel , "Uncorrect destination or reservationNumber");
           require(!userCheckedIn[reservationNumber], "User has already checked in");
           userCheckedIn[reservationNumber] = true;

       }

   function isCheckedIn(address user, address hotel, string memory reservationNumber) public view returns (bool)
       {
           require(customer[reservationNumber] == user && destination[reservationNumber] == hotel , "Uncorrect destination or reservationNumber");
           return userCheckedIn[reservationNumber];

       }

   function getDestination(address user, address hotel, string memory reservationNumber) public view returns (address)
      {
          require(customer[reservationNumber] == user && destination[reservationNumber] == hotel , "Uncorrect destination or reservationNumber");
          return destination[reservationNumber];
   }

   function getAsset(address user, address hotel, string memory reservationNumber) public view returns (string memory){
      
     require(customer[reservationNumber] == user && destination[reservationNumber] == hotel , "Uncorrect destination or reservationNumber");
     return asset[reservationNumber];
     
   }

}
