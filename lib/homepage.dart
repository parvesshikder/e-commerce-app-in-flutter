import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Future greenAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Done'),
            content: const Text(
              '✓ Purchased Successfully (Cash On Delivery)',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

    Future shippingAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Enter Shipping Details'),
            content: Container(
              height: 150,
              child: Column(
                children: [
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blue,
                child: const Text('Done'),
                onPressed: () {
                  Navigator.pop(context);
                  greenAlertDialog(context);
                  
                },
              ),
            ],
          );
        });
  }
  
  final db = FirebaseFirestore.instance;

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {

 

    return Scaffold(
      appBar: AppBar(
        title: Text('AFK Mart'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _signOut();
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(  // for list view items function
        stream: db.collection('product').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else
            // ignore: curly_braces_in_flow_control_structures
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(doc.get('image')),
                        title: Text(doc.get('title')),
                        trailing: TextButton(
                          onPressed: () {},
                          child: GestureDetector(
                            child: Text("Buy Now",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue)),
                            onTap: () async {
                              shippingAlertDialog(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        },
      ),
    );
  }
}
