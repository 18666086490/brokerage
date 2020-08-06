import 'package:brokerage/application/notes/note_form/note_form_bloc.dart';
import 'package:brokerage/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BodyField extends HookWidget {
  const BodyField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textEditingController = useTextEditingController();

    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state) {
        // In case of an initial data failure... We can't get to this point though.
        textEditingController.text = state.note.body.getOrCrash();
      },
      buildWhen: (p, c) => p.note.body != c.note.body,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              labelText: '便签内容',
              counterText: '',
            ),
            maxLength: NoteBody.maxLength,
            maxLengthEnforced: true,
            maxLines: null,
            minLines: 5,
            onChanged: (value) => context
                .bloc<NoteFormBloc>()
                .add(NoteFormEvent.bodyChanged(value)),
            validator: (_) =>
                context.bloc<NoteFormBloc>().state.note.body.value.fold(
                      (f) => f.maybeMap(
                        empty: (f) => '不能为空',
                        exceedingLength: (f) => '超出字符限制, 最大: ${f.max}',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
        );
      },
    );
  }
}
