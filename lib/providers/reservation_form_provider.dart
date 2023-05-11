import 'package:flutter/material.dart';
import 'package:bookingbb_app/models/models.dart';

class ReservationFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Reservation reservation;

  ReservationFormProvider( this.reservation );

  updateAvailability( bool value ) {
    print(value);
    this.reservation.available = value;
    notifyListeners();
  }

  bool isValidForm() {

    print( reservation.name );
    print( reservation.price );
    print( reservation.available );

    return formKey.currentState?.validate() ?? false;
  }
}