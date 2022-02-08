import 'dart:developer';
import 'book.dart';

import 'package:flutter/material.dart';

 
  class TabsDynamic extends StatefulWidget {
    List<dynamic> tabListHere;
    TabsDynamic(this.tabListHere, {Key? key}) : super(key: key);
    @override
    _TabsDynamicState createState() => _TabsDynamicState();
  }

  class _TabsDynamicState extends State<TabsDynamic> {
  
    
    int initPosition = 0;

    
    String titleText(int index){
      if(index==0){
        return "My Books";
        }
      else{
        return widget.tabListHere[index].book.title;
      }
      }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: CustomTabView(
            initPosition: initPosition,
            itemCount: widget.tabListHere.length,
            tabBuilder: (context, index) => Tab(text: titleText(index)),
            pageBuilder: (context, index) => widget.tabListHere[index],
            onPositionChange: (index){
              initPosition = index;
            },
            onScroll: (position) => log('$position'),
          ),
        ),
      );
    }
  }

  /// Implementation

  class CustomTabView extends StatefulWidget {
    final int itemCount;
    final IndexedWidgetBuilder tabBuilder;
    final IndexedWidgetBuilder pageBuilder;
    Widget ?stub;
    final ValueChanged<int> onPositionChange;
    final ValueChanged<double> onScroll;
    final int initPosition;

    CustomTabView({
      required this.itemCount,
      required this.tabBuilder,
      required this.pageBuilder,
      this.stub,
      required this.onPositionChange,
      required this.onScroll,
      required this.initPosition,
    });

    @override
    _CustomTabsState createState() => _CustomTabsState();
  }

  class _CustomTabsState extends State<CustomTabView> with TickerProviderStateMixin {
    late TabController controller;
    late int _currentCount;
    late int _currentPosition;

    @override
    void initState() {
      _currentPosition = widget.initPosition;
      controller = TabController(
        length: widget.itemCount,
        vsync: this,
        initialIndex: _currentPosition,
      );
      controller.addListener(onPositionChange);
      controller.animation?.addListener(onScroll);
      _currentCount = widget.itemCount;
      super.initState();
    }

    @override
    void didUpdateWidget(CustomTabView oldWidget) {
      if (_currentCount != widget.itemCount) {
        controller.animation?.removeListener(onScroll);
        controller.removeListener(onPositionChange);
        controller.dispose();

        if (widget.initPosition != null) {
          _currentPosition = widget.initPosition;
        }

        if (_currentPosition > widget.itemCount - 1) {
            _currentPosition = widget.itemCount - 1;
            _currentPosition = _currentPosition < 0 ? 0 : 
            _currentPosition;
            if (widget.onPositionChange is ValueChanged<int>) {
               WidgetsBinding.instance?.addPostFrameCallback((_){
                if(mounted) {
                  widget.onPositionChange(_currentPosition);
                }
               });
            }
         }

        _currentCount = widget.itemCount;
        setState(() {
          controller = TabController(
            length: widget.itemCount,
            vsync: this,
            initialIndex: _currentPosition,
          );
          controller.addListener(onPositionChange);
          controller.animation?.addListener(onScroll);
        });
      } else if (widget.initPosition != null) {
        controller.animateTo(widget.initPosition);
      }

      super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
      controller.animation?.removeListener(onScroll);
      controller.removeListener(onPositionChange);
      controller.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      if (widget.itemCount < 1) return widget.stub ?? Container();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: TabBar(
              isScrollable: true,
              controller: controller,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).hintColor,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
              tabs: List.generate(
                widget.itemCount,
                    (index) => widget.tabBuilder(context, index),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: List.generate(
                widget.itemCount,
                    (index) => widget.pageBuilder(context, index),
              ),
            ),
          ),
        ],
      );
    }

    onPositionChange() {
      if (!controller.indexIsChanging) {
        _currentPosition = controller.index;
        if (widget.onPositionChange is ValueChanged<int>) {
          widget.onPositionChange(_currentPosition);
        }
      }
    }

    onScroll() {
      if (widget.onScroll is ValueChanged<double>) {
        widget.onScroll(controller.animation!.value);
      }
    }
  }