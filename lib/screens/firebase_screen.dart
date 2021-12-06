import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseResults extends StatefulWidget {
  const FirebaseResults({Key? key}) : super(key: key);

  @override
  _FirebaseResultsState createState() => _FirebaseResultsState();
}

class _FirebaseResultsState extends State<FirebaseResults> {
  final Stream<QuerySnapshot> results =
      FirebaseFirestore.instance.collection('fbresults').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator history (cloud)'),
      ),
      body:
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: results,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Text('Loading');
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index){
                        return Text('${data.docs[index]['fbAddResult']} | ${data.docs[index]['fbSubtractResult']} | ${data.docs[index]['fbMultiplyResult']} | ${data.docs[index]['fbDivideResult']} | ${data.docs[index]['fbPowerResult']}');
                      },
                    );
              },
            ),
          ),


      bottomNavigationBar: BottomBar(),
    );
  }
}
