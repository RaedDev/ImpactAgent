import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.isAgent,
    required this.timestamp,
  });

  final String text;

  final bool isAgent;

  final DateTime timestamp;
}
