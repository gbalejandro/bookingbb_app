import 'package:flutter/material.dart';
import 'package:bookingbb_app/models/models.dart';

class ReservationCard extends StatelessWidget {

  final Reservation reservation;

  const ReservationCard({
    Key? key,
    required this.reservation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        margin: EdgeInsets.only( top: 25, bottom: 25 ),
        width: double.infinity,
        height: 200,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [

            _BackgroundImage( reservation.picture ),

            _ReservationDetails(
              title: reservation.name,
              subTitle: reservation.id!,
            ),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag( reservation.price )
            ),

            if( !reservation.available )
              Positioned(
                top: 0,
                left: 0,
                child: _NotAvailable()
              ),

          ],
        ),
      ),
    );
  }
  
  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _NotAvailable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 10 ),
          child: Text(
            'No disponible',
            style: TextStyle( color: Colors.white, fontSize: 20 ),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only( topLeft: Radius.circular(25), bottomRight: Radius.circular(25) )
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag( this.price );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric( horizontal: 8 ),
          child: Text('\$$price', style: TextStyle( color: Colors.white, fontSize: 15 )),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only( topRight: Radius.circular(25), bottomLeft: Radius.circular(25) )
      ),
    );
  }
}

class _ReservationDetails extends StatelessWidget {

  final String title;
  final String subTitle;

  const _ReservationDetails({
    required this.title,
    required this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only( right: 50 ),
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        width: double.infinity,
        height: 50,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [    
            Text(
              title,
              style: TextStyle( fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ), 
            Text(
              subTitle,
              style: TextStyle( fontSize: 10, color: Colors.white ),
            )    
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(25), topRight: Radius.circular(25) )
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage( this.url );
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 200,
        child: url == null
          ? Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
          )
          : FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
        ),
      ),
    );
  }
}