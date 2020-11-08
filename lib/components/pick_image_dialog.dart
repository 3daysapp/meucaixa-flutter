import 'package:flutter/material.dart';

class PickImageDialog {
  static Future<bool> show({
    @required BuildContext context,
    @required String message,
    @required Function cameraClicked,
    @required Function galleryClicked,
    String title = 'Selecione a origem da imagem',
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          actions: <Widget>[
            Column(
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.camera),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Câmera'),
                    ],
                  ),
                  onPressed: cameraClicked,
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.image_search_outlined),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Galeria'),
                    ],
                  ),
                  onPressed: galleryClicked,
                )
              ],
            )
          ],
        );
      },
    );
  }
}
