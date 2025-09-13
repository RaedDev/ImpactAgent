import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@NowaGenerated()
class SupabaseService {
  SupabaseService._();

  factory SupabaseService() {
    return _instance;
  }

  static final SupabaseService _instance = SupabaseService._();

  Future initialize() async {
    await Supabase.initialize(
      url: 'https://stvtssohwvqobxojjzmm.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN0dnRzc29od3Zxb2J4b2pqem1tIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ3NDUxMTMsImV4cCI6MjA3MDMyMTExM30.R6DNZ25nodb7dSvDK3lUW40Rm0F9J1h_HL2qzK6wFsw',
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp(String email, String password) async {
    return Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  Future<Map<String, dynamic>> callOpenAICompletion({
    required String prompt,
    String? model,
    int? maxTokens,
    double? temperature,
  }) async {
    try {
      final Map<String, dynamic> body = {'prompt': prompt};
      if (model != null) {
        body['model'] = model;
      }
      if (maxTokens != null) {
        body['max_tokens'] = maxTokens;
      }
      if (temperature != null) {
        body['temperature'] = temperature;
      }
      final response = await Supabase.instance.client.functions.invoke(
        'openai-completion',
        body: body,
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to call OpenAI completion: ${e}');
    }
  }

  Future<String> getCompletion(String prompt) async {
    try {
      final response = await callOpenAICompletion(prompt: prompt);
      return response['completion'] ?? response['message'] ?? '';
    } catch (e) {
      throw Exception('Failed to get completion: ${e}');
    }
  }
}
