import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/**
 * La classe MapaScreen es una classe StatefulWidget encarregada de mostrar el mapa de google maps
 */

///
class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

/**
 * Aquesta pagina el que conte és a la part superior conte una AppBar indicant el nom de Mapa on també hi ha un botó per a
 * retornar a la posicio indicada per el scan, seguidament dins el body conté el  widget GoogleMap que ens permetrà veure'l mapa i els controls per poder moure, a
 * la part inferior esquera hi ha un boto que cirda el métode _toggleMapType per a alternar el tipus de mapa
 */

///
class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType _mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition puntinIcial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50,
    );

    Set<Marker> markers = {
      Marker(markerId: const MarkerId('idi1'), position: scan.getLatLng())
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_pin),
            onPressed: () {
              _moveToCurrentLocation(scan);
            },
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        mapType: _mapType,
        markers: markers,
        initialCameraPosition: puntinIcial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            _toggleMapType();
          },
          backgroundColor: Colors.white,
          child: const Icon(Icons.layers),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
    );
  }

  /**
   * El métode _toggleMapType s'encarrega d'alternar el tipus de mapa entre hybrid i normal depenent de si s'esta mostran un o un altre
   */

  ///
  void _toggleMapType() {
    setState(() {
      _mapType = (_mapType == MapType.normal) ? MapType.hybrid : MapType.normal;
    });
  }

  /**
   * El métode _moveToCurrentLocation rep per parametre l'objecte scan i fa retornar a la posicio introduïda per l'escanner utilitzant CameraUpadate
   */

  ///
  void _moveToCurrentLocation(scan) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(scan.getLatLng()));
  }
}
