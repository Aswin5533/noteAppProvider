import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app_provider/providerClass/provider.dart';
import 'package:note_app_provider/screens/homeScreen.dart';
import 'package:provider/provider.dart';

class Textscreen extends StatelessWidget {
  final String? docId;
  final String? heading;
  final String? notes;

  const Textscreen({super.key, this.docId, this.heading, this.notes});

  @override
  Widget build(BuildContext context) {
    TextEditingController headingController = TextEditingController(
      text: heading ?? "",
    );
    TextEditingController noteController = TextEditingController(
      text: notes ?? "",
    );
    return Consumer<Listprovider>(
      builder:
          (context, ProviderList, child) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back, color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    String heading = headingController.text;
                    String notes = noteController.text;
                    if (docId != null) {
                      ProviderList.updateData(docId!, heading, notes);
                    } else {
                      ProviderList.saveNotes(heading, notes);
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  },
                  icon: Icon(Icons.check, color: Colors.white),
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: headingController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Heading",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: noteController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Notes",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
