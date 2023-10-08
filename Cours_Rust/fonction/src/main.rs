use std::io;

fn main() {
    loop{
        println!("Veuillez noter un nombre : ");
        let mut x = String::new();
    
        io::stdin()
                .read_line(&mut x)
                .expect("Échec de la lecture de l'entrée utilisateur");
    
        let x: u32 = match x.trim().parse() { 
            Ok(nombre) => nombre, 
            Err(_) => continue, 
        };

        carre(x);
        break;
    }
}

fn carre(x: u32) {
    println!("Le carré de X = {}", x*x);
}
