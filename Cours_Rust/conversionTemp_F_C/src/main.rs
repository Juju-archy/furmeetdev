use std::io;

fn main() {
    println!("Bienvenue sur le convertisseur C° / F° !");

    loop{
        println!("Quelle est la température à convertir :");

        let mut x = String::new();
    
        io::stdin()
                .read_line(&mut x)
                .expect("Échec de la lecture de l'entrée utilisateur");
        let x: f64 = match x.trim().parse() { 
            Ok(nombre) => nombre, 
            Err(_) => continue, 
        };

        loop{
            println!("Voulez-vous convertir vers les degrés celsius ou les degrés farhenheit : (C/F)");
            let mut conv = String::new();
            io::stdin()
                .read_line(&mut conv)
                .expect("Echec de la lecture de l'entrée utilisateur");

            if  conv.contains("c") {
                conversionFtoC(x);
                break;
            } else if conv.contains("f") {
                conversionCtoF(x);
                break;
            } else {
                continue;
            }
        }
        
        break;
    }
    
}

fn conversionCtoF (x: f64) {
    let convf = x * (9.0 / 5.0) + 32.0;
    println!("{}°C = {}°F", x, convf);
}

fn conversionFtoC (x: f64) {
    let convc = (x - 32.0) * (5.0 / 9.0);
    println!("{}°F = {}°C", x, convc);
}