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
class _ContactFormState extends State<ContactForm> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _messageController;
  
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.initialFirstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.initialLastName ?? '',
    );
    _emailController = TextEditingController(
      text: widget.initialEmail ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.initialPhone ?? '',
    );
    _messageController = TextEditingController();
  }
