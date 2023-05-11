
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bookingbb_app/models/models.dart';
import 'package:http/http.dart' as http;

class ReservationsService extends ChangeNotifier {

  final String _baseUrl = 'bookingbb-14d59-default-rtdb.firebaseio.com' ;
  final List<Reservation> reservations = []; 
  late Reservation selectedReservation;

  bool isLoading = true;
  bool isSaving = false;

  ReservationsService() {
    this.loadReservations();
  }

  Future<List<Reservation>> loadReservations() async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'reservations.json');
    final resp = await http.get( url );

    final Map<String, dynamic> reservationsMap = json.decode( resp.body );

    reservationsMap.forEach((key, value) { 
      final tempReservation = Reservation.fromMap( value );
      tempReservation.id = key;
      reservations.add( tempReservation );
    });

    isLoading = false;
    notifyListeners();

    return reservations;

  }

  Future saveOrCreateReservation( Reservation reservation ) async {
    isSaving = true;
    notifyListeners();

    if ( reservation.id == null ) {
      // Es necesaro crear
      await this.createReservation( reservation );
    } else {
      // Actualizar
      await this.updateReservation(reservation);
    }

    isSaving = false;
    notifyListeners();

  }

  Future<String> updateReservation( Reservation reservation ) async {

    final url = Uri.https(_baseUrl, 'reservations/${ reservation.id }.json');
    final resp = await http.put( url, body: reservation.toJson() );
    final decodedData = resp.body;

    final index = reservations.indexWhere((element) => element.id == reservation.id );
    reservations[index] = reservation;

    return reservation.id!;
  }

  Future<String> createReservation( Reservation reservation ) async {

    final url = Uri.https( _baseUrl, 'products.json');
    final resp = await http.post( url, body: reservation.toJson() );
    final decodedData = json.decode( resp.body );

    reservation.id = decodedData['name'];

    reservations.add(reservation);
    

    return reservation.id!;

  }

}