import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:rich_text_editor/rich_text_editor.dart';
import 'package:sp_client/bloc/blocs.dart';
import 'package:sp_client/model/models.dart';
import 'package:sp_client/repository/repositories.dart';
import 'package:sp_client/util/localization.dart';
import 'package:sp_client/util/utils.dart';
import 'package:sp_client/widget/loading_progress.dart';
import 'package:uuid/uuid.dart';

typedef ImageListCallback = void Function(int);

class MemoScreen extends StatefulWidget {
  final Memo memo;

  MemoScreen(
    this.memo, {
    Key key,
  }) : super(key: key);

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  TextEditingController _editTitleTextController;
  SpannableTextEditingController _editContentTextController;

  MemoBloc _memoBloc;
  PreferenceRepository _preferenceRepository;

  List<String> _memoContentImages;
  bool _showProgress = false;
  double _progressValue = 0;

  @override
  void initState() {
    super.initState();
    _memoBloc = BlocProvider.of<MemoBloc>(context);
    _preferenceRepository =
        RepositoryProvider.of<PreferenceRepository>(context);

    _editTitleTextController =
        TextEditingController(text: widget.memo.title ?? "");

    var styleList;
    if (widget.memo.contentStyle != null) {
      styleList = SpannableList.fromJson(widget.memo.contentStyle);
    }

    _editContentTextController = SpannableTextEditingController(
      text: widget.memo.content ?? "",
      styleList: styleList,
    );

    _memoContentImages = []..addAll(widget.memo.contentImages ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0),
      body: Column(
        children: <Widget>[
          Visibility(
            visible: _showProgress,
            child: SizedBox(
              child: LinearProgressIndicator(
                backgroundColor: AppColors.accentColor.withOpacity(0.2),
                value: _progressValue,
              ),
              height: 4,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Visibility(
                  visible: _memoContentImages.isNotEmpty,
                  child: _ContentImageList(
                    imageList: _memoContentImages,
                    onItemTap: _handleImageItemTapped,
                  ),
                ),
                Container(
                  height: kToolbarHeight,
                  padding: const EdgeInsets.only(left: 16.0),
                  child: _TitleEditText(controller: _editTitleTextController),
                ),
                _ContentEditText(
                  autofocus: widget.memo.id == null,
                  controller: _editContentTextController,
                ),
              ],
            ),
          ),
          Material(
            elevation: 8.0,
            child: Container(
              height: 48.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
//                    IconButton(
//                      icon: Icon(OMIcons.image),
//                      onPressed: _showAddImageBottomSheet,
//                    ),
//                    VerticalDivider(),
                    StyleToolbar(
                      controller: _editContentTextController,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleImageItemTapped(int index) async {
    await Navigator.push(
      context,
      Routes().memoImage(contentImages: _memoContentImages, initIndex: index),
    );
    setState(() {});
  }

  void _updateMemo() {
    var titleText = _editTitleTextController.text;
    var contentText = _editContentTextController.text;
    var contentStyleText = _editContentTextController.currentStyleList.toJson();

    var memo = widget.memo;
    var isChanged = memo.title != titleText ||
        memo.content != contentText ||
        memo.contentStyle != contentStyleText ||
        memo.contentImages != _memoContentImages;

    memo.title = titleText.isNotEmpty ? titleText : null;
    memo.content = contentText.isNotEmpty ? contentText : null;
    memo.contentStyle = contentStyleText.isNotEmpty ? contentStyleText : null;
    memo.contentImages = _memoContentImages;

    if (isChanged) {
      memo.updatedAt = DateTime.now().millisecondsSinceEpoch;
    }

    var isValid = memo.title != null || memo.content != null;

    if (widget.memo.id != null) {
      if (isValid) {
        if (isChanged) {
          _memoBloc.dispatch(UpdateMemo(memo));
        }
      } else {
        _memoBloc.dispatch(DeleteMemo(widget.memo));
      }
    } else {
      if (isValid) {
        _memoBloc.dispatch(AddMemo(memo));
      }
    }
  }

//  Future _showAddImageBottomSheet() async {
//    _AddImageSheetResult result = await showModalBottomSheet(
//      context: context,
//      builder: (context) => _AddImageSheet(),
//    );
//    if (result != null && result.file != null) {
//      _addImage(result.file, result.enableTextRecognition);
//    }
//  }

//  Future _showProgressDialog() async {
//    await showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (context) {
//        return AlertDialog(
//          content: Row(
//            children: <Widget>[
//              CircularProgressIndicator(),
//              SizedBox(
//                width: 24.0,
//              ),
//              Text(AppLocalizations.of(context).dialogSendImage)
//            ],
//          ),
//        );
//      },
//    );
//  }

//  void _showSendErrorDialog([Object e]) {
//    showDialog(
//      context: context,
//      builder: (context) {
//        return AlertDialog(
//          title: Text('Error occurred'),
//          content: Text(e != null ? e.toString() : 'No results from service'),
//          actions: <Widget>[
//            FlatButton(
//              onPressed: () {
//                Navigator.pop(context);
//              },
//              child: Text('OK'),
//            ),
//          ],
//        );
//      },
//    );
//  }

//  Future _addImage(File file, bool enableTextRecognition) async {
//    if (enableTextRecognition) {
//      _uploadProcessingServer(file);
//    } else {
//      _uploadFirebaseStorage(file);
//    }
//  }

//  Future _uploadFirebaseStorage(File imageFile) async {
//    final userId = _preferenceRepository.getString(AppPreferences.keyUserId);
//    final uuid = Uuid().v1();
//    final ext = imageFile.path.split(".")[1];
//    final storage = FirebaseStorage.instance;
//    final storageRef = storage.ref().child(userId).child('$uuid.$ext');
//    final uploadTask = storageRef.putFile(imageFile);
//
//    setState(() {
//      _showProgress = true;
//    });
//
//    await for (final event in uploadTask.events) {
//      if (event.type == StorageTaskEventType.progress) {
//        setState(() {
//          _progressValue =
//              event.snapshot.bytesTransferred / event.snapshot.totalByteCount;
//          debugPrint(_progressValue.toString());
//        });
//      } else if (event.type == StorageTaskEventType.success) {
//        final downloadURL = await event.snapshot.ref.getDownloadURL();
//
//        _memoContentImages.add(downloadURL);
//
//        setState(() {
//          _progressValue = 0;
//          _showProgress = false;
//        });
//      }
//    }
//  }

//  void _uploadProcessingServer(File imageFile) async {
//    _showProgressDialog();
//
//    try {
//      var host =
//          _preferenceRepository.getString(AppPreferences.keyServiceHost) ??
//              defaultServiceHost;
//
//      var results = await Service.sendImage(
//        imageFile: imageFile,
//        baseUrl: processingServiceUrl(host),
//      );
//
//      Navigator.pop(context); // Hide progress dialog
//      showDialog(
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              title: Text(AppLocalizations.of(context).titleResult),
//              contentPadding: const EdgeInsets.symmetric(
//                vertical: 16.0,
//                horizontal: 8.0,
//              ),
//              content: Container(
//                width: 300,
//                height: 400,
//                child: ListView(
//                  children: results
//                      .map((result) => ListItem(
//                            title: result.content,
//                            onTap: () {},
//                          ))
//                      .toList(),
//                ),
//              ),
//            );
//          });
//    } catch (e) {
//      Navigator.pop(context); // Hide progress dialog
//      _showSendErrorDialog(e);
//    }
//  }

  @override
  void dispose() {
    _updateMemo();
    _editTitleTextController.dispose();
    _editContentTextController.dispose();
    super.dispose();
  }
}

class _TitleEditText extends StatelessWidget {
  final TextEditingController controller;

  _TitleEditText({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: TextField(
        autofocus: false,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
          hintText: AppLocalizations.of(context).hintInputTitle,
        ),
        style: Theme.of(context).textTheme.headline,
        maxLines: 1,
        onChanged: (value) {},
      ),
    );
  }
}

class _ContentEditText extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;

  _ContentEditText({
    Key key,
    this.autofocus = false,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Scrollbar(
          child: TextField(
            autofocus: autofocus,
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: false,
              hintText: AppLocalizations.of(context).hintInputNote,
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentImageList extends StatelessWidget {
  final List<String> imageList;
  final ImageListCallback onItemTap;

  _ContentImageList({
    Key key,
    this.imageList = const [],
    this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: (imageList.length > 1
            ? ListView(
                scrollDirection: Axis.horizontal,
                itemExtent: 360,
                children: imageList
                    .asMap()
                    .entries
                    .map((entry) => Padding(
                          padding: EdgeInsets.only(
                              right: (entry.key != imageList.length - 1)
                                  ? 4.0
                                  : 0),
                          child: _ContentImageItem(
                            url: entry.value,
                            onTap: () => onItemTap(entry.key),
                          ),
                        ))
                    .toList())
            : _ContentImageItem(
                url: imageList.first,
                onTap: () => onItemTap(0),
              )),
      ),
    );
  }
}

class _ContentImageItem extends StatelessWidget {
  final String url;
  final VoidCallback onTap;

  _ContentImageItem({Key key, this.url, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          LoadingProgress(),
          FadeInImage.memoryNetwork(
            image: url,
            fit: BoxFit.fitWidth,
            placeholder: kTransparentImage,
          ),
        ],
      ),
    );
  }
}

//class _AddImageSheet extends StatefulWidget {
//  @override
//  _AddImageSheetState createState() => _AddImageSheetState();
//}
//
//class _AddImageSheetState extends State<_AddImageSheet> {
//  bool _enableTextRecognition = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: Wrap(
//        children: <Widget>[
//          SwitchListItem(
//            title: AppLocalizations.of(context).actionAddTextFromImage,
//            value: _enableTextRecognition,
//            onChanged: (bool value) {
//              setState(() {
//                _enableTextRecognition = value;
//              });
//            },
//          ),
//          Divider(),
//          ListItem(
//            leading: Icon(
//              OMIcons.image,
//              color: Theme.of(context).accentColor,
//            ),
//            title: AppLocalizations.of(context).imageFromGallery,
//            onTap: () => _handleMenuTapped(ImageSource.gallery),
//          ),
//          ListItem(
//            leading: Icon(
//              OMIcons.photoCamera,
//              color: Theme.of(context).accentColor,
//            ),
//            title: AppLocalizations.of(context).imageFromCamera,
//            onTap: () => _handleMenuTapped(ImageSource.camera),
//          ),
//        ],
//      ),
//    );
//  }

//  Future _handleMenuTapped(ImageSource source) async {
//    var file = await ImagePicker.pickImage(source: source);
//    Navigator.pop(
//      context,
//      _AddImageSheetResult(
//        file: file,
//        enableTextRecognition: _enableTextRecognition,
//      ),
//    );
//  }
//}

//class _AddImageSheetResult {
//  final File file;
//  final bool enableTextRecognition;
//
//  _AddImageSheetResult({this.file, this.enableTextRecognition});
//
//  @override
//  String toString() {
//    return '$runtimeType(file: $file, enableTextRecognition: $enableTextRecognition)';
//  }
//}
