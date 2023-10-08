use std::io;
use rand::Rng; //Il faut déclarer rand dans Cargo.toml
use std::cmp::Ordering; //Fonction standard qui permet d'ordonner les valeurs

fn main() {
    println!("Devinez le nombre !");

    let nombre_secret = rand::thread_rng().gen_range(1..101);

    loop {
        println!("Veuillez entrer un nombre.");

        let mut supposition = String::new(); //On crée la variable modifiable (mut) et 

        io::stdin()
            .read_line(&mut supposition)
            .expect("Échec de la lecture de l'entrée utilisateur");

        let supposition: u32 = match supposition.trim().parse() { //u32 est un nombre non signé de 32 bit
            Ok(nombre) => nombre, 
            Err(_) => continue, //Si on n'a pas de nombre, on continue (via la fonctionn Err)
        };
        //On peut réutiliser la variable 'supposition' car on redéclare la variable. 
        //trim() est une méthode qui supprime tous les espaces sur un String 

        println!("Votre nombre : {}", supposition);

        match supposition.cmp(&nombre_secret) {
            Ordering::Less => println!("C'est plus !"),
            Ordering::Greater => println!("C'est moins !"),
            Ordering::Equal => {
                println!("Vous avez gagné !");
                break;
            }
        }
    }

    println!("Le nombre secret est : {}", nombre_secret);

}

