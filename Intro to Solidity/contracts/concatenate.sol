pragma solidity 0.4.19;
import "github.com/Arachnid/solidity-stringutils/strings.sol";

contract Concatenate {
    function concatWithoutImport(string _s, string _t) public returns (string) {
    }

    /* BONUS */
    function concatWithImport(string s, string t) public returns (string) {
	s = s1.toSlice().concat(s2.toSlice());
        return s;
    }
}
