import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/widgets/ui_elements/historyCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return FutureBuilder(
                future: model.getHistoryUser(),
                builder:(BuildContext context,AsyncSnapshot snapshot) {
                  print(snapshot);
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    break;
                    case ConnectionState.waiting:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      break;

                    case ConnectionState.active:
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                      break;

                    case ConnectionState.done:
                      if(snapshot.hasError){
                        return RefreshIndicator(
                          onRefresh: onRefreshAction,
                          child: ListView(
                            shrinkWrap: true,

                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text("Something Wrong"),
                                ),
                              ),
                            ]
                          ),
                        );
                      }else {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.history.length,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return HisCard(hisDetails: model.history[index]);
                            }
                        );
                      }
                      break;
                  }
                  return Container();
                }
              );
            },

          ),
        ),
      ),
    );
  }

  Future<void> onRefreshAction() async{
    await new Future.delayed(new Duration(seconds: 3));
  }
}