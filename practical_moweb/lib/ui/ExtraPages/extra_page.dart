import 'package:flutter/material.dart';

class ExtraPage extends StatefulWidget {
  const ExtraPage({Key? key}) : super(key: key);

  @override
  State<ExtraPage> createState() => _ExtraPageState();
}

class _ExtraPageState extends State<ExtraPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined, color: Colors.white))
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.cyan,
              height: MediaQuery.of(context).size.height / 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Aortic Valve Replacement",
                        style: TextStyle(color: Colors.white, fontSize: 22)),
                    SizedBox(height: 10),
                    Text("Shared by Fua Lamba on 1 July 2021",
                        style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridTile(
                    child: Column(
                  children: const [
                    Icon(Icons.assignment_outlined,
                        size: 100, color: Colors.blueGrey),
                    Text("Preparation",
                        style: TextStyle(color: Colors.black, fontSize: 20))
                  ],
                )),
                GridTile(
                    child: Column(
                  children: const [
                    Icon(Icons.local_hospital_outlined,
                        size: 100, color: Colors.red),
                    Text("Operation Room",
                        style: TextStyle(color: Colors.black, fontSize: 20))
                  ],
                ))
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(color: Colors.orange, width: 3)),
              child: GridTile(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.view_week_outlined,
                      size: 70, color: Colors.red),
                  Text("Equipment",
                      style: TextStyle(color: Colors.black, fontSize: 18))
                ],
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GridTile(
                    child: Column(
                  children: const [
                    Icon(Icons.bed, size: 100, color: Colors.blueAccent),
                    Text("Patient \npositioning",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20))
                  ],
                )),
                GridTile(
                    child: Column(
                  children: const [
                    Icon(Icons.speaker_notes_outlined,
                        size: 100, color: Colors.deepOrangeAccent),
                    Text("Notes",
                        style: TextStyle(color: Colors.black, fontSize: 20))
                  ],
                ))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.cyan,
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                  child: Center(
                    child: Text("Surgeons",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
