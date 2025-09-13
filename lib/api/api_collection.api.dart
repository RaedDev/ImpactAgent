import 'package:dio/dio.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:impactagent/models/run_n8n_model.dart';

@NowaGenerated({'editor': 'api'})
class ApiCollection {
  factory ApiCollection() {
    return _instance;
  }

  ApiCollection._();

  final Dio _dioClient = Dio();

  @NowaGenerated({'loader': 'api_client_getter'})
  Dio get dioClient {
    return _dioClient;
  }

  static final ApiCollection _instance = ApiCollection._();

  Future<Response<dynamic>> newRequest() async {
    final Response res = await dioClient.post(
      'https://impactagent.app.n8n.cloud/webhook-test/644455e8-123d-4102-be3f-5ca85f7f333f',
      data: '{\n  "message": "hi"\n}',
      options: Options(contentType: 'application/json'),
    );
    return res;
  }

  Future<RunN8nModel?> runN8n({
    String? prompt = '',
    String? sessionId = '',
  }) async {
    final Response res = await dioClient.post(
      'https://impactagent.app.n8n.cloud/webhook/545e9747-152d-4d8c-8b7d-e117635ddc92',
      data: '{\n  "prompt": "${prompt}",\n  "sessionId": "${sessionId}"\n}',
      options: Options(contentType: 'application/json'),
    );
    return RunN8nModel.fromJson(json: res.data!);
  }
}
