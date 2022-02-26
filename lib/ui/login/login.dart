import 'dart:convert';
import 'dart:ui';

import 'package:boilerplate/StoredataScurety/StoreSercurity.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/gateway/gateway_store.dart';
import 'package:boilerplate/stores/home/home_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/language_utils.dart';
import 'package:boilerplate/widgets/form_textfield_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import "query_string.dart" as ParseStirng;
import '../Gis/StoreUrlGis.dart'as stores ;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> listProtocols = ["https", "http"];
  bool _obscureText = true;
  final SecureStorage secureStorage = SecureStorage();
  final _storage = FlutterSecureStorage();
  GatewayStore _gatewayStore;
  HomeStore _homeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gatewayStore = Provider.of(context);
    _homeStore = Provider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(builder: (_) {
          return WillPopScope(
            onWillPop: () async => !_gatewayStore.isShowLoading,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: DeviceUtils.getScaledHeight(context, 0.2)),
                    Image.asset('assets/images/ai_cms.png', height: 40),
                    const SizedBox(height: 30),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromRGBO(37, 38, 43, 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 22),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor: Color.fromRGBO(42, 43, 49, 1),
                                value: _gatewayStore.gateway.protocol,
                                isDense: true,
                                onChanged: (value) {
                                  setState(() {
                                    _gatewayStore.gateway.protocol = value;
                                  });
                                },
                                items: listProtocols.map((String value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value.toLowerCase(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const Text(
                            "|",
                            style: TextStyle(
                              color: AppColors.hintColor,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: FormTextFieldWidget(
                              placeholder:
                                  "${Translate.getString("manage_device.domain", context)}:${Translate.getString("manage_device.port", context)}",
                              initialValue: _gatewayStore.gateway.domainName,
                              onChanged: (value) =>
                                  _gatewayStore.gateway.domainName = value,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromRGBO(37, 38, 43, 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 51,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            "|",
                            style: TextStyle(
                              color: AppColors.hintColor,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: FormTextFieldWidget(
                              placeholder: Translate.getString(
                                  "start.user_name", context),
                              initialValue: _gatewayStore.gateway.username,
                              onChanged: (value) =>
                                  _gatewayStore.gateway.username = value,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromRGBO(37, 38, 43, 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 51,
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.lock,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            "|",
                            style: TextStyle(
                              color: AppColors.hintColor,
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: FormTextFieldWidget(
                              placeholder:
                                  "${Translate.getString("manage_device.password", context)}",
                              isObscure: _obscureText,
                              initialValue: _gatewayStore.gateway.password,
                              onChanged: (value) =>
                                  _gatewayStore.gateway.password = value,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: FloatingActionButton.extended(
                        onPressed: _onLogin,
                        backgroundColor: Colors.blue,
                        label: Text(
                          Translate.getString("start.login", context),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Future readSecureData(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }

  Future<String> getUrl() async {
    String username = '91e9acf6-6920-4904-99ad-75ca024b1abc';
    String password = 'ARJoLB7PELQepF4TPX3rdyd5Kh6n8PPY2k7PrsQ0';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final respone = await http.post(
      Uri.parse('https://vms.hcdt.vn:20003/vms/api/host/login'),
      body: {"user": "admin", "pass": "admin123"},
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        "authorization": basicAuth
      },
    );
    String urllink = json.decode(respone.body)["gis_url"];
    String token = ParseStirng.QueryString.parse(urllink).values.toList()[4];
    String gisurl = "https://vms.hcdt.vn:20003/portal/dashboards/camera/home/?view=map&client=cmsm&layout=default&hl=vi&token=${token}";
    secureStorage.writeSecureData('urlGis', gisurl);
    stores.StoreUrlGis.urlgis = gisurl;
    return gisurl;
  }
  _onLogin() async {
    getUrl().then((value) =>print("Linkgis : "+value));
    DeviceUtils.hideKeyboard(context);
    _gatewayStore.validateForm();
    if (_gatewayStore.isInvalidForm) {
      _showErrorMessage(
          Translate.getString(_gatewayStore.errorStore.errorMessage, context));
      return;
    }
    Loader.show(context, progressIndicator: CustomProgressIndicatorWidget());
    _gatewayStore.isShowLoading = true;
    String domainName = _gatewayStore.gateway.domainName;
    if (domainName.contains(":")) {
      _gatewayStore.gateway.domainName = domainName.split(":")[0] ?? "";
      _gatewayStore.gateway.port = domainName.split(":")[1] ?? "";
    }
    final response = await _gatewayStore.loginToVms(_gatewayStore.gateway);
    if (_gatewayStore.loginSuccess) {
      getUrl().then((value) =>print("gis"+value));
      _gatewayStore.gateway.token = response["access_token"];
      _gatewayStore.gateway.accessTokenExpiredTime =
          response["access_token_expires"];
      _gatewayStore.gateway.refreshToken = response["refresh_token"];
      _gatewayStore.gateway.refreshTokenExpiredTime =
          response["refresh_token_expires"];
      _gatewayStore.gateway.root = true;
      await _gatewayStore.addOrUpdate(_gatewayStore.gateway);
      _homeStore.navigateFromLogin = true;
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.splash, (Route<dynamic> route) => false);
    } else
      _showErrorMessage(_gatewayStore.errorStore.errorMessage);
    Loader.hide();
    _gatewayStore.isShowLoading = false;
  }

  _showErrorMessage(String message) {
    showCupertinoDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData.dark(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(
                    title: Text(
                        Translate.getString("manage_device.warning", context)),
                    content: Text(Translate.getString(message, context)),
                    actions: [
                      CupertinoDialogAction(
                          child: Text(Translate.getString(
                              "manage_device.close", context)),
                          onPressed: () => Navigator.pop(context))
                    ]),
              ),
            ));
  }
}
