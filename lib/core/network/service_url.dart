class ServiceUrl {
  static get _type => 'json/';

  static get _version => 'v1/';

  static get _key => '1/';

  static get _buildApiVersion => '$_type$_version$_key';

  static get list => '${_buildApiVersion}search.php?f=a';
}
