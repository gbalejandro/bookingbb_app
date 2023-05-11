import 'package:bookingbb_app/models/models.dart';
import 'package:bookingbb_app/models/reservation.dart';
import 'package:bookingbb_app/screens/screens.dart';
import 'package:bookingbb_app/services/services.dart';
import 'package:bookingbb_app/widgets/reservation_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final reservationsService = Provider.of<ReservationsService>(context);

    if( reservationsService.isLoading ) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservaciones'),
      ),
      body: ListView.builder(
        itemCount: reservationsService.reservations.length,
        itemBuilder: ( BuildContext context, int index )  => GestureDetector(
          onTap: () {
            reservationsService.selectedReservation = reservationsService.reservations[index].copy();
            Navigator.pushNamed(context, 'reservation');
          },
          child: ReservationCard(
            reservation: reservationsService.reservations[index],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: () {

          reservationsService.selectedReservation = new Reservation(
            available: false, 
            name: '', 
            price: 0
          );
          Navigator.pushNamed(context, 'reservation');
        },
      ),
    );
  }

}