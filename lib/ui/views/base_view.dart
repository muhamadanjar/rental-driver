import 'package:driver/scope/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';


class BaseView<T extends Model> extends StatefulWidget {
  final ScopedModelDescendantBuilder<T> _builder;
  final Function(T) onModelReady;
  final Model model;

  BaseView({ScopedModelDescendantBuilder<T> builder, this.onModelReady,this.model})
      : _builder = builder;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Model> extends State<BaseView<T>> {

  @override
  void initState() {
    if(widget.onModelReady != null) {
      widget.onModelReady(widget.model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<T>(
          child: Container(color: Colors.red),
          builder: widget._builder);
  }
}