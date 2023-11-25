import 'package:flutter/material.dart';

/// Fonction pour créer un texte avec des styles personnalisés
Text textWithStyle(String data, {color = Colors.white, fontSize = 20.0, fontStyle = FontStyle.italic, textAlign = TextAlign.center}) {
  return Text(
    data,
    textAlign: textAlign,
    style: TextStyle(
      color: color,
      fontStyle: fontStyle,
      fontSize: fontSize,
    ),
  );
}

Padding padding(double top){
  return Padding(padding: EdgeInsets.only(top: top));
}

