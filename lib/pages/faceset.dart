import 'dart:math'; // Importing random number generation library
import 'package:be5_cyc/pages/characterset.dart';
import 'package:be5_cyc/pages/save.dart'; // Import the Save page
import 'package:be5_cyc/utill/utill.dart';
import 'package:flutter/material.dart'; // Importing Flutter's Material design components
import 'package:be5_cyc/components/buttons/button_layout.dart'; // Importing custom button layout
import 'package:be5_cyc/components/menubar/drawer.dart'; // Importing custom drawer component

// Define a StatefulWidget named Faceset
class Faceset extends StatefulWidget {
  // Final variables to store the selected face, arm, and body
  final String selectedFace;
  final String selectedArm;
  final String selectedBody;

  // Lists to store paths for eye and mouth images
  final List<String> eyePaths = [
    'assets/images/front/eyes/eyes1.png',
    'assets/images/front/eyes/eyes2.png',
    'assets/images/front/eyes/eyes3.png',
    'assets/images/front/eyes/eyes4.png',
    'assets/images/front/eyes/eyes5.png',
    'assets/images/front/eyes/eyes6.png',
    'assets/images/front/eyes/eyes7.png',
    'assets/images/front/eyes/eyes8.png',
  ];

  final List<String> mouthPaths = [
    'assets/images/front/mouth/mouth1.png',
    'assets/images/front/mouth/mouth2.png',
    'assets/images/front/mouth/mouth3.png',
    'assets/images/front/mouth/mouth4.png',
    'assets/images/front/mouth/mouth5.png',
    'assets/images/front/mouth/mouth6.png',
    'assets/images/front/mouth/mouth7.png',
    'assets/images/front/mouth/mouth8.png',
  ];

  // Constructor to initialize selectedFace, selectedArm, and selectedBody
  Faceset({
    super.key,
    required this.selectedFace,
    required this.selectedArm,
    required this.selectedBody,
  });

  // Override the createState method to create the mutable state for this widget
  @override
  State<Faceset> createState() => _FacesetState();
}

// The state class for Faceset
class _FacesetState extends State<Faceset> {
  // Variables to store randomly selected image paths
  late List<String> selectedEyes;
  late List<String> selectedMouths;

  // Variables to store the current selected image paths
  String? selectedEye;
  String? selectedMouth;

  // Initialization method for the state
  @override
  void initState() {
    super.initState();
    selectRandomImages(); // Select random images when the widget is initialized
  }

  // Method to select random images and store them in lists
  void selectRandomImages() {
    final random = Random();

    // Shuffle the lists and take the first six images
    selectedEyes =
        (List<String>.from(widget.eyePaths)..shuffle(random)).take(6).toList();
    selectedMouths = (List<String>.from(widget.mouthPaths)..shuffle(random))
        .take(6)
        .toList();
  }

  // Method called when a box is selected
  void onBoxSelected(
    String eyePath,
    String mouthPath,
  ) {
    setState(() {
      selectedEye = eyePath;
      selectedMouth = mouthPath;
    });
  }

  // Widget to display a character part
  Widget buildCharacterPart(
    String eyePath,
    String mouthPath,
  ) {
    // Check if the current part is selected
    bool isSelected = selectedEye == eyePath && selectedMouth == mouthPath;

    return GestureDetector(
      onTap: () {
        // Change to selected state when the box is clicked
        onBoxSelected(eyePath, mouthPath);
      },
      child: Container(
        width: 140,
        height: 140,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(252, 218, 82, 1),
            width: 3, // Border thickness
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Display each part image
            Image.asset(widget.selectedBody,
                width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(widget.selectedArm,
                width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(widget.selectedFace,
                width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(eyePath, width: 100, height: 100, fit: BoxFit.cover),
            Image.asset(mouthPath, width: 100, height: 100, fit: BoxFit.cover),
            // Display a check icon if the part is selected
            if (isSelected)
              const Positioned(
                top: 5,
                right: 5,
                child: Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(252, 218, 82, 1),
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Method to create each row
  Widget buildRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCharacterPart(
          selectedEyes[index * 2],
          selectedMouths[index * 2],
        ),
        buildCharacterPart(
          selectedEyes[index * 2 + 1],
          selectedMouths[index * 2 + 1],
        ),
      ],
    );
  }

  // Build method to construct the widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    debugPrint("햄버거 버튼 클릭됨");
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
      ),
      endDrawer: DrawerApp(), // Drawer widget
      body: Padding(
        padding: const EdgeInsets.only(
          left: 38.0,
          right: 38.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              child: const SizedBox(
                child: Text(
                  '캐릭터 만들기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                // Loop to create a row for each half of the selected eyes list
                for (int i = 0; i < (selectedEyes.length / 2).floor(); i += 1)
                  buildRow(i),
              ],
            ),
            const SizedBox(height: 10),
            if (selectedEye != null && selectedMouth != null)
              ButtonLayout(
                buttonText: '완성하기',
                onPressed: () {
                  // Navigate to Save page with selected character
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Save(
                        selectedFace: widget.selectedFace,
                        selectedArm: widget.selectedArm,
                        selectedBody: widget.selectedBody,
                        selectedEye: selectedEye!,
                        selectedMouth: selectedMouth!,
                      ),
                    ),
                  );
                },
              ),
            const SizedBox(height: 10),
            // "Pick Again" button
            const SizedBox(height: 10),
            // "Refresh" button
            ButtonLayout(
              icon: Icons.refresh,
              buttonText: '표정 재생성',
              foregroundColor: Colors.red,
              border: true,
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  selectRandomImages(); // Re-select random images
                });
              },
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                moveToPage(context, CharacterSet());
              },
              child: const Text('처음부터'),
            )
          ],
        ),
      ),
    );
  }
}
