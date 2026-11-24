import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/report_item_provider.dart';
import 'widgets/report_type_selector.dart';
import 'widgets/item_information_form.dart';
import 'widgets/item_image_picker.dart';
import 'widgets/handover_point_field.dart';
import 'widgets/report_submit_button.dart';

class ReportItemScreen extends ConsumerStatefulWidget {
  const ReportItemScreen({super.key});

  @override
  ConsumerState<ReportItemScreen> createState() => _ReportItemScreenState();
}

class _ReportItemScreenState extends ConsumerState<ReportItemScreen> {
  final _formKey = GlobalKey<FormState>();

  void _validateForm() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form validated. Ready for submission integration.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final report = ref.watch(reportItemProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Report an Item'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Help reunite items with their owners.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              const ReportTypeSelector(),

              const SizedBox(height: 24),

              const Text(
                'Item Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              const ItemInformationForm(),

              const SizedBox(height: 24),

              const ItemImagePicker(),

              const SizedBox(height: 24),

              const HandoverPointField(),

              const SizedBox(height: 32),

              ReportSubmitButton(
                isSubmitting: report.isSubmitting,
                onPressed: _validateForm,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
