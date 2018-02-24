pragma solidity ^0.4.19;
import "github.com/Arachnid/solidity-stringutils/strings.sol";
 
contract Concatenate {
    function concatWithoutImport(string _s, string _t) public returns (string) {
        uint lengths=bytes(_s).length+bytes(_t).length+1;
        bytes memory val = new bytes(lengths);
        for (uint256 i = 0;i<bytes(_s).length;i++){
            val[i]=bytes(_s)[i];
        }
        for (uint256 j = 0;j<bytes(_t).length;j++){
            val[bytes(_s).length+j]=bytes(_t)[j];
        }
        return string(val);
    }

    /* BONUS */
    function concatWithImport(string s, string t) public returns (string) {
	/*s = s.toSlice().concat(t.toSlice());
       return s;*/
    }
}
