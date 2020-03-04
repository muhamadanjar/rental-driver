import 'package:driver/models/responseapi.dart';
import 'package:driver/scope/main_model.dart';
import 'package:driver/ui/pages/detil_order.dart';
import 'package:driver/ui/pages/history.dart';
import 'package:driver/ui/pages/profile.dart';
import 'package:driver/ui/pages/request_saldo.dart';
import 'package:driver/ui/pages/setting.dart';
import 'package:driver/ui/widgets/ui_elements/chart.dart';
import 'package:driver/utils/rental.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class DashboardTwoPage extends StatefulWidget {
  @override
  _DashboardTwoPageState createState() => _DashboardTwoPageState();
}

class _DashboardTwoPageState extends State<DashboardTwoPage> {
  final String image = 'https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media';

  final MainModel mainModel = MainModel();
  @override
  void initState() {
    ScopedModel.of<MainModel>(context).getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).buttonColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RefreshIndicator(
          onRefresh:() => _handleRefresh(model.getUser),
            child: CustomScrollView(
            slivers: <Widget>[
              _buildStats(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildTitledContainer("Pemesanan",
                    child: ScopedModelDescendant<MainModel>(
                      builder: (BuildContext context,Widget child,MainModel model){
                        return Container(
                          height: 290,
                          child: PieChartSample2(),
                        );
                      }

                    )
                  ),
                ),
              ),
              _buildActivities(context),
            ],
          ),
        );
      }
    );
  }

  SliverPadding _buildStats() {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
        crossAxisCount: 2,
        children: <Widget>[
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context,Widget child,MainModel model){
              var saldo = model.user != null ? model.user.account != null ? model.user.account.saldo.toString() :'0' : '0';
              
              return Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      RentalUtils.formatRupiah(saldo),
                      style: stats,
                    ),
                    const SizedBox(height: 5.0),
                    Text("Saldo".toUpperCase())
                  ],

                ),
              );
            }
          ),
          ScopedModelDescendant<MainModel>(

            builder:(BuildContext context,Widget child,MainModel model) => Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "+1200",
                    style: stats,
                  ),
                  const SizedBox(height: 5.0),
                  Text("Orders".toUpperCase())
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverToBoxAdapter(
        child: _buildTitledContainer(
          "Aktifitas",
          height: 280,
          child: Expanded(
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: activities
                  .map(
                    (activity) => InkWell(
                      onTap: (){
                        if (activity.title == 'Appointments') {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DetilOrder()));
                        }else if (activity.title == 'TopUp') {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>RequestSaldoPage()));
                        }else if(activity.title == 'Summary'){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>HistoryPage()));
                        }else if(activity.title == 'Pengaturan'){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingPage()));
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>SettingPage()));
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).buttonColor,
                            child: activity.icon != null
                                ? Icon(
                                    activity.icon,
                                    size: 18.0,
                                  )
                                : null,
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            activity.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0)),
              height: 200,
              foregroundDecoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Good Afternoon".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Take a glimpses at your dashboard",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      centerTitle: true,
      // titleSpacing: 0.0,
      elevation: 0.5,
      backgroundColor: Colors.white,
      title: Text(
        "Dashboard",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[_buildAvatar(context)],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return IconButton(
      iconSize: 40,
      padding: EdgeInsets.all(0),
      icon: CircleAvatar(
        backgroundColor: Colors.grey.shade300,
        child: CircleAvatar(radius: 16, backgroundImage: CachedNetworkImageProvider(image)),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
      },
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }

  Future<Null> _handleRefresh(Function func) async {
    await new Future.delayed(new Duration(seconds: 3));
    try {
      
      ResponseApi responseApi = await func();
      print(responseApi);
    } catch (e) {
      print("error $e");
    }
    
    return null;
  }
}



class Activity {
  final String title;
  final IconData icon;
  Activity({this.title, this.icon});
}

final List<Activity> activities = [
  Activity(title: "Appointments", icon: FontAwesomeIcons.calendarDay),
  Activity(title: "Summary", icon: FontAwesomeIcons.fileAlt),
  Activity(title: "TopUp", icon: FontAwesomeIcons.dollarSign),
  Activity(title: "Pengaturan", icon: FontAwesomeIcons.cogs),
];
