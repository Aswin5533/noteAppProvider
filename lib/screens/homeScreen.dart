import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_provider/providerClass/provider.dart';
import 'package:note_app_provider/screens/textScreen.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Listprovider>(
      builder:
          (context, ProviderList, child) => Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              child: Icon(CupertinoIcons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Textscreen()),
                );
              },
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Center(
                child: Text(
                  "Note App",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  StreamBuilder(
                    // wrap the grid view builder with stream builder
                    stream: ProviderList.notes,
                    // calling the stream name that in the provider list  class
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }
                      final docs = snapshot.data!.docs; // important
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: docs.length,
                        // now all the data inside the doc so calling the doc.length for length
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final doc = docs[index]; // adding an doc varibale
                          final data =
                              doc.data()
                                  as Map<
                                    String,
                                    dynamic
                                  >; // adding map to String,to change the data type of the doc.
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                              right: 10,
                              left: 10,
                            ),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 4,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['heading'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      // call the data and the wanted collection name
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      data['notes'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      // calling the collection name with data.
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => Textscreen(
                                                      docId: doc.id,
                                                      heading: data['heading'],
                                                      notes: data['notes'],
                                                    ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            ProviderList.deleteData(doc.id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
