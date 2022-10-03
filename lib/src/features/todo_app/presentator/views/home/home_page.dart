import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../blocs/auth_cubit/auth_cubit.dart';
import '../../blocs/note_cubit/note_cubit.dart';
import '../../consts/utils/app_consts.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minhas Notas ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).signOut();
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addNotePage,
              arguments: widget.uid);
        },
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoadedState) {
            return _bodyWidget(state);
          } else if (state is NoteLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
              child: Text("Algo deu muito errado!"),
            );
          }
        },
      ),
    );
  }

  Widget _noNotesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text("Ainda não tem notas!"),
        ],
      ),
    );
  }

  Widget _bodyWidget(NoteLoadedState noteLoadedState) {
    return Column(
      children: [
        Expanded(
          child: noteLoadedState.notes.isEmpty
              ? _noNotesWidget()
              : GridView.builder(
                  itemCount: noteLoadedState.notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.updateNotePage,
                            arguments: noteLoadedState.notes[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Deletar Nota"),
                              content: const Text(
                                  "Você tem certeza que quer deletar a nota?"),
                              actions: [
                                TextButton(
                                  child: const Text("Deletar"),
                                  onPressed: () {
                                    BlocProvider.of<NoteCubit>(context)
                                        .deleteNote(
                                            note: noteLoadedState.notes[index]);
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text("Não"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.2),
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 1.5))
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${noteLoadedState.notes[index].note}",
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                                "${DateFormat("dd MMM yyy hh:mm a").format(noteLoadedState.notes[index].time!.toDate())}")
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
