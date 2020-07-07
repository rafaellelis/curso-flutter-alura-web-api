import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

bool featureItemMatcher(Widget widget, String titulo, IconData icone) {
  if (widget is FeatureItem) {
    return widget.titulo == titulo && widget.icone == icone;
  }
  return false;
}

bool textFieldMatcherByLabel(Widget widget, String labelText) {
  if(widget is TextField){
    return widget.decoration.labelText == labelText;
  }
  return false;
}

