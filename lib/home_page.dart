import 'package:chatbot/service/OpenAPIService.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final OpenAPIService openAPIService = OpenAPIService();
  bool _loading = false;
  final TextEditingController _controller = TextEditingController();
  String _response = "";
  Future<void> _sendMessage() async {
    //set loading state
    setState(() {
      _loading = true;
    });
    String prompt = _controller.text;
    if (prompt.isNotEmpty) {
      String aiResponse = await openAPIService.generateResponse(prompt);
      setState(() {
        _loading = false;
        _response = aiResponse;
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ask AI",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 31, 76, 202),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 31, 76, 202),
            Color.fromARGB(255, 91, 134, 229),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to 'Ask the AI'",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the start
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Enter your message',
                          filled: true,
                          fillColor: Colors
                              .white, // To contrast against the blue background
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_loading)
                        Text(
                          "Waiting for response....",
                          style: TextStyle(
                              color: Colors.white), // Text color on blue
                        )
                      else
                        ElevatedButton(
                          onPressed: _sendMessage,
                          child: Text('Send'),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 380,
                        height:
                            400, // Set the maximum height for the scrollable area
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(0.2), // Background for the text
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _response, // Display the response text
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
