import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialEmail;
  final String? initialPhone;
  final Function(ContactFormData) onSubmit;

  const ContactForm({
    Key? key,
    this.initialFirstName,
    this.initialLastName,
    this.initialEmail,
    this.initialPhone,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}
