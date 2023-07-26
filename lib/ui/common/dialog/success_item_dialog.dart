import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/ps_dimens.dart';
import 'package:flutterbuyandsell/constant/route_paths.dart';
import 'package:flutterbuyandsell/utils/utils.dart';

class SuccessItemDialog extends StatefulWidget {
  const SuccessItemDialog({this.message, this.onPressed});
  final String? message;
  final Function? onPressed;

  @override
  _SuccessItemDialogState createState() => _SuccessItemDialogState();
}

class _SuccessItemDialogState extends State<SuccessItemDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final SuccessItemDialog widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 50),
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Group_9867.png'),
                    fit: BoxFit.contain,
                  ),
                  shape: BoxShape.circle),
            ),
            const SizedBox(height: PsDimens.space20),
            Container(
              padding: const EdgeInsets.only(
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  top: PsDimens.space8,
                  bottom: PsDimens.space8),
              child: Text(
                widget.message!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            const SizedBox(height: PsDimens.space20),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  color: const Color(0xFFffab1d),
                  child: Text(
                    Utils.getString(context, 'Go__to__homepage'),
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(RoutePaths.home));
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
