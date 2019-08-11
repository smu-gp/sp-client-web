import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/src/rendering/sliver_multi_box_adaptor.dart';
import 'package:provider/provider.dart';
import 'package:sp_client/bloc/blocs.dart';
import 'package:sp_client/model/models.dart';
import 'package:sp_client/util/utils.dart';
import 'package:sp_client/widget/empty_memo.dart';
import 'package:sp_client/widget/error_memo.dart';
import 'package:sp_client/widget/loading_progress.dart';
import 'package:sp_client/widget/memo_item.dart';

class MemoList extends StatelessWidget {
  final String folderId;

  const MemoList({
    Key key,
    this.folderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listBloc = BlocProvider.of<ListBloc>(context);
    var memoBloc = BlocProvider.of<MemoBloc>(context);

    return BlocBuilder<MemoBloc, MemoState>(
      bloc: memoBloc,
      builder: (context, memoState) {
        if (memoState is MemosLoaded) {
          return Consumer<MemoSort>(
            builder: (context, sortValue, _) {
              var memoList = _sortMemos(
                memoState.memos,
                orderBy: sortValue.orderBy,
                type: sortValue.orderType,
              );

              if (folderId != null) {
                memoList = _filterMemos(memoList, folderId: folderId);
              }

              if (memoList.isEmpty) {
                return EmptyMemo();
              }

              return BlocBuilder<ListBloc, ListState>(
                bloc: listBloc,
                builder: (context, memoListState) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _buildGrid(
                      memoList,
                      listBloc: listBloc,
                      listState: memoListState,
                      orderType: sortValue.orderType,
                      isLarge: Util.isLarge(context),
                    ),
                  );
                },
              );
            },
          );
        } else if (memoState is MemosNotLoaded) {
          return ErrorMemo(memoState.exception);
        } else {
          return LoadingProgress();
        }
      },
    );
  }

  Widget _buildGrid(
    List<Memo> memoList, {
    ListBloc listBloc,
    ListState listState,
    SortOrderType orderType,
    bool isLarge,
  }) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLarge ? 3 : 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      itemCount: memoList.length,
      itemBuilder: (context, index) {
        var memo = memoList[index];
        var selected = false;
        if (listState is SelectableList) {
          selected = listState.selectedItems.contains(memo);
        }
        return MemoItem(
          memo,
          date: orderType == SortOrderBy.updatedAt ? memo.updatedAt : null,
          selected: selected,
          onTap: () {
            if (listState is SelectableList) {
              if (selected) {
                listBloc.dispatch(UnSelectItem(memo));
              } else {
                listBloc.dispatch(SelectItem(memo));
              }
            } else {
              Navigator.push(context, Routes().memo(memo));
            }
          },
          onLongPress: () => listBloc.dispatch(SelectItem(memo)),
        );
      },
    );
//    return StaggeredGridView.countBuilder(
//      primary: false,
//      crossAxisCount: isLarge ? 3 : 2,
//      mainAxisSpacing: 2.0,
//      crossAxisSpacing: 2.0,
//      itemCount: memoList.length,
//      itemBuilder: (context, index) {
//        var memo = memoList[index];
//        var selected = false;
//        if (listState is SelectableList) {
//          selected = listState.selectedItems.contains(memo);
//        }
//        return MemoItem(
//          memo,
//          date: orderType == SortOrderBy.updatedAt ? memo.updatedAt : null,
//          selected: selected,
//          onTap: () {
//            if (listState is SelectableList) {
//              if (selected) {
//                listBloc.dispatch(UnSelectItem(memo));
//              } else {
//                listBloc.dispatch(SelectItem(memo));
//              }
//            } else {
//              Navigator.push(context, Routes().memo(memo));
//            }
//          },
//          onLongPress: () => listBloc.dispatch(SelectItem(memo)),
//        );
//      },
//      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//    );
  }

  List<Memo> _sortMemos(List<Memo> memos,
      {SortOrderBy orderBy, SortOrderType type}) {
    memos.sort((a, b) {
      if (orderBy == SortOrderBy.createdAt) {
        if (type == SortOrderType.Asc) {
          return a.createdAt.compareTo(b.createdAt);
        } else {
          return b.createdAt.compareTo(a.createdAt);
        }
      } else if (orderBy == SortOrderBy.updatedAt) {
        if (type == SortOrderType.Asc) {
          return a.updatedAt.compareTo(b.updatedAt);
        } else {
          return b.updatedAt.compareTo(a.updatedAt);
        }
      }
      return 0;
    });
    return memos;
  }

  List<Memo> _filterMemos(List<Memo> memos, {String folderId}) {
    return memos.where((memo) {
      return memo.folderId == folderId;
    }).toList();
  }
}

class _MemoGridList extends BoxScrollView {
  @override
  Widget buildChildLayout(BuildContext context) {
    // TODO: implement buildChildLayout
    return _SliverMemoGrid();
  }
}

class _SliverMemoGrid extends SliverMultiBoxAdaptorWidget {
  @override
  RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context) {
    // TODO: implement createRenderObject
    return RenderMemoGrid();
  }
}

class RenderMemoGrid extends RenderSliverMultiBoxAdaptor {
  RenderMemoGrid({
    @required RenderSliverBoxChildManager childManager,
  }) : super(childManager: childManager);

  @override
  double childCrossAxisPosition(RenderBox child) {
    child.parentData;
    return super.childCrossAxisPosition(child);
  }

  @override
  void performLayout() {
    childManager.didStartLayout();
    childManager.setDidUnderflow(false);


  }
}
