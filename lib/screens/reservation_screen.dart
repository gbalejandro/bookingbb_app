
import 'package:bookingbb_app/providers/reservation_form_provider.dart';
import 'package:bookingbb_app/services/services.dart';
import 'package:bookingbb_app/ui/input_decorations.dart';
import 'package:bookingbb_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final reservationService = Provider.of<ReservationsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ReservationFormProvider( reservationService.selectedReservation ),
      child: _ReservationScreenBody(reservationService: reservationService),
    );
    
  }
}

class _ReservationScreenBody extends StatelessWidget {
  const _ReservationScreenBody({
    Key? key,
    required this.reservationService,
  }) : super(key: key);

  final ReservationsService reservationService;

  @override
  Widget build(BuildContext context) {

    final reservationForm = Provider.of<ReservationFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        //keyboardDismissBehavior:ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [

            Stack(
              children: [
                ReservationImage( url: reservationService.selectedReservation.picture ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon( Icons.arrow_back_ios_new, size: 30, color: Colors.white )
                  )
                ),

                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      //final picker = new ImagePicker();
                    },
                    icon: Icon( Icons.camera_alt_outlined, size: 30, color: Colors.white )
                  )
                )
              ],
            ),

            _ReservationForm(),

            SizedBox( height: 100 ),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.save_as_outlined ),
        onPressed: () async {

          if ( !reservationForm.isValidForm() ) return;

          await reservationService.saveOrCreateReservation(reservationForm.reservation);
        },
      ),
    );
  }
}

class _ReservationForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final reservationForm = Provider.of<ReservationFormProvider>(context);
    final reservation = reservationForm.reservation;

    return Padding(
      padding: EdgeInsets.symmetric( horizontal: 10 ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 250,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: reservationForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              SizedBox( height: 10 ),

              TextFormField(
                initialValue: reservation.name,
                onChanged: ( value ) => reservation.name = value,
                validator: ( value ) {
                  if ( value == null || value.length < 1 )
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre de Reservación',
                  labelText: 'Nombre:'
                ),
              ),

              SizedBox( height: 10 ),

              TextFormField(
                initialValue: '${reservation.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: ( value ) {
                  if ( double.tryParse(value) == null) {
                    reservation.price = 0;
                  } else {
                    reservation.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio por noche:'
                ),
              ),

              SizedBox( height: 10 ),

              SwitchListTile.adaptive(
                value: reservation.available, 
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: reservationForm.updateAvailability
              ),

              SizedBox( height: 20 )
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}