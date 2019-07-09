import 'package:flutter/material.dart';
import 'package:flutter_demo/global.dart';

/// 登录页
class HBLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HBLoginPageState();
}

class _HBLoginPageState extends State<HBLoginPage> {
  final _accountController = new TextEditingController();
  final _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildRegisterButton(context),
            SizedBox(
              height: 90.0,
            ),
            Container(
                margin: EdgeInsets.only(top: 14.0, left: 48.0, right: 48.0),
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Color(0xFFEFEFEF)),
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    hintText: '手机号',
                    contentPadding: EdgeInsets.all(2.0),
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    border: InputBorder.none,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 14.0, left: 48.0, right: 48.0),
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Color(0xFFEFEFEF)),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '密码',
                    contentPadding: EdgeInsets.all(2.0),
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    border: InputBorder.none,
                  ),
                )),
            _buildLoginButton(context),
            _buildForgetPasswordButton(),
            _build3rdLoginWidget(),
          ],
        ),
      ),
    ));
  }

  Container _build3rdLoginWidget() {
    return Container(
      margin: EdgeInsets.only(left: 48.0, top: 80.0, right: 48.0, bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(children: <Widget>[
            Expanded(
              child: Row(children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF8E8E8E),
                        height: 0.3,
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      '第三方登录',
                      style:
                          TextStyle(color: Color(0xFF8E8E8E), fontSize: 14.0),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xFF8E8E8E),
                        height: 0.3,
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ]),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
        ],
      ),
    );
  }

  Row _buildForgetPasswordButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(),
        ),
        Container(
          width: 120.0,
          margin: const EdgeInsets.only(left: 48.0, right: 48.0),
          alignment: Alignment.topRight,
          child: FlatButton(
            child: Text(
              '忘记密码',
              style: TextStyle(color: Color(0xFF8E8E8E)),
              textAlign: TextAlign.right,
            ),
            onPressed: () {
              print('忘记密码');
            },
          ),
        ),
      ],
    );
  }

  Container _buildLoginButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0, left: 48.0, right: 48.0),
      height: 40.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              color: HBColors.primaryColor,
              highlightColor: Theme.of(context).highlightColor,
              child: Text('登录'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                print('login:' +
                    _accountController.text +
                    '/' +
                    _passwordController.text);
                eventBus.fire(UserAuthEvent(isLogined: true));
              },
            ),
          ),
        ],
      ),
    );
  }

  Container _buildRegisterButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(),
        ),
        FlatButton(
          child: Text('注册'),
          onPressed: () {},
        ),
      ]),
    );
  }
}
