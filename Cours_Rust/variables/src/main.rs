fn main() {
    let x = 6; //variable non mutable
    println!("X = {}", x);
    
    let x = x + 1; //on peut modifier x car il s'appelle lui même

    { //masquage
        let x = x * 2; //On crée une nouvelle variabe x qui appelle la variable x
        println!("X = {}", x);
    }

    println!("X = {}", x);
}
