import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_enums.dart';
import '../../../../core/utils/app_extensions.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailController;
  late TextEditingController _messageController;
  late TextEditingController _nameController;
  late TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    _nameController = TextEditingController();
    _subjectController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    _nameController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState?.validate() ?? false) {
      final body = '''
From: ${_nameController.text}
Email: ${_emailController.text}

Message:
${_messageController.text}
    ''';
    
      final emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'osimiloluwa9@gmail.com',
        queryParameters: {
          'subject': _subjectController.text,
          'body': body,
        },
      );

      try {
        if (await canLaunchUrl(emailLaunchUri)) {
          await launchUrl(emailLaunchUri);
          _formKey.currentState?.reset();
          _showSuccessMessage();
        } else {
          // Fallback for web
          final webEmailUrl = 'mailto:osimiloluwa9@gmail.com?subject=${Uri.encodeComponent(_subjectController.text)}&body=${Uri.encodeComponent(body)}';
          if (await canLaunchUrl(Uri.parse(webEmailUrl))) {
            await launchUrl(Uri.parse(webEmailUrl));
            _formKey.currentState?.reset();
            _showSuccessMessage();
          } else {
            _showErrorMessage('Could not open email client. Please try again.');
          }
        }
      } catch (e) {
        _showErrorMessage('Error: ${e.toString()}');
      }
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email client opened successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
      ),
    );
  }

  void _showErrorMessage([String? message]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? 'Could not open email client'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getFormWidth(context.width),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'E-mail'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _subjectController,
              style: AppStyles.s14,
              decoration: const InputDecoration(labelText: 'Subject'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              style: AppStyles.s14,
              decoration: const InputDecoration(
                labelText: 'Type a message here...',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a message';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              label: 'Send Message',
              onPressed: _sendEmail,
              backgroundColor: AppColors.primaryColor,
              width: _getFormWidth(context.width),
            ),
          ],
        ),
      ),
    );
  }

  double _getFormWidth(double deviceWidth) {
    if (deviceWidth < DeviceType.mobile.getMaxWidth()) {
      return deviceWidth;
    } else if (deviceWidth < DeviceType.ipad.getMaxWidth()) {
      return deviceWidth / 1.6;
    } else if (deviceWidth < DeviceType.smallScreenLaptop.getMaxWidth()) {
      return deviceWidth / 2;
    } else {
      return deviceWidth / 2.5;
    }
  }
}
