//@dart=2.9
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:following_news/Logout.dart';
import 'package:http/http.dart' show Client;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';
import 'aboutUs.dart';

import 'api/notificationApi.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            child:Center(child: Logout()),
          )),
    ));
  }

  
  
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
    this.trimLines = 2,
  })  : assert(text != null),
        super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.blue;
    final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore ? "... read more" : " read less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text =
            TextSpan(text: widget.text, style: TextStyle(color: Colors.black));
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,

          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widgetColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            style: TextStyle(color: Colors.black),
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}

class TextNormal extends StatefulWidget {
  const TextNormal(
    this.text, {
    Key key,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  TextNormalState createState() => TextNormalState();
}

class TextNormalState extends State<TextNormal> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span =
          TextSpan(text: widget.text, style: TextStyle(color: Colors.black));
      final tp = TextPainter(
          textDirection: TextDirection.rtl, text: span, maxLines: 1);
      tp.layout(maxWidth: size.maxWidth);

      if (tp.didExceedMaxLines) {
        // The text has more than three lines.
        // TODO: display the prompt message
        return ExpandableText(
          widget.text,
          trimLines: 2,
        );
      } else {
        return Text(widget.text, style: TextStyle(color: Colors.black));
      }
    });
  }
}
