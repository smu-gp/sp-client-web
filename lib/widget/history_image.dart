import 'package:flutter_web/material.dart';
import 'package:sp_client/model/history.dart';

class HistoryImage extends StatelessWidget {
  final History history;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const HistoryImage({
    Key key,
    @required this.history,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'history_${history.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
        ),
      ),
    );
  }
}
