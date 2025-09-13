import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class RunN8nModel {
  @NowaGenerated({'loader': 'auto-constructor'})
  const RunN8nModel({this.output});

  @NowaGenerated({'loader': 'auto-from-json'})
  factory RunN8nModel.fromJson({required Map<String, dynamic> json}) {
    return RunN8nModel(output: json['output']);
  }

  final String? output;

  @NowaGenerated({'loader': 'auto-to-json'})
  Map<String, dynamic> toJson() {
    return {'output': output};
  }
}
