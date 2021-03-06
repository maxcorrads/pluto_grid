part of '../../../pluto_grid.dart';

/// Event : Dragging [PlutoRow].
class PlutoDragRowsEvent extends PlutoEvent {
  final Offset offset;
  final PlutoDragType dragType;
  final List<PlutoRow> rows;

  PlutoDragRowsEvent({
    this.offset,
    this.dragType,
    this.rows,
  });

  void _handler(PlutoStateManager stateManager) {
    if (dragType == null ||
        (!dragType.isStart && offset == null) ||
        rows == null) {
      return;
    }

    if (dragType.isStart) {
      _startDrag(stateManager);
    } else if (dragType.isUpdate) {
      _updateDrag(stateManager);
    } else if (dragType.isEnd) {
      _endDrag(stateManager);
    }
  }

  void _startDrag(PlutoStateManager stateManager) {
    stateManager.setIsDraggingRow(true, notify: false);
    stateManager.setDragRows(rows);
  }

  void _updateDrag(PlutoStateManager stateManager) {
    stateManager.setDragTargetRowIdx(
      stateManager.getRowIdxByOffset(offset.dy),
    );
  }

  void _endDrag(PlutoStateManager stateManager) {
    stateManager.moveRows(
      rows,
      offset.dy,
      notify: false,
    );
    stateManager.setIsDraggingRow(false);
  }
}

enum PlutoDragType {
  start,
  update,
  end,
}

extension PlutoDragTypeExtension on PlutoDragType {
  bool get isStart => this == PlutoDragType.start;

  bool get isUpdate => this == PlutoDragType.update;

  bool get isEnd => this == PlutoDragType.end;
}

enum PlutoDragItemType {
  rows,
}

extension PlutoDragItemExtension on PlutoDragItemType {
  bool get isRows => this == PlutoDragItemType.rows;
}
