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
    @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Simuler un délai d'envoi
    await Future.delayed(const Duration(seconds: 1));

    final formData = ContactFormData(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      message: _messageController.text,
    );

    widget.onSubmit(formData);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre
            const Text(
              'Informations de contact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

