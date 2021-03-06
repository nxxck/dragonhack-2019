import 'dart:io';

import 'package:flutter/material.dart';

import 'widgets/plant_details.dart';

typedef Future<Map<String, dynamic>> PlantRequest();

class ScannedPlantView extends StatefulWidget {
  final PlantRequest plantRequest;
  final String imagePath;

  ScannedPlantView(this.plantRequest, this.imagePath);

  @override
  State<StatefulWidget> createState() {
    return ScannedPlantViewState();
  }
}

class ScannedPlantViewState extends State<ScannedPlantView> {
  Map<String, dynamic> plant;

  @override
  void initState() {
    super.initState();
    getPlant();
  }

  Future<void> getPlant() async {
    Map<String, dynamic> newPlant = await widget.plantRequest();

    if (newPlant == null) {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Plant not recognized'),
                content: Text(
                    'Sorry, but we were not able to recognize any plants.'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
      setState(() {
        plant = null;
      });
    } else {
      setState(() {
        plant = newPlant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (plant == null)
        ? Scaffold(
            body: AspectRatio(
                aspectRatio: 3 / 4, child: Image.file(File(widget.imagePath)))
                // TODO some progress indicator
    )
        : PlantDetails(plant);
  }
}
