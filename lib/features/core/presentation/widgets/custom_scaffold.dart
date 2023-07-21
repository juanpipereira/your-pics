import 'package:flutter/material.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    required this.tabs,
    required this.tabsViews,
  });

  final List<Tab> tabs;
  final List<Widget> Function(TabController) tabsViews;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: widget.tabsViews(_tabController),
      ),
      bottomNavigationBar: TabBar(
        labelColor: Colors.purple,
        controller: _tabController,
        tabs: widget.tabs,
      ),
    );
  }
}
