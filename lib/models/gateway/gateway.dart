class Gateway {
  int id;
  String name;
  String domainName;
  String protocol;
  String port;
  String username;
  String password;
  int totalCamera;
  String token;
  bool root;
  String refreshToken;
  int refreshTokenExpiredTime;
  int accessTokenExpiredTime;

  Gateway({
    this.id,
    this.name,
    this.domainName,
    this.port,
    this.username,
    this.totalCamera,
    this.token,
    this.protocol,
    this.password,
    this.root,
    this.refreshToken,
    this.refreshTokenExpiredTime,
    this.accessTokenExpiredTime,
  });

  Gateway.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    domainName = json['domainName'];
    port = json['port'];
    username = json['username'];
    password = json['password'];
    totalCamera = json['totalCamera'];
    token = json['token'];
    protocol = json['protocol'];
    root = json['root'];
  }

  Gateway.fromApi(Map<String, dynamic> json) {
    name = json['Name'];
    domainName = json['Hostname'];
    port = json['Port'].toString();
    username = json['Username'];
    protocol = json['Protocol'];
    root = json['root'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['domainName'] = this.domainName;
    data['port'] = this.port;
    data['username'] = this.username;
    data['password'] = this.password;
    data['totalCamera'] = this.totalCamera;
    data['token'] = this.token;
    data['protocol'] = this.protocol;
    data['root'] = this.root;
    return data;
  }
}
