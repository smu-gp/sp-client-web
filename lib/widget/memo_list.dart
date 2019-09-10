import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web/material.dart';
import 'package:flutter_web/src/rendering/sliver_multi_box_adaptor.dart';
import 'package:provider/provider.dart';
import 'package:sp_client/bloc/blocs.dart';
import 'package:sp_client/model/models.dart';
import 'package:sp_client/util/utils.dart';

import 'empty_memo.dart';
import 'error_memo.dart';
import 'loading_progress.dart';
import 'memo_item.dart';
import 'memo_list_tile.dart';

typedef MemoTapCallback = void Function(Memo, bool selectable, bool selected);

typedef MemoLongPressCallback = void Function(Memo, bool selectable);

class MemoList extends StatelessWidget {
  final String folderId;
  final ListType listType;
  final MemoTapCallback onTap;
  final MemoLongPressCallback onLongPress;

  MemoList({
    Key key,
    this.folderId,
    this.listType,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoBloc, MemoState>(
      builder: (context, memoState) {
        return Consumer<MemoSort>(
          builder: (context, sort, child) {
            if (memoState is MemosLoaded) {
              var memos = List.from(memoState.memos);

              // Filter folder memo
              if (folderId != null) {
                memos.retainWhere((memo) => memo.folderId == folderId);
              }

              if (memos.isEmpty) {
                return EmptyMemo();
              }

              memos.sort((a, b) => _compareMemo(a, b, sort));

              return BlocBuilder<ListBloc, ListState>(
                builder: (context, listState) {
                  var itemBuilder = (context, index) {
                    var selectable = false;
                    var selected = false;
                    var memo = memos[index];

                    if (listState is SelectableList) {
                      selectable = true;
                      selected = listState.selectedItems.contains(memo);
                    }

                    if (listType == ListType.list) {
                      return MemoListTile(
                        memo: memo,
                        useUpdatedAt: sort.orderBy == SortOrderBy.updatedAt,
                        selected: selected,
                        onTap: () => onTap(memo, selectable, selected),
                        onLongPress: () => onLongPress(memo, selectable),
                      );
                    } else {
                      return MemoItem(
                        memo,
                        date: sort.orderType == SortOrderBy.updatedAt
                            ? memo.updatedAt
                            : null,
                        selected: selected,
                        onTap: () => onTap(memo, selectable, selected),
                        onLongPress: () => onLongPress(memo, selectable),
                      );
                    }
                  };

                  if (listType == ListType.list) {
                    return ListView.separated(
                      itemBuilder: itemBuilder,
                      separatorBuilder: (context, index) => Divider(height: 2),
                      itemCount: memos.length,
                    );
                  } else {
                    return StaggeredGridView.countBuilder(
                      crossAxisCount: Util.isLarge(context) ? 3 : 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      itemBuilder: itemBuilder,
                      itemCount: memos.length,
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    );
                  }
                },
              );
            } else if (memoState is MemosNotLoaded) {
              return ErrorMemo(memoState.exception);
            } else {
              return LoadingProgress();
            }
          },
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

  int _compareMemo(Memo a, Memo b, MemoSort sort) {
    if (sort.orderBy == SortOrderBy.createdAt) {
      if (sort.orderType == SortOrderType.Asc) {
        return a.createdAt.compareTo(b.createdAt);
      } else {
        return b.createdAt.compareTo(a.createdAt);
      }
    } else if (sort.orderBy == SortOrderBy.updatedAt) {
      if (sort.orderType == SortOrderType.Asc) {
        return a.updatedAt.compareTo(b.updatedAt);
      } else {
        return b.updatedAt.compareTo(a.updatedAt);
      }
    }
    return 0;
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
