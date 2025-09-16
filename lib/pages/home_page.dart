import 'package:flutter/material.dart';
import 'package:impactagent/chat_message.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:impactagent/models/run_n8n_model.dart';
import 'package:impactagent/api/api_collection.api.dart';
import 'package:impactagent/pages/projects_page.dart';

@NowaGenerated()
class HomePage extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

@NowaGenerated()
class _HomePageState extends State<HomePage> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];

  final String _sessionId = DateTime.now().millisecondsSinceEpoch.toString();

  bool _isLoading = false;

  int _currentIndex = 0;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(
        ChatMessage(text: message, isAgent: false, timestamp: DateTime.now()),
      );
      _isLoading = true;
    });
    _messageController.clear();
    _scrollToBottom();
    try {
      final response = await ApiCollection().runN8n(
        prompt: message,
        sessionId: _sessionId,
      );
      setState(() {
        _messages.add(
          ChatMessage(
            text:
                response?.output ?? 'Sorry, I couldn\'t process your request.',
            isAgent: true,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: 'Sorry, something went wrong. Please try again.',
            isAgent: true,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
    }
    _scrollToBottom();
  }

  Widget _buildMessage(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: message.isAgent
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message.isAgent) ...[
            CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.blue.shade100,
              child: Icon(
                Icons.smart_toy,
                size: 18.0,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 8.0),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: message.isAgent
                    ? Colors.grey.shade100
                    : Colors.blue.shade500,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isAgent ? Colors.black87 : Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          if (!message.isAgent) ...[
            const SizedBox(width: 8.0),
            CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.green.shade100,
              child: Icon(
                Icons.person,
                size: 18.0,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? 'AI Chat' : 'Projects',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0.0,
      ),
      body: _currentIndex == 0
          ? Column(
              children: [
                Expanded(
                  child: _messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64.0,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Start a conversation!',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Type a message below to begin',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: _messages.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _messages.length && _isLoading) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16.0,
                                      backgroundColor: Colors.blue.shade100,
                                      child: Icon(
                                        Icons.smart_toy,
                                        size: 18.0,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(
                                          20.0,
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          SizedBox(
                                            width: 20.0,
                                            height: 20.0,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                          SizedBox(width: 12.0),
                                          Text('Thinking...'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return _buildMessage(_messages[index]);
                          },
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0.0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.blue.shade500,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 12.0,
                            ),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade500,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: _isLoading ? null : _sendMessage,
                          icon: const Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const ProjectsPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade600,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.white,
        elevation: 8.0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Projects'),
        ],
      ),
    );
  }
}
