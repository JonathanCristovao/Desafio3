import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmidia/domain/entities/entities.dart';
import 'package:socialmidia/presentation/presenters/presenter.dart';
import 'package:socialmidia/ui/pages/comments/comments_page.dart';

import '../pages.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;

  const HomePage({Key? key, required this.presenter}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);

    // widget.presenter.loadPersons();
    widget.presenter.remoteLoadUsers();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.presenter.loadPersons();
    }
    debugPrint('AppLifecycleState: $state');
  }

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Feed'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            final logoutStatus = await widget.presenter.logout();
            if (logoutStatus == true) {
              Get.offAllNamed('/login');
            }
          },
          icon: Icon(
            Icons.logout_rounded,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
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
                        children: [
                          const CircleAvatar(),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            child: const Text("Adicione uma postagem"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CommentPage(),
                                  ));
                            },
                          ),
                        ],
                      )),
                ),
                Container(
                    height: 120,
                    color: Colors.grey[350],
                    padding: const EdgeInsets.fromLTRB(0, 80, 50, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.grey[850],
                            )),
                        const Text("Likes"),
                        IconButton(
                            onPressed: () {
                              _focusNode.requestFocus();
                            },
                            icon: Icon(
                              Icons.comment,
                              color: Colors.grey[850],
                            )),
                        const Text("Comments"),
                      ],
                    )),
                Expanded(
                  child: StreamBuilder<List<PersonEntity>>(
                    stream: widget.presenter.peopleStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 16.0),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(snapshot.data![index].name),
                            trailing: IconButton(
                              onPressed: () => widget.presenter.remoteAddUser(
                                  name: snapshot.data![index].name),
                              icon: Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Nenhum resultado encontrado!'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                Container(
                  height: 60,
                  color: Colors.grey[350],
                  child: TextFormField(
                    focusNode: _focusNode,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: 200,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.photo_size_select_actual_outlined,
                      color: Colors.grey[850],
                    )),
                const Text("Feed"),
              ],
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CommentPage(),
                          ));
                    },
                    icon: Icon(
                      Icons.add_circle_outlined,
                      color: Colors.grey[850],
                    )),
                const Text("Post"),
              ],
            ),
            Column(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              presenter: StreamProfilePresenter(),
                            ),
                          ));
                    },
                    icon: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.grey[850],
                    )),
                const Text("Perfil"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
