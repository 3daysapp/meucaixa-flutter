import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/pick_image_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
enum ConfigurationStatus { loading, loaded, sending }

///
///
///
class ConfigurationScreen extends StatefulWidget {
  ///
  ///
  ///
  @override
  _ConfigurationScreenState createState() => _ConfigurationScreenState();
}

///
///
///
class _ConfigurationScreenState extends State<ConfigurationScreen> {
  ///
  /// TODO implementar a alteracao da imagem do usuario
  ///
  bool automaticLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();
  final StreamController<ConfigurationStatus> _controller =
      StreamController<ConfigurationStatus>();
  final StreamController<bool> _automaticLoginController =
      StreamController<bool>();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _controller.add(ConfigurationStatus.sending);
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        centerTitle: true,
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            print('Carregando preferencias');
            SharedPreferences prefs = snapshot.data;
            if (prefs.containsKey('automaticLogin')) {
              _automaticLoginController.add(prefs.getBool('automaticLogin'));
            }
            print('Login automatico ${prefs.getBool('automaticLogin')}');
          }
          _controller.add(ConfigurationStatus.loaded);
          return StreamBuilder<ConfigurationStatus>(
            stream: _controller.stream,
            builder: (BuildContext context,
                AsyncSnapshot<ConfigurationStatus> snpShot) {
              switch (snpShot.data) {
                case ConfigurationStatus.loading:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Carregando configurações...'),
                        ),
                      ],
                    ),
                  );
                case ConfigurationStatus.loaded:
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              PickImageDialog.show(
                                context: context,
                                message: 'Selecione a origem da imagem',
                                cameraClicked: _getImageFromCamera,
                                galleryClicked: _getImageFromGallery,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.transparent,
                                backgroundImage: _auth.currentUser.photoURL !=
                                        null
                                    ? NetworkImage(_auth.currentUser.photoURL)
                                    : AssetImage('images/no-user.png'),
                              ),
                            ),
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: _automaticLoginController.stream,
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> automaticLoginSnapshot) {
                            return Row(
                              children: <Widget>[
                                Checkbox(
                                  value: automaticLoginSnapshot.data ?? false,
                                  onChanged: (bool value) {
                                    automaticLogin = value;
                                    _automaticLoginController.add(value);
                                    _savePreferences();
                                  },
                                ),
                                Text('Fazer login automaticamente')
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  );
                case ConfigurationStatus.sending:
              }
              return Container();
            },
          );
        },
      ),
    );
  }

  ///
  ///
  ///
  PickImageDialog _pickImage(BuildContext context) {
    return PickImageDialog();
  }

  ///
  ///
  ///
  Future<PickedFile> _getImageFromCamera() async {
    return await imagePicker.getImage(source: ImageSource.camera);
  }

  ///
  ///
  ///
  Future<PickedFile> _getImageFromGallery() async {
    return await imagePicker.getImage(source: ImageSource.gallery);
  }

  ///
  ///
  ///
  void _savePreferences() async {
    print('Salvando preferencias');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('automaticLogin', automaticLogin);
    _automaticLoginController.add(automaticLogin);
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.close();
    _automaticLoginController.close();
    super.dispose();
  }
}
//
//
