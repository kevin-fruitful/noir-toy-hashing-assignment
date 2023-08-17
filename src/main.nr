use dep::std::slice;

global PRIME: u32 = 16777619;
global HASH_VALUE: u32 = 0x811C9DC5;

fn main(value: u32, hash_value: pub u32){
    let calculated_hash_value = calculate_hash(value);

    assert(calculated_hash_value == hash_value);
}

fn calculate_hash(num: u32) -> u32 {
    let mut bytes: [u8; 4] = u32_to_u8(num);

    let mut product: u32 = 0;
    let mut hash_value: u32 = HASH_VALUE;
    
    let mut reconstructed_num: u32 = 0;
    for i in 0..4 {
        reconstructed_num += (bytes[i] as u32 << (24 - (8 * i)));
        
        product = hash_value * PRIME;
        hash_value = product ^ bytes[i] as u32;

    }
    assert(num == reconstructed_num);
    hash_value
}

unconstrained fn u32_to_u8(num: u32) -> [u8; 4] {
    let mut out: [u8; 4] = [0; 4];
    for i in 0..4 {
        out[i] = (num >> (24 - (i * 8))) as u8;
    }
    out
}

#[test]
fn test_1() {
    let num = 127561628;
    let hash = calculate_hash(num);
    
    assert(hash == 0x71233de7);
}

#[test]
fn test_2() {
    let num = 237261828;
    let hash = calculate_hash(num);

    assert(hash == 0x7F51D567);
}

#[test]
fn test_3() {
    let num = 596214892;
    let hash = calculate_hash(num);

    assert(hash == 0x3F0C8995);
}
