pragma solidity ^0.8.0;


contract SelfCheckIn  {

    mapping(string  => bool) userCheckedIn;
    mapping(string  => address) destination;
    mapping(string  => address) customer;
    mapping(string  => string) asset;

    constructor() {

    }

    function authenticateUsers(address user, address hotel, string memory  assetUri, string  memory reservationNumber) public
    {
        require(user != hotel, "User address is the same as hotel");
        require(reservationExists(reservationNumber) == true, "Reservation Already Exists");
        destination[reservationNumber] = hotel;
        customer[reservationNumber]=user;
        asset[reservationNumber]=assetUri;
        userCheckedIn[reservationNumber]=false;
    }

   function checkIn(address user, address hotel, string memory  reservationNumber)  public
      {
           require(reservationExists(reservationNumber) == true, "Reservation Already Exists");
           require(customer[reservationNumber] == user && destination[reservationNumber] == hotel , "Uncorrect destination or reservationNumber");
           require(!userCheckedIn[reservationNumber], "User has already checked in");
           userCheckedIn[reservationNumber] = true;

       }

   function isCheckedIn(string memory reservationNumber) public view returns (bool)
       {
           require(reservationExists(reservationNumber) == true, "Reservation Already Exists");
           return userCheckedIn[reservationNumber];

       }

   function getDestination(address user, string memory reservationNumber) public view returns (address)
      {
          require(reservationExists(reservationNumber) == true, "Reservation Already Exists");
          return destination[reservationNumber];
   }

   function getAsset(string memory reservationNumber) public view returns (string memory)
      {
    require(reservationExists(reservationNumber) == true, "Reservation Already Exists");
     return asset[reservationNumber];
     
   }

   function reservationExists(string memory reservationNumber) public view returns (bool){
       if(customer[reservationNumber] != address(0))
            return true; 
            else return false;
   }

}
