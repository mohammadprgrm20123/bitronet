abstract class BaseEnv {
  String getBaseUrl();

  String getVersion();
}

class ProductionEnv extends BaseEnv {
  String baseUrl = 'http://bitwork.bitronet.ir/api';
  String version = '';

  @override
  String getBaseUrl() => baseUrl;

  @override
  String getVersion() => version;
}

class StageEnv extends BaseEnv {
  String baseUrl = '';
  String version = '';
  @override
  String getBaseUrl() => baseUrl;

  @override
  String getVersion() => version;

}
