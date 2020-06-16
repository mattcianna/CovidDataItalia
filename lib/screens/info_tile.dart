import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  int totalNumber;
  int variationNumber;
  String title;
  Color color;

  InfoTile({
    @required this.totalNumber,
    @required this.variationNumber,
    @required this.title,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Expanded(
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: color),
              ),
            ),
            FittedBox(
              child: Text(
                "$totalNumber",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: color),
              ),
            ),
            FittedBox(
              child: Text(
                "${variationNumber < 0 ? variationNumber : "+$variationNumber"}",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
