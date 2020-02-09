import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/widgets/ui_elements/historyCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: model.history.length,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return HisCard(hisDetails : model.history[index]);
              }
            );
          },
          
        ),
      ),
    );
  }
}