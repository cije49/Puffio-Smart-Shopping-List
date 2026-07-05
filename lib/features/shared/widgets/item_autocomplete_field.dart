import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/app_providers.dart';

/// Reusable text field with live autocomplete from ItemHistory.
///
/// - Supports multi-item input (commas and newlines). Only the last token
///   after a comma/newline is used to drive suggestions.
/// - Tapping a suggestion replaces that last token with the full item name.
/// - Submitting (Enter or tapping the Add button) calls [onSubmit] with the
///   full raw text so the caller can split and add.
class ItemAutocompleteField extends ConsumerStatefulWidget {
  final String hintText;
  final String submitLabel;
  final Future<void> Function(String rawText) onSubmit;
  final TextEditingController? externalController;

  const ItemAutocompleteField({
    super.key,
    required this.hintText,
    required this.submitLabel,
    required this.onSubmit,
    this.externalController,
  });

  @override
  ConsumerState<ItemAutocompleteField> createState() =>
      _ItemAutocompleteFieldState();
}

class _ItemAutocompleteFieldState
    extends ConsumerState<ItemAutocompleteField> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlay;

  @override
  void initState() {
    super.initState();
    _controller = widget.externalController ?? TextEditingController();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) _removeOverlay();
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.removeListener(_onTextChanged);
    if (widget.externalController == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Suggestion logic
  // ---------------------------------------------------------------------------

  /// The text AFTER the last comma or newline — what we search on.
  String get _lastToken {
    final text = _controller.text;
    final idx = text.lastIndexOf(RegExp(r'[,\n]'));
    return idx == -1 ? text : text.substring(idx + 1);
  }

  Future<void> _onTextChanged() async {
    final token = _lastToken.trim();
    if (token.isEmpty) {
      _removeOverlay();
      return;
    }
    final results = await ref
        .read(itemHistoryRepoProvider)
        .searchByPrefix(token, limit: 6);
    if (!mounted) return;
    if (results.isEmpty) {
      _removeOverlay();
    } else {
      _showOverlay(results.map((h) => h.displayName).toList());
    }
  }

  void _pickSuggestion(String suggestion) {
    final text = _controller.text;
    final idx = text.lastIndexOf(RegExp(r'[,\n]'));
    final newText = idx == -1
        ? suggestion
        : '${text.substring(0, idx + 1)} $suggestion';
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
    _removeOverlay();
  }

  // ---------------------------------------------------------------------------
  // Overlay (suggestion dropdown)
  // ---------------------------------------------------------------------------

  void _showOverlay(List<String> suggestions) {
    _removeOverlay();
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlay = OverlayEntry(
      builder: (ctx) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 240),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: suggestions.length,
                itemBuilder: (_, i) => ListTile(
                  dense: true,
                  leading: const Icon(Icons.history, size: 20),
                  title: Text(suggestions[i]),
                  onTap: () => _pickSuggestion(suggestions[i]),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlay!);
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  // ---------------------------------------------------------------------------
  // Submit
  // ---------------------------------------------------------------------------

  Future<void> _handleSubmit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _removeOverlay();
    await widget.onSubmit(text);
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                prefixIcon: const Icon(Icons.add_shopping_cart_outlined),
              ),
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: FilledButton(
              onPressed: _handleSubmit,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
              ),
              child: Text(widget.submitLabel),
            ),
          ),
        ],
      ),
    );
  }
}
