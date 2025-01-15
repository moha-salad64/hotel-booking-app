import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffA6CDC6),
    body: ListView(
      children: [
        Expanded(
         child:  Container(
          width: double.infinity,
          height: 550,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/slider3.jpeg'),
            fit: BoxFit.cover,
            ),
          ),
          ),
        ),
        SizedBox(height: 45.0,),
          Container(
          child: Column(
            children: [
              Text("Booking Hotel as Online" , 
              style: GoogleFonts.acme(fontSize: 40, fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text('Booking the hotel you want without even visiting, all online!',
              style: GoogleFonts.acme( 
                fontSize: 18, fontWeight: FontWeight.w800
              ),
              ),
            ],),
        ),       
        SizedBox(height: 60.0),
        Container(
          margin: EdgeInsets.only(left: 60.0 , right: 60.0),
          child:  ElevatedButton(onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 10, horizontal: 80
            )
          ),
         child: Text('Next', 
         style: GoogleFonts.acme(
          fontSize: 35 , 
          fontWeight:FontWeight.w500 ,
           color: Colors.white),)),
        ),
        SizedBox(height: 40.0),
        Container(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDot(true),
                buildDot(false),
                buildDot(false),
              ],
            ),
          ),
          ),  
        SizedBox(height:20.0),
        Container(
          child: Center(
            child: Column(
              children: [
                TextButton(onPressed: (){
                  
                }, 
                child: Text('skip' ,
                style: GoogleFonts.acme( fontSize: 17 , color: Color(0xff000957)),
                )
                ),
              ],
            ),
          ),
        )
        ],),
    );
  }
  
  Widget buildDot(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade800 : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
