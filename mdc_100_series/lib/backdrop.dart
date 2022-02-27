import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'model/product.dart';

// DONE: Add velocity constant (104)
const double _kFlinkVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: "Backdrop");

  // DONE: Add AnimationController widget (104)
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  // TODO: Add override for didUpdateWidget (104)

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // DONE: Add functions to get and change front layer visibility (104)
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlinkVelocity : _kFlinkVelocity);
  }

  // TODO: Add BuildContext and BoxConstraints parameters to _buildStack (104)
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    // TODO: Create a RelativeRectTween Animation (104)
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // DONE: Wrap backLayer in an ExcludeSemantics widget (104)
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        // DONE: Add a PositionedTransition (104)
        PositionedTransition(
            rect: layerAnimation,
            child: _FrontLayer(
                // TODO: Implement onTap property on _BackdropState (104)
                child: widget.frontLayer)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      // DONE: Replace leading menu icon with IconButton (104)
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      // TODO: Remove leading property (104)
      // TODO: Create title with _BackdropTitle parameter (104)
      title: const Text("聖廟"),
      actions: <Widget>[
        // TODO: Add shortcut to login screen from trailing icons (104)
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            semanticLabel: "検索",
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              semanticLabel: "フィルタ",
            )),
      ],
      backwardsCompatibility: false,
    );
    return Scaffold(
      appBar: appBar,
      // TODO: Return a LayoutBuilder widget (104)
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

// DONE: Add _FrontLayer class (104)
class _FrontLayer extends StatelessWidget {
  const _FrontLayer({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: child),
        ],
      ),
    );
  }
}
