import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///
///
///
class PickImageDialog {
  ///
  ///
  ///
  static Future<ImageSource> selectSourceOfImage({
    @required BuildContext context,
    @required String message,
    String title = 'Selecione a origem da imagem',
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 400,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.camera),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Câmera'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(ImageSource.camera);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.image_search_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Galeria'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(ImageSource.gallery);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  ///
  ///
  ///
  static Future<bool> visualizeImage({
    @required BuildContext context,
    @required String message,
    @required PickedFile file,
    String title = 'Confirmar imagem selecionada',
  }) async {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FutureBuilder<Uint8List>(
                  future: file.readAsBytes(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: 400,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.transparent,
                                backgroundImage: MemoryImage(snapshot.data)),
                          ),
                        ),
                      );
                    }
                    return SizedBox(
                      width: 400,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text('Carregando imagem...'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.close),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Cancelar'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.check),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Aceitar'),
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
