// ----- STRINGS ------
import 'package:flutter/material.dart';

const baseURL = 'http://192.168.100.8:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const registeradmURL = '$baseURL/registeradm';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const occorrenceURL = '$baseURL/occurrences';

// ----- Errors -----
const serverError = 'Erro do Servidor';
const unauthorized = 'Não autorizado';
const somethingWentWrong = 'Alguma coisa deu errado! tente novamente!';

// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    contentPadding: const EdgeInsets.all(10),
    border: const OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.black),
    ),
  );
}

// button
TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Text(label, style: const TextStyle(color: Colors.blue)),
          onTap: () => onTap())
    ],
  );
}

const kColorPrimary = Color(0xFF062a67);
const kColorRed = Color.fromARGB(255, 211, 0, 0);
const kColorPrimaryLight = Color(0xFF93AEDD);
const kColorWhite = Color(0xFFFFFFFF);

const kColorAlert = Color(0xFFffcc1a);

const btnText = TextStyle(
  fontSize: 18,
  color: kColorWhite,
  fontWeight: FontWeight.bold,
);
