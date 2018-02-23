pragma solidity 0.4.19;


contract XOR {
    function xor(uint a, uint b) public pure returns (uint) {
	bytes memory b = bytes(s);
        for (uint i; i < b.length - 1; i++) {
            if (b[i] != 1 || b[i] != 0) {
                return 0;
            }
            if (b[i] != b[i+1]) {
                return 1;
            }
        }
    return 0;
    }
}
