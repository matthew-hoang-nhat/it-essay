import 'package:flutter/material.dart';

class LoadingFullScreen extends StatelessWidget {
  final Widget child;
  final bool loading;
  final Color? backgroundColor;

  const LoadingFullScreen({
    Key? key,
    required this.child,
    this.loading = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !loading,
      child: Stack(
        children: <Widget>[
          child,
          loading
              ? GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: backgroundColor ?? Colors.black54,
                    constraints: const BoxConstraints.expand(),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
