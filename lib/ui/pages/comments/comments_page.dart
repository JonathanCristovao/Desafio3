import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    // widget.presenter.loadPersons();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Criar postagem'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          //  child: Padding(
          //  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: const [
                          CircleAvatar(),
                          SizedBox(
                            width: 5,
                          ),
                          Text(" Nome do usuario"),
                        ],
                      )),
                ),
                Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: TextFormField(
                    minLines:
                        10, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,

                    focusNode: _focusNode,

                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione o texto da sua postagem',
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 70,
                  child: ElevatedButton(
                    child: const Text("Publicar"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
