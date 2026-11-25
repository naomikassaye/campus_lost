import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_lost/features/report_item/domain/models/report_item_enums.dart';
import 'package:campus_lost/features/report_item/presentation/providers/report_item_provider.dart';
import 'package:campus_lost/features/report_item/presentation/widgets/handover_point_field.dart';
import 'package:campus_lost/features/report_item/presentation/widgets/item_image_picker.dart';
import 'package:campus_lost/features/report_item/presentation/widgets/item_information_form.dart';
import 'package:campus_lost/features/report_item/presentation/widgets/report_submit_button.dart';
import 'package:campus_lost/features/report_item/presentation/widgets/report_type_selector.dart';

class ReportItemScreen extends ConsumerStatefulWidget {
  const ReportItemScreen({super.key});

  @override
  ConsumerState<ReportItemScreen> createState() => _ReportItemScreenState();
}

class _ReportItemScreenState extends ConsumerState<ReportItemScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _lastFormRevision = 0;

  void _prepareReport() {
    final notifier = ref.read(reportItemProvider.notifier);
    final report = ref.read(reportItemProvider);

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form.')),
      );
      return;
    }

    // A photo is mandatory when reporting a found item.
    if (report.reportType == ReportType.found && report.selectedImage == null) {
      notifier.setImageError('Please add a photo of the found item.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a photo before continuing.')),
      );
      return;
    }

    // The repository is not integrated yet.
    // Do not claim that the report has been saved.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Your report is valid. Submission will be available '
          'once the repository is integrated.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formRevision = ref.watch(
      reportItemProvider.select((state) => state.formRevision),
    );

    final isSubmitting = ref.watch(
      reportItemProvider.select((state) => state.isSubmitting),
    );

    // Recreate the Form when the provider is reset.
    if (formRevision != _lastFormRevision) {
      _lastFormRevision = formRevision;
      _formKey = GlobalKey<FormState>();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Report an Item'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help reunite items with their owners.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 24),

              const ReportTypeSelector(),

              const SizedBox(height: 24),

              Text(
                'Item Information',
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              const ItemInformationForm(),

              const SizedBox(height: 24),

              const ItemImagePicker(),

              const SizedBox(height: 24),

              const HandoverPointField(),

              const SizedBox(height: 32),

              ReportSubmitButton(
                isSubmitting: isSubmitting,
                onPressed: _prepareReport,
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
