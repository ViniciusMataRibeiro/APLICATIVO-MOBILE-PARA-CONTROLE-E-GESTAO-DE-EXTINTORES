import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alertas {

  static SnackBar alertaSucess(String titulo, String mensagem) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: titulo,
        message: mensagem,

        contentType: ContentType.success,
      ),
    );

    return snackBar;
  }

  static SnackBar alertaError(String titulo, String mensagem) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: titulo,
        message: mensagem,

        contentType: ContentType.failure,
      ),
    );

    return snackBar;
  }

  static SnackBar alertahelp(String titulo, String mensagem) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: titulo,
        message: mensagem,

        contentType: ContentType.help,
      ),
    );

    return snackBar;
  }

  static SnackBar alerta(String titulo, String mensagem) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: titulo,
        message: mensagem,

        contentType: ContentType.warning,
      ),
    );

    return snackBar;
  }
}
