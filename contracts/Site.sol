pragma solidity >=0.5.8 <0.7.0;

contract Site {

  struct Art {
    // uint32 id;
    Artist artist;
    bool finished;
    int64 currentBidId; // -1 if none
  }

  struct Artist {
    // uint32 id;
    string name;
  }

  struct Bid {
    uint32 id;
    int64 lowerBidId; // if this outbids an older bid, otherwise -1
    uint amount;
    string request;
  }

  Artist[] artists;
  Art[] art;
  string testMessage;

  //mapping(uint => Art) public arts;
  //uint public artsCount;

  function addArtist (string memory _name) private {
    artists.push(Artist(_name));
  }

  function startArt (uint32 artistIndex) public {
    art.push(Art(artists[artistIndex], false, -1));
  }

  function getTestMessage() public view returns (string memory) {
    return testMessage;
  }

  constructor () public {
    addArtist ("Julia");
    addArtist ("Mei");
    startArt (0);
    startArt (1);
    testMessage = "A test has passed";
  }
}
