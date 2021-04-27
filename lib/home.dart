import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pizza_printer_party/secrets.dart';

class PizzaPartyHome extends StatefulWidget {
  const PizzaPartyHome({Key key}) : super(key: key);

  @override
  _PizzaPartyHomeState createState() => _PizzaPartyHomeState();
}

class _PizzaPartyHomeState extends State<PizzaPartyHome> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print a message'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.loose(Size(400, 400)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autocorrect: true,
                  autofocus: true,
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    fillColor: Colors.white,
                    filled: true,
                    helperMaxLines: 10,
                    helperStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    helperText: '''
Letters, numbers, spaces, and multiple lines allowed.
No Emoji, though. 😞''',
                  ),
                  maxLines: null,
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () =>
                      _printMessage(_textEditingController.value.text),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  child: Text('Print'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _printMessage(String message) {
    message = _prepare(message);

    return http
        .post(
            Uri(
              scheme: 'https',
              host: 'api.particle.io',
              path: '/v1/devices/$particleDeviceId/message',
            ),
            headers: {
              'Authorization': 'Bearer $particleApiKey',
            },
            body: {
              'arg': message,
            })
        .then((response) => print(response))
        .catchError(print);
  }

  String _prepare(String message) => message
      .replaceAll('’', "'")
      .replaceAll('‛', "'")
      .replaceAll('‘', "'")
      .replaceAll('“', '"')
      .replaceAll('”', '"')
      .replaceAll('„', '"')
      .replaceAll('≈', '~=')
      .replaceAll('≠', '!=')
      .replaceAll('‰', '%%')
      .replaceAll('§', 'Section')
      .replaceAll('«', '<<')
      .replaceAll('»', '>>')
      .replaceAll('…', '...')
      .replaceAll('•', '-')
      .replaceAll('¿', '?')
      .replaceAll('¡', '!')
      .replaceAll('–', '--')
      .replaceAll('—', '---');
}
