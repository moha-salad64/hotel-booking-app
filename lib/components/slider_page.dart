import 'package:flutter/material.dart';

class SliderPage extends StatelessWidget {
  const SliderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Hotel Booking Online"),
      //   centerTitle: true,
      //   leading: Text("9:10" ,
      //   style: TextStyle(
      //     fontSize: 25,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   ),
      //   actions: [
      //     Icon(Icons.signal_cellular_0_bar_outlined),
      //     SizedBox(width: 5),
      //      Icon(Icons.wifi_outlined),
      //      SizedBox(width: 5),
      //     Icon(Icons.battery_charging_full_outlined),
      //   ],
      // ),

    body: ListView(
      children: [
        Container(
          width: double.infinity,
          height: 550,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/slider1.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          ),
          SizedBox(height: 45.0,),
        Container(
          child: Column(
            children: [
              Text("Booking Hotel as Online" , 
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800,
              ),),
              SizedBox(height: 20),
              Text('Booking the hotel you want without even visiting, all online!',
              style: TextStyle( fontSize: 17, fontWeight: FontWeight.w800
              ),),
            ],),
        ),       
        SizedBox(height: 30.0),
        Container(
          margin: EdgeInsets.only(left: 140.0 , right: 140.0),
          child:  ElevatedButton(onPressed: (){},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.only(
              top: 13, bottom: 13,
            ),
            backgroundColor: Color(0xff141C24),
          ),
         child: Text('Next', style: TextStyle(fontSize: 35 , color: Colors.white),)),
        ),
        SizedBox(height: 30.0),
        Container(
          margin: EdgeInsets.only( left: 150 , right: 150),
            child: Row(
            children: [
             Container(
              child: OutlinedButton(onPressed: (){}, 
              child: Text('slider 1')),
              ),

               
            ]
          ),  
        ),
        
        Container(
          child: Center(
            child: Column(
              children: [
                TextButton(onPressed: (){}, 
                child: Text('skip' ,
                style: TextStyle( fontSize: 17 , color: Color(0xff000957)),
                )
                ),
              ],
            ),
          ),
        )
        ],),
    );
  }
}
