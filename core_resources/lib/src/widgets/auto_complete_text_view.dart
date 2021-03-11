import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

typedef OnTapCallback = void Function(String value);

///Credits to [sharansingh00002](https://github.com/sharansingh00002/Auto-Complete-TextField-Flutter)
class AutoCompleteTextView extends StatefulWidget with AutoCompleteTextInterface {
  final double maxHeight;
  final TextEditingController controller;

  //AutoCompleteTextField properties
  final Color? tfCursorColor;
  final double tfCursorWidth;
  final FormFieldValidator<String>? tfValidator;
  final TextStyle tfStyle;
  final InputDecoration tfTextDecoration;
  final TextAlign tfTextAlign;

  //Suggestiondrop Down properties
  final TextStyle suggestionStyle;
  final TextAlign suggestionTextAlign;
  final OnTapCallback? onTapCallback;
  final FutureOr<List<String>> Function(String query) getSuggestionsMethod;
  final Function? focusGained;
  final Function? focusLost;
  final int suggestionsApiFetchDelay;
  final void Function(String)? onValueChanged;

  AutoCompleteTextView(
      {required this.controller,
      this.onTapCallback,
      this.maxHeight = 200,
      this.tfCursorColor,
      this.tfCursorWidth = 2.0,
      this.tfValidator,
      this.tfStyle = const TextStyle(color: Colors.black),
      this.tfTextDecoration = const InputDecoration(),
      this.tfTextAlign = TextAlign.left,
      this.suggestionStyle = const TextStyle(color: Colors.black),
      this.suggestionTextAlign = TextAlign.left,
      required this.getSuggestionsMethod,
      this.focusGained,
      this.suggestionsApiFetchDelay = 0,
      this.focusLost,
      this.onValueChanged});

  @override
  _AutoCompleteTextViewState createState() => _AutoCompleteTextViewState();

  //This funciton is called when a user clicks on a suggestion
  @override
  void onTappedSuggestion(String suggestion) => onTapCallback?.call(suggestion);
}

class _AutoCompleteTextViewState extends State<AutoCompleteTextView> {
  ScrollController scrollController = ScrollController();
  final _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final _layerLink = LayerLink();
  final suggestionsStreamController = BehaviorSubject<List<String>>();
  List<String> suggestionShowList = <String>[];
  Timer? _debounce;
  bool isSearching = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context)?.insert(_overlayEntry);
        widget.focusGained?.call();
      } else {
        _overlayEntry.remove();
        widget.focusLost?.call();
      }
    });
    widget.controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: widget.suggestionsApiFetchDelay), () {
      if (isSearching == true) {
        _getSuggestions(widget.controller.text);
      }
    });
  }

  Future<void> _getSuggestions(String data) async {
    if (data.isNotEmpty) {
      final list = await widget.getSuggestionsMethod(data);
      suggestionsStreamController.sink.add(list);
    }
  }

  OverlayEntry _createOverlayEntry() {
    // ignore: avoid_as
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 5.0),
                child: Material(
                  elevation: 4.0,
                  child: StreamBuilder<List<String>>(
                      stream: suggestionsStreamController.stream,
                      builder: (context, suggestionData) {
                        if (suggestionData.hasData && widget.controller.text.isNotEmpty) {
                          suggestionShowList = suggestionData.data ?? [];
                          return ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 200,
                            ),
                            child: ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: suggestionShowList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      suggestionShowList[index],
                                      style: widget.suggestionStyle,
                                      textAlign: widget.suggestionTextAlign,
                                    ),
                                    onTap: () {
                                      isSearching = false;
                                      widget.controller.text = suggestionShowList[index];
                                      suggestionsStreamController.sink.add([]);
                                      widget.onTappedSuggestion(widget.controller.text);
                                    },
                                  );
                                }),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        controller: widget.controller,
        decoration: widget.tfTextDecoration,
        style: widget.tfStyle,
        cursorColor: widget.tfCursorColor,
        cursorWidth: widget.tfCursorWidth,
        textAlign: widget.tfTextAlign,
        focusNode: _focusNode,
        validator: widget.tfValidator,
        onChanged: (text) {
          if (text.trim().isNotEmpty) {
            widget.onValueChanged?.call(text);
            isSearching = true;
            scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          } else {
            isSearching = false;
            suggestionsStreamController.sink.add([]);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    suggestionsStreamController.close();
    scrollController.dispose();
    widget.controller.dispose();
    super.dispose();
  }
}

abstract class AutoCompleteTextInterface {
  void onTappedSuggestion(String suggestion);
}
