import 'package:flutter_web/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sp_client/bloc/blocs.dart';
import 'package:sp_client/model/models.dart';
import 'package:sp_client/screen/settings_screen.dart';
import 'package:sp_client/util/util.dart';
import 'package:sp_client/widget/history_list.dart';
import 'package:sp_client/widget/sort_dialog.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HistoryListBloc _historyListBloc = HistoryListBloc();
  HistoryBloc _historyBloc;
  ResultBloc _resultBloc;

  int _navigationIndex = 0;

  @override
  void initState() {
    _historyBloc = BlocProvider.of<HistoryBloc>(context)
      ..dispatch(LoadHistory(SortOrder.createdAtDes));
    _resultBloc = BlocProvider.of<ResultBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryListEvent, HistoryListState>(
      bloc: _historyListBloc,
      builder: (BuildContext context, HistoryListState state) {
        return Scaffold(
          appBar: _buildAppBar(state),
          body: Row(
            children: <Widget>[
              _buildSidebar(),
              Expanded(
                child: [
                  BlocProvider<HistoryListBloc>(
                    bloc: _historyListBloc,
                    child: HistoryList(),
                  ),
                ].elementAt(_navigationIndex),
              ),
            ],
          ),
          // bottomNavigationBar: Visibility(
          //   visible: !Util.isTablet(context),
          //   child: _buildBottomNavigation(),
          // ),
          resizeToAvoidBottomPadding: false,
        );
      },
    );
  }

  @override
  void dispose() {
    _historyListBloc.dispose();
    super.dispose();
  }

  Widget _buildAppBar(HistoryListState state) {
    return AppBar(
      leading: (state is UnSelectableList
          ? null
          : IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _historyListBloc.dispatch(UnSelectable());
              },
            )),
      title: Text(
        (state is UnSelectableList
            ? "History"
            : (state as SelectableList).selectedItemCount.toString()),
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor:
          (state is UnSelectableList ? null : Theme.of(context).accentColor),
      elevation: Util.isTablet(context) ? 4.0 : 0.0,
      actions: (state is UnSelectableList
          ? (_buildDateActions())
          : _buildSelectableActions()),
    );
  }

  Widget _buildSidebar() {
    return Material(
      elevation: 4.0,
      child: Container(
        width: 80.0,
        color: Theme.of(context).bottomAppBarColor,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.date_range),
              color: Theme.of(context).iconTheme.color,
              disabledColor: Theme.of(context).accentColor,
              onPressed: _navigationIndex == 0
                  ? null
                  : () => setState(() => _navigationIndex = 0),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildBottomNavigation() {
  //   return SizedBox(
  //     height: 56.0,
  //     child: BottomAppBar(
  //       child: Row(
  //         mainAxisSize: MainAxisSize.max,
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: <Widget>[
  //           IconButton(
  //             icon: Icon(OMIcons.dateRange),
  //             color: Theme.of(context).iconTheme.color,
  //             disabledColor: Theme.of(context).accentColor,
  //             onPressed: _navigationIndex == 0
  //                 ? null
  //                 : () => setState(() => _navigationIndex = 0),
  //           ),
  //           IconButton(
  //             icon: Icon(OMIcons.folder),
  //             color: Theme.of(context).iconTheme.color,
  //             disabledColor: Theme.of(context).accentColor,
  //             onPressed: _navigationIndex == 1
  //                 ? null
  //                 : () {
  //                     _historyListBloc.dispatch(UnSelectable());
  //                     setState(() => _navigationIndex = 1);
  //                   },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  List<Widget> _buildDateActions() {
    var actions = <Widget>[
      IconButton(
        icon: Icon(Icons.sort),
        onPressed: () => showDialog(
              context: context,
              builder: (context) => SortDialog(),
            ),
      ),
    ];

    var actionEdit = () {
      _historyListBloc.dispatch(Selectable());
    };
    var actionSettings = () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SettingsScreen()));
    };

    if (Util.isTablet(context)) {
      actions.addAll([
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: actionEdit,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: actionSettings,
        )
      ]);
    } else {
      actions.add(
        PopupMenuButton<MainMenuItem>(
          itemBuilder: (context) => [
                PopupMenuItem<MainMenuItem>(
                  child: Text("Edit"),
                  height: 56.0,
                  value: MainMenuItem.actionEdit,
                ),
                PopupMenuItem<MainMenuItem>(
                  child: Text("Settings"),
                  height: 56.0,
                  value: MainMenuItem.actionSettings,
                ),
              ],
          onSelected: (selected) {
            if (selected == MainMenuItem.actionEdit) {
              actionEdit();
            } else if (selected == MainMenuItem.actionSettings) {
              actionSettings();
            }
          },
        ),
      );
    }
    return actions;
  }

  List<Widget> _buildSelectableActions() {
    return [
      IconButton(
        icon: Icon(Icons.delete),
        tooltip: "Delete",
        onPressed: () {
          var state = _historyListBloc.currentState as SelectableList;
          var items = state.selectedItems;
          items.forEach((item) {
            _historyBloc.dispatch(DeleteHistory(item.id));
            _resultBloc.deleteResults(item.id);
          });
          _historyListBloc.dispatch(UnSelectable());
        },
      ),
    ];
  }
}
