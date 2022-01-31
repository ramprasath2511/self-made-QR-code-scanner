import 'package:doctor_appointment_booking/blocs/secrete_code_bloc.dart';
import 'package:doctor_appointment_booking/model/backup_email_provider.dart';
import 'package:doctor_appointment_booking/model/secrete_code_data.dart';
import 'package:doctor_appointment_booking/netwoking/Repsonse.dart';
import 'package:doctor_appointment_booking/pages/Backup/circular%20indicator.dart';
import 'package:doctor_appointment_booking/pages/Detailsadd/detailsadd.dart';
import 'package:doctor_appointment_booking/pages/History/historyscreen.dart';
import 'package:doctor_appointment_booking/pages/contact/Contact.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';
import '../drawer/drawer_page.dart';
import 'Qrhome.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey _titleKey = GlobalKey();
  final GlobalKey _firstButtonKey = GlobalKey();

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;

  static PageController _pageController;
  bool secreteCodeCalled = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _selectedIndex,
    );

    getName();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _selectPage(int index) {
    if (_pageController.hasClients) _pageController.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _pages = [
      QRViewExample(),
      History(),
    ];
    return Stack(
      children: <Widget>[
        DrawerPage(

          name: name,
          networkImage: networkImage,
          onTap: () {
            setState(
              () {
                xOffset = 0;
                yOffset = 0;
                scaleFactor = 1;
                isDrawerOpen = false;
              },
            );
          },
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor)
            ..rotateY(isDrawerOpen ? -0.5 : 0),
          duration: Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
            child: Scaffold(
              backgroundColor: Colors.white70,
              appBar: AppBar(
                leading: isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: 40,
                        onPressed: () {
                          setState(
                            () {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            },
                          );
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.menu),
                        key: _titleKey,
                        onPressed: () {
                          setState(() {
                            xOffset = size.width - size.width / 3;
                            yOffset = size.height * 0.1;
                            scaleFactor = 0.8;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                title: AppBarTitleWidget(),
                actions: <Widget>[
                  _selectedIndex == 2
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.message);
                          },
                          icon: Icon(
                            Icons.add,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contact()),
                            );
                          },
                          icon: Icon(
                            Icons.help_outline,
                          ),
                        ),
                ],
              ),
              body: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _pages,
              ),
              floatingActionButton: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x202e83f8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x202e83f8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFFc2c2c2),
                                Color(0xFFFFFFFF),
                              ])),
                          child: Icon(
                            Icons.home_sharp,
                            size: 34,
                            key: _firstButtonKey,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: Container(
                height: 100,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: NavBarItemWidget(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Backup()),
                            );
                          },
                          iconData: Icons.backup_sharp,
                          text: 'Backup'.tr(),
                          color: _selectedIndex == 0
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: NavBarItemWidget(
                          onTap: () {
                            _selectPage(3);
                          },
                          iconData: Icons.history,
                          text: 'History'.tr(),
                          color: _selectedIndex == 3
                              ? Colors.deepOrangeAccent
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                _selectPage(0);
              },
              iconData: Icons.home,
              text: 'home'.tr(),
              color: _selectedIndex == 0 ? kColorBlue : Colors.grey,
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: NavBarItemWidget(
              onTap: () {
                _selectPage(3);
              },
              iconData: Icons.settings,
              text: 'settings'.tr(),
              color: _selectedIndex == 3 ? kColorBlue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  String name,networkImage="";
  void getName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name");
      if(preferences.getString("profile")!=null)
        {
          networkImage = preferences.getString("profile");
        }
      var transactionType = Provider.of<EmailProvider>(context, listen: false);
      transactionType.setProfileImage(networkImage);
     // networkImage !=""||networkImage!=null?Image.network(networkImage)
    });
  }

  SecreteCodeBloc _bloc;
  SecreteCodeModel _secreteCodeModel;
  List<Data> _secreteCodeList = new List();
  void getAllSecreteCodes() async{
    _bloc = new SecreteCodeBloc();
    _bloc.chuckListStream.listen((onData) {
      _secreteCodeModel = onData.data;
      //print(onData.status);
      if (onData.status == Status.LOADING) {
        // _playAnimation();
      } else if (onData.status == Status.COMPLETED) {
        if (_secreteCodeModel.success == 1) {


          setState(() {
            _secreteCodeList.addAll(_secreteCodeModel.data);
            secreteCodeCalled = true;

          });
          Navigator.of(context).pushReplacementNamed(Routes.home);
        } else {
         // CommonMethod.showToast(context, _googleSignInModel.msg);

        }
      } else if (onData.status == Status.ERROR) {
        setState(() {
          secreteCodeCalled = true;
        });
      }
    });
  }
}

_onAlertWithCustomContentPress(context) {
  Alert(
      context: context,
      image: Image(
        image: AssetImage('assets/images/Coming soon.gif'),
      ),
      title: "Coming Soon",
      content: Column(
        children: <Widget>[],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          color: kColorPrimary,
          child: Text(
            "Okay",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
