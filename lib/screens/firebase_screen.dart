import 'package:flutter/material.dart';
import 'bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseResults extends StatefulWidget {
  const FirebaseResults({Key? key}) : super(key: key);

  @override
  _FirebaseResultsState createState() => _FirebaseResultsState();
}

class _FirebaseResultsState extends State<FirebaseResults> {
  final Future<QuerySnapshot> results = FirebaseFirestore.instance.collection('fbresults').get();
  //FirebaseFirestore.instance.collection('fbresults').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator history (cloud)'),
      ),
      body:
          Container(
            child: FutureBuilder<QuerySnapshot>(
              future: results,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Text('Loading');
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index){
                        //return Text('${data.docs[index]['fbAddResult']} | ${data.docs[index]['fbSubtractResult']} | ${data.docs[index]['fbMultiplyResult']} | ${data.docs[index]['fbDivideResult']} | ${data.docs[index]['fbPowerResult']}');
                        return Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${data.docs[index]['fbAddResult']}'),
                            Text('${data.docs[index]['fbSubtractResult']}'),
                            Text('${data.docs[index]['fbMultiplyResult']}'),
                            Text('${data.docs[index]['fbDivideResult']}'),
                            Text('${data.docs[index]['fbPowerResult']}'),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),),
                          ],
                        );
                      },
                    );
              },
            ),
          ),


      bottomNavigationBar: BottomBar(),
    );
  }
}
