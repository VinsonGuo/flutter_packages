import 'package:flutter/cupertino.dart';
import 'package:universal_back_gesture/universal_back_gesture.dart';

/// Shared back-gesture transition for the app's Cupertino pages: Cupertino
/// push animation wrapped in a configurable edge-swipe back gesture.
const kBackGestureBuilder = BackGesturePageTransitionsBuilder(
  parentTransitionBuilder: CupertinoPageTransitionsBuilder(),
  config: BackGestureConfig(
    swipeTransitionRange: GestureMeasurement.pixels(350),
    swipeVelocityThreshold: 600,
  ),
);

/// A Cupertino-style page (opaque, Cupertino slide) whose back transition is
/// driven by [BackGesturePageTransitionsBuilder] instead of the built-in
/// `CupertinoPageRoute` gesture.
class BackGestureCupertinoPage<T> extends Page<T> {
  const BackGestureCupertinoPage({
    required this.child,
    this.builder = kBackGestureBuilder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final BackGesturePageTransitionsBuilder builder;

  @override
  Route<T> createRoute(BuildContext context) =>
      _BackGestureCupertinoRoute<T>(page: this);
}

class _BackGestureCupertinoRoute<T> extends PageRoute<T> {
  _BackGestureCupertinoRoute({required this.page}) : super(settings: page);

  final BackGestureCupertinoPage<T> page;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) => page.child;

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 500);

  /// The back gesture only applies when there is a route below to pop to.
  @override
  bool get popGestureEnabled => !isFirst;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return page.builder.buildTransitions(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
