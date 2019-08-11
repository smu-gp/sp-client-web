import 'package:flutter_web/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sp_client/widget/loading_progress.dart';
import 'package:transparent_image/transparent_image.dart';

class MemoImageScreen extends StatefulWidget {
  final List<String> contentImages;
  final int initIndex;

  MemoImageScreen({
    Key key,
    this.contentImages,
    this.initIndex,
  }) : super(key: key);

  @override
  _MemoImageScreenState createState() => _MemoImageScreenState();
}

class _MemoImageScreenState extends State<MemoImageScreen> {
  PageController _pageController;

  int _currentPageIndex;
  List<String> _contentImages;

  String get indexTitle => "${_currentPageIndex + 1}/${_contentImages.length}";

  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initIndex;
    _contentImages = widget.contentImages;
    _pageController = PageController(initialPage: widget.initIndex);
    _pageController.addListener(() {
      setState(() {
        _currentPageIndex = _pageController.page.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_currentPageIndex + 1}/${_contentImages.length}"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(OMIcons.delete),
            onPressed: () {
              _contentImages.removeAt(_currentPageIndex);
              if (_contentImages.isEmpty) {
                Navigator.pop(context);
              } else {
                setState(() {});
              }
            },
          )
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _contentImages.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              LoadingProgress(),
              FadeInImage.memoryNetwork(
                image: _contentImages[index],
                fit: BoxFit.fitWidth,
                placeholder: kTransparentImage,
              ),
            ],
          );
        },
        pageSnapping: true,
      ),
    );
  }
}
