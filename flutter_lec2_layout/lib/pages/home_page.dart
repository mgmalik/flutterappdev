import 'package:flutter/material.dart';
import 'package:flutter_lec2_layout/widgets/bordered_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Layout App'),
      ),

      /** 1st version of the code where we are not applying any layout on bordered image*/
      // body: BorderedImage(),

      /** 2nd version of the code where we are applying a Center single-child layout
       * where bordered image comes to center of page
      */
      // body: Center(child: BorderedImage()),

      /** 3rd verion: adding mulipe BorderedImage in the Column layout widget */
      // body: Column(
      //   children: [
      //     BorderedImage(),
      //     BorderedImage(),
      //     BorderedImage(),
      //     BorderedImage(),
      //   ],
      // ),

      /** 4th version: multiple BorderedImage widgets in the Column layout widget
       * are enclosed in the Center layout widget.
       */
      // body: Center(
      //   child: Column(
      //     children: [
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //     ],
      //   ),
      // ),

      /** 5th verion: adding mulipe BorderedImage in the Row layout widget  */
      // body: Row(
      //   children: [
      //     BorderedImage(),
      //     BorderedImage(),
      //     BorderedImage(),
      //   ],
      // ),

      /** 6th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Center layout widget.
       */
      // body: Center(
      //   child: Row(
      //     children: [
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //     ],
      //   ),
      // ),

      /** 7th version: multiple BorderedImage widgets in the Column layout widget
       * are enclosed in the Center layout widget with mainAxisAlignment property.
       */
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //     ],
      //   ),
      // ),

      /** 8th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Center layout widget with mainAxisAlignment property.
       */
      // body: Center(
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //     ],
      //   ),
      // ),

      /** 9th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Container layout widget with height set to full height
       * of the page with both mainAxisAlignment and crossAxisAlignment properties.
       */
      // body: Container(
      //   margin: EdgeInsets.all(8.0),
      //   padding: EdgeInsets.all(8.0),
      //   height: MediaQuery.of(context).size.height,
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.blue, width: 2.0),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [BorderedImage(), BorderedImage(), BorderedImage()],
      //   ),
      // ),

      /** 10th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Container layout widget with height set to full height
       * of the page with both mainAxisAlignment and crossAxisAlignment properties.
       * Here images overflow from the right side of the screen
       */
      // body: Container(
      //   margin: EdgeInsets.all(8.0),
      //   padding: EdgeInsets.all(8.0),
      //   height: MediaQuery.of(context).size.height,
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.blue, width: 2.0),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //       BorderedImage(),
      //     ],
      //   ),
      // ),

      /** 11th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Container layout widget with height set to full height
       * of the page with both mainAxisAlignment and crossAxisAlignment properties.
       * Here images overflow from the right side of the screen.
       * Solving the overflow problem with Expanded layout widget
       */
      // body: Container(
      //   margin: EdgeInsets.all(8.0),
      //   padding: EdgeInsets.all(8.0),
      //   height: MediaQuery.of(context).size.height,
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.blue, width: 2.0),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //     ],
      //   ),
      // ),

      /** 12th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Container layout widget with height set to full height
       * of the page with both mainAxisAlignment and crossAxisAlignment properties.
       * Here images overflow from the right side of the screen.
       * Solving the overflow problem with Expanded layout widget with flex property
       */
      // body: Container(
      //   margin: EdgeInsets.all(8.0),
      //   padding: EdgeInsets.all(8.0),
      //   height: MediaQuery.of(context).size.height,
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.blue, width: 2.0),
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Expanded(child: BorderedImage()),
      //       Expanded(flex: 3, child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //       Expanded(child: BorderedImage()),
      //     ],
      //   ),
      // ),

      /** 13th version: multiple BorderedImage widgets in the Row layout widget
       * are enclosed in the Container layout widget with height set to full height
       * of the page with both mainAxisAlignment and crossAxisAlignment properties.
       * Here images overflow from the right side of the screen.
       * Solving the overflow problem with ScrollView layout widget
       */
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BorderedImage(),
              BorderedImage(),
              BorderedImage(),
              BorderedImage(),
              BorderedImage(),
              BorderedImage(),
              BorderedImage(),
            ],
          ),
        ),
      ),
    );
  }
}
