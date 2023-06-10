import 'package:flutter/material.dart';
import 'package:flutter_cases/case_4/view/components/DropDownAlunoCurso.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// ignore: must_be_immutable
class FormCadastroAluno extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeAlunoController;
  final TextEditingController cursoAlunoController;
  final TextEditingController turmaAlunoController;
  final TextEditingController celularAlunoController;
  final TextEditingController raAlunoController;
  final TextEditingController senhaAlunoController;
  late bool? senhaVisivel = true;

  FormCadastroAluno({
    Key? key,
    required this.formKey,
    required this.nomeAlunoController,
    required this.cursoAlunoController,
    required this.turmaAlunoController,
    required this.celularAlunoController,
    required this.raAlunoController,
    required this.senhaAlunoController,
    this.senhaVisivel,
  }) : super(key: key);

  @override
  _FormCadastroAlunoState createState() => _FormCadastroAlunoState();
}

class _FormCadastroAlunoState extends State<FormCadastroAluno> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nomeAlunoController;
  late TextEditingController _cursoAlunoController;
  late TextEditingController _turmaAlunoController;
  late TextEditingController _celularAlunoController;
  late TextEditingController _raAlunoController;
  late TextEditingController _senhaAlunoController;
  late bool? _senhaVisivel;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formKey;
    _nomeAlunoController = widget.nomeAlunoController;
    _cursoAlunoController = widget.cursoAlunoController;
    _turmaAlunoController = widget.turmaAlunoController;
    _celularAlunoController = widget.celularAlunoController;
    _raAlunoController = widget.raAlunoController;
    _senhaAlunoController = widget.senhaAlunoController;
    _senhaVisivel = widget.senhaVisivel ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nomeAlunoController,
            decoration: InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Nome é obrigatório.';
              }
              return null;
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: DropDownCursos(
              cursoEscolhido:
                  _cursoAlunoController.text, // Passa o valor do controlador
              onChanged: (String? value) {
                setState(() {
                  _cursoAlunoController.text =
                      value ?? ''; // Atualiza o valor do controlador
                });
              },
            ),
          ),
          TextFormField(
            controller: _turmaAlunoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Turma'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Turma é obrigatório.';
              }
              return null;
            },
            maxLength: 2,
          ),
          TextFormField(
            controller: _celularAlunoController,
            keyboardType: TextInputType.number,
            inputFormatters: [MaskTextInputFormatter(mask: "(##)#####-####")],
            decoration: InputDecoration(labelText: 'Celular'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Celular é obrigatório.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _raAlunoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'RA'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo RA é obrigatório.';
              }
              return null;
            },
            maxLength: 6,
          ),
          Visibility(
              visible: _senhaVisivel!,
              child: TextFormField(
                controller: _senhaAlunoController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'O Senha RA é obrigatório.';
                  }
                  if (value.length < 6) {
                    return 'A senha deve possuir no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ))
        ],
      ),
    );
  }
}

class FormCadastroAluno2 extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController nomeAlunoController;
  final TextEditingController cursoAlunoController;
  final TextEditingController turmaAlunoController;
  final TextEditingController celularAlunoController;
  final TextEditingController raAlunoController;
  final TextEditingController senhaAlunoController;

  FormCadastroAluno2({
    Key? key,
    required this.formKey,
    required this.nomeAlunoController,
    required this.cursoAlunoController,
    required this.turmaAlunoController,
    required this.celularAlunoController,
    required this.raAlunoController,
    required this.senhaAlunoController,
  }) : super(key: key);

  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nomeAlunoController,
            decoration: InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Nome é obrigatório.';
              }
              return null;
            },
          ),
          DropDownCursos(
            onChanged: (value) {
              cursoAlunoController.text = value!;
            },
          ),
          TextFormField(
            controller: turmaAlunoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Turma'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Turma é obrigatório.';
              }
              return null;
            },
            maxLength: 2,
          ),
          TextFormField(
            controller: celularAlunoController,
            keyboardType: TextInputType.number,
            inputFormatters: [MaskTextInputFormatter(mask: "(##)#####-####")],
            decoration: InputDecoration(labelText: 'Celular'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo Celular é obrigatório.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: raAlunoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'RA'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O campo RA é obrigatório.';
              }
              return null;
            },
            maxLength: 6,
          ),
          TextFormField(
            controller: senhaAlunoController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Senha'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'O Senha RA é obrigatório.';
              }
              if (value.length < 6) {
                return 'A senha deve possuir no mínimo 6 caracteres.';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}

class TextFormFieldObrigatorio extends StatelessWidget {
  final TextEditingController controllerField;
  final String nomeCampo;

  TextFormFieldObrigatorio({
    Key? key,
    required this.controllerField,
    required this.nomeCampo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerField,
      decoration: InputDecoration(labelText: nomeCampo),
      validator: (value) {
        if (value!.isEmpty) {
          return 'O campo $nomeCampo é obrigatório.';
        }
        return null;
      },
    );
  }
}
