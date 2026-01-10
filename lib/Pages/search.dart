import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _stories = [
    {"name": "", "image": "https://picsum.photos/300/300?random=1"},
    {"name": "", "image": "https://picsum.photos/300/300?random=2"},
    {"name": "", "image": "https://picsum.photos/300/300?random=3"},
    {"name": "", "image": "https://picsum.photos/300/300?random=4"},
    {"name": "", "image": "https://picsum.photos/300/300?random=5"},
    {"name": "", "image": "https://picsum.photos/300/300?random=6"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Container(
          height: 44,
          margin: const EdgeInsets.only(left: 8, right: 16, top: 4, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.white70, size: 22),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Qidiruv...",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
              if (isSearching)
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {});
                  },
                  child: Icon(Icons.close, color: Colors.white70, size: 22),
                ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            tabs: [
              Tab(text: "Chats"),
              Tab(text: "Global"),
              Tab(text: "Channels"),
              Tab(text: "Posts"),
              Tab(text: "Media"),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          Container(
            height: 110,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                final story = _stories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient:  LinearGradient(
                            colors: [Colors.purple, Colors.pinkAccent],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 29,
                            backgroundImage: NetworkImage(story["image"]),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      SizedBox(
                        width: 50,
                        child: Text(
                          story["name"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildEmptyState("Sizning chatlaringizdan hech narsa topilmadi"),
                _buildEmptyState("Global qidiruv natijalari shu yerda chiqadi"),
                _buildEmptyState("Kanallar va guruhlar shu yerda"),
                _buildEmptyState("Public postlar va kanallar postlari"),
                _buildEmptyState("Rasmlar, videolar, fayllar va linklar"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "Qidiruv so‘zini kiriting",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}