import 'package:flutter/material.dart';

class ZBGridTile extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of logical pixels between each child along the main axis.
  final double mainAxisSpacing;

  /// The number of logical pixels between each child along the cross axis.
  final double crossAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent of each child.
  final double childAspectRatio;

  const ZBGridTile(
      {Key key,
      this.itemCount,
      this.itemBuilder,
      this.crossAxisCount,
      this.mainAxisSpacing,
      this.crossAxisSpacing,
      this.childAspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double usableCrossAxisExtent =
            constraints.maxWidth - crossAxisSpacing * (crossAxisCount - 1);
        final double childCrossAxisExtent =
            usableCrossAxisExtent / crossAxisCount;
        final double childMainAxisExtent =
            childCrossAxisExtent / childAspectRatio;

        final List<Widget> colums = [];
        List<Widget> rows = [];

        for (int i = 0; i < itemCount; ++i) {
          Widget item = itemBuilder(context, i);

          if (item == null) continue;

          item = Container(
            child: item,
            width: childCrossAxisExtent,
          );
          rows.add(item);

          if (rows.length == crossAxisCount) {
            Widget row = Row(
              children: rows,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            );
            row = Container(
              child: row,
              height: childMainAxisExtent,
            );
            colums.add(row);
            rows = [];
          }
        }

        if (rows.length > 0) {
          Widget row = Row(
            children: rows,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
          row = Container(
            child: row,
            height: childMainAxisExtent,
          );
          colums.add(row);
        }

        Widget column = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: colums,
          mainAxisSize: MainAxisSize.min,
        );

        final height = (childMainAxisExtent + mainAxisSpacing) * colums.length - mainAxisSpacing;
        column = Container(
          child: column,
          height: height,
        );
        return column;
      },
    );
  }
}
