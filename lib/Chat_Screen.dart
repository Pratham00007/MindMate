import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gfonts;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _showEmojiPicker = false;
  late AnimationController _typingAnimationController;

  @override
  void initState() {
    super.initState();
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    setState(() {
      _messages.add(
        ChatMessage(
          text:
              "Hi there! I'm here to listen and support you. How are you feeling today? 💙",
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isTyping = true;
    });

    _messageController.clear();

    // Simulate AI response
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: _generateResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
    });
  }

  String _generateResponse(String userMessage) {
    final responses = [
      "I hear you, and your feelings are completely valid. Can you tell me more about what's on your mind? 🤗",
      "That sounds challenging. Remember, it's okay to feel overwhelmed sometimes. What would help you feel better right now? 💪",
      "Thank you for sharing that with me. You're being really brave by opening up. How long have you been feeling this way? 🌟",
      "I understand this is difficult for you. Let's work through this together. What support do you feel you need most? 💝",
      "Your mental health matters, and so do you. Have you tried any coping strategies that have helped you before? 🌈",
    ];
    return responses[DateTime.now().millisecond % responses.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF00BFA5),
                child: Text('🤖', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GG Assistant',
                  style: gfonts.GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Always here for you',
                  style: gfonts.GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          if (_showEmojiPicker)
            SizedBox(
              height: 300,
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  _messageController.text += emoji.emoji;
                },
                config: Config(
                  height: 256,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    columns: 7,
                    emojiSizeMax: 24.0,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    backgroundColor: const Color(0xFFF2F2F2),
                    recentsLimit: 28,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  categoryViewConfig: CategoryViewConfig(
                    initCategory: Category.RECENT,
                    backgroundColor: const Color(0xFFF2F2F2),
                    indicatorColor: const Color(0xFF00BFA5),
                    iconColor: Colors.grey,
                    iconColorSelected: const Color(0xFF00BFA5),
                    backspaceColor: const Color(0xFF00BFA5),
                  ),
                ),
              ),
            ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? const Color(0xFF00BFA5) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: gfonts.GoogleFonts.poppins(
                color: message.isUser ? Colors.white : const Color(0xFF2E3A47),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(message.timestamp),
              style: gfonts.GoogleFonts.poppins(
                color:
                    message.isUser
                        ? Colors.white.withOpacity(0.7)
                        : Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX();
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTypingDot(0),
            const SizedBox(width: 4),
            _buildTypingDot(1),
            const SizedBox(width: 4),
            _buildTypingDot(2),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return AnimatedBuilder(
      animation: _typingAnimationController,
      builder: (context, child) {
        final double animationValue =
            (_typingAnimationController.value - (index * 0.2)).clamp(0.0, 1.0);
        return Transform.translate(
          offset: Offset(
            0,
            -10 *
                (animationValue < 0.5
                    ? animationValue * 2
                    : (1 - animationValue) * 2),
          ),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF00BFA5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _showEmojiPicker ? Icons.keyboard : Icons.emoji_emotions_outlined,
              color: const Color(0xFF00BFA5),
            ),
            onPressed: () {
              setState(() {
                _showEmojiPicker = !_showEmojiPicker;
              });
            },
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF00BFA5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => _sendMessage(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _typingAnimationController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}