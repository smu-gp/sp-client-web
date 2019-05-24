import 'package:flutter_web/cupertino.dart';
import 'package:flutter_web/material.dart';
import 'package:sp_client/util/utils.dart';

class EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(AppLocalizations.of(context).historyEmpty),
        ],
      ),
    );
  }
}
