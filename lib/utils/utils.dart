import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

/**
 * El métode launchURL rep per parametre el contexte i el scan realitzat on primer crea una variable amb
 * el nom de url on li vica el valor de scan, de manera que comprova si el tipus de scan es http, si ho es
 * comprova si pot accedir  a la URL i en cas afirmatiu llança la URL al navegador web, si no es 'https'
 * abm el navigator accedeix a la pagina nombrada com a mapa, pasantli com a arguments l'objecte scan
 */

///
void launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipus == 'http') {
    // ignore: deprecated_member_use
    if (!await launch(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
