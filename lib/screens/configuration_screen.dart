import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meu_caixa_flutter/components/display_alert.dart';
import 'package:meu_caixa_flutter/components/pick_image_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
///
///
enum ConfigurationStatus { loading, loaded, uploading }

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
  bool automaticLogin = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker imagePicker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
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
    _controller.add(ConfigurationStatus.loading);
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
            SharedPreferences prefs = snapshot.data;
            if (prefs.containsKey('automaticLogin')) {
              _automaticLoginController.add(prefs.getBool('automaticLogin'));
              automaticLogin = prefs.getBool('automaticLogin');
            }
          }

          _controller.add(ConfigurationStatus.loaded);

          ///
          ///
          ///
          return StreamBuilder<ConfigurationStatus>(
            stream: _controller.stream,
            builder: (BuildContext context,
                AsyncSnapshot<ConfigurationStatus> snpShot) {
              switch (snpShot.data) {

                ///
                ///
                /// Loading shared preferences
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

                ///
                ///
                /// Loaded
                case ConfigurationStatus.loaded:
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              await _selectImageSource();
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
                            _automaticLoginController.add(automaticLogin);
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

                ///
                ///
                /// Uploading profile photo
                case ConfigurationStatus.uploading:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Alterando imagem do usuário...'),
                        ),
                      ],
                    ),
                  );
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
  Future<void> _selectImageSource() async {
    ImageSource imageSource = await PickImageDialog.selectSourceOfImage(
        context: context, message: 'Selecione a origem da imagem');
    if (imageSource != null) {
      PickedFile file;
      switch (imageSource) {
        case ImageSource.camera:
          file = await _getImageFromCamera();
          break;
        case ImageSource.gallery:
          file = await _getImageFromGallery();
          break;
      }
      if (file != null) {
        bool imageAccepted = await _visualizeImage(file);
        if (imageAccepted) {
          String fileURL = await _uploadPhoto(file);
          bool imageUpdated = false;
          if (fileURL != null) {
            try {
              await _auth.currentUser.updateProfile(photoURL: fileURL);
              imageUpdated = true;
            } catch (error) {
              print(error);
            }
          }
          await DisplayAlert.show(
              context: context,
              message: fileURL != null && imageUpdated
                  ? 'Foto alterada com sucesso!'
                  : 'Falha ao alterar imagem, por favor, tente mais tarde!');
          _controller.add(ConfigurationStatus.loaded);
        }
      }
    }
  }

  ///
  ///
  ///
  Future<String> _uploadPhoto(PickedFile pickedFile) async {
    File file = File(pickedFile.path);
    String fileExtension = file.path.split('.').last;
    Reference ref = _firebaseStorage
        .ref()
        .child('usersProfileImage')
        .child('/${_auth.currentUser.uid}.$fileExtension');
    try {
      _controller.add(ConfigurationStatus.uploading);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (error) {
      print(error);
      return null;
    }
  }

  ///
  ///
  ///
  Future<bool> _visualizeImage(PickedFile file) async {
    return await PickImageDialog.visualizeImage(
        context: context, message: 'Confirmar seleção de imagem', file: file);
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
