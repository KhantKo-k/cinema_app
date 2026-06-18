import 'package:flutter/material.dart';


class EditProfilePage extends StatefulWidget {
  final dynamic profile; 

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _phoneController = TextEditingController(text: widget.profile.phone.toString());
    _addressController = TextEditingController(text: widget.profile.address ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: cs.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Edit Profile", style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Trigger Update Logic (Riverpod/Bloc)
              Navigator.pop(context);
            },
            child: Text("Save", style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar Placeholder with Edit Icon
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: cs.secondaryContainer,
                    child: Text(
                      widget.profile.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 40, color: cs.onSecondaryContainer),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: cs.primary,
                      child: Icon(Icons.camera_alt_outlined, size: 18, color: cs.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Form Fields
            _buildEditField("Full Name", _nameController, Icons.person_outline),
            const SizedBox(height: 20),
            _buildEditField("Phone Number", _phoneController, Icons.phone_android_outlined),
            const SizedBox(height: 20),
            _buildEditField("Address", _addressController, Icons.location_on_outlined, maxLines: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildEditField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    final cs = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(color: cs.onSurface),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: cs.primary, size: 20),
            filled: true,
            fillColor: cs.surfaceContainerHighest.withOpacity(0.3),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.outlineVariant.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: cs.primary),
            ),
          ),
        ),
      ],
    );
  }
}