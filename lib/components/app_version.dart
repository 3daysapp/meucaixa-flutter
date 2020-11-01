import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/utils/config.dart';
import 'package:package_info/package_info.dart';

///
///
///
class AppVersion extends StatelessWidget {
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
          if (snapshot.hasData) {
            PackageInfo _packageInfo = snapshot.data;

            return Container(
              child: Column(
                children: <Widget>[
                  Text('${_packageInfo.version}.${_packageInfo.buildNumber}'),
                  Text(Config.releaseDate),
                ],
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}
