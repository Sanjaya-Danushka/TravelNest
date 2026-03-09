import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'name';

  final List<Map<String, dynamic>> _favoriteDestinations = [
    {
      'id': 1,
      'name': 'Ella Rock, Sri Lanka',
      'description': 'Discover places most travelers miss',
      'image': 'assets/images/homebg.jpg',
      'rating': 4.8,
      'price': '\$1,200',
      'duration': '3 days',
      'savedDate': '2024-01-15',
      'category': 'Mountain',
    },
    {
      'id': 2,
      'name': 'Mirissa Beach',
      'description': 'Perfect sunset views and surfing',
      'image': 'assets/images/home3.jpg',
      'rating': 4.9,
      'price': '\$800',
      'duration': '4 days',
      'savedDate': '2024-01-20',
      'category': 'Beach',
    },
    {
      'id': 3,
      'name': 'Sigiriya Fortress',
      'description': 'Ancient rock fortress and palace',
      'image': 'assets/images/homebg.jpg',
      'rating': 4.7,
      'price': '\$950',
      'duration': '2 days',
      'savedDate': '2024-01-10',
      'category': 'Cultural',
    },
    {
      'id': 4,
      'name': 'Yala National Park',
      'description': 'Wildlife safari adventures',
      'image': 'assets/images/home3.jpg',
      'rating': 4.6,
      'price': '\$1,500',
      'duration': '5 days',
      'savedDate': '2024-01-25',
      'category': 'Wildlife',
    },
    {
      'id': 5,
      'name': 'Galle Fort',
      'description': 'Historic colonial architecture',
      'image': 'assets/images/homebg.jpg',
      'rating': 4.8,
      'price': '\$600',
      'duration': '1 day',
      'savedDate': '2024-01-18',
      'category': 'Cultural',
    },
    {
      'id': 6,
      'name': 'Nuwara Eliya',
      'description': 'Little England with tea plantations',
      'image': 'assets/images/home3.jpg',
      'rating': 4.7,
      'price': '\$1,100',
      'duration': '3 days',
      'savedDate': '2024-01-22',
      'category': 'Mountain',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredFavorites {
    var filtered = _favoriteDestinations.where((dest) {
      final searchQuery = _searchController.text.toLowerCase();
      return dest['name'].toString().toLowerCase().contains(searchQuery) ||
          dest['description'].toString().toLowerCase().contains(searchQuery);
    }).toList();

    switch (_sortBy) {
      case 'name':
        filtered.sort(
          (a, b) => a['name'].toString().compareTo(b['name'].toString()),
        );
        break;
      case 'rating':
        filtered.sort(
          (a, b) => (b['rating'] as double).compareTo(a['rating'] as double),
        );
        break;
      case 'price':
        filtered.sort(
          (a, b) => a['price'].toString().compareTo(b['price'].toString()),
        );
        break;
      case 'date':
        filtered.sort(
          (a, b) =>
              b['savedDate'].toString().compareTo(a['savedDate'].toString()),
        );
        break;
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.05),
                Colors.transparent,
                Colors.transparent,
              ],
              stops: [0.0, 0.15, 0.3, 1.0],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 20),
                    _buildSearchBar(),
                    SizedBox(height: 20),
                    _buildSortOptions(),
                    SizedBox(height: 20),
                    _buildFavoritesList(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.favorite, color: Colors.white, size: 24),
          ),
          Spacer(),
          Text(
            'My Favorites',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.more_vert, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search favorites...",
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 22),
            suffixIcon: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF667EEA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.filter_list, color: Colors.white, size: 20),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget _buildSortOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredFavorites.length} favorites',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontFamily: 'Poppins',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFF667EEA)),
                style: TextStyle(
                  color: Color(0xFF667EEA),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
                items: [
                  DropdownMenuItem(value: 'name', child: Text('Name')),
                  DropdownMenuItem(value: 'rating', child: Text('Rating')),
                  DropdownMenuItem(value: 'price', child: Text('Price')),
                  DropdownMenuItem(value: 'date', child: Text('Date Saved')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sortBy = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    final favorites = _filteredFavorites;

    if (favorites.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.favorite_border, color: Colors.white54, size: 80),
            SizedBox(height: 20),
            Text(
              'No favorites yet',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Start exploring and save your favorite destinations',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        return _buildFavoriteCard(favorites[index]);
      },
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> destination) {
    return GestureDetector(
      onTap: () {
        _showDestinationDetails(destination);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                destination['image'],
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, color: Colors.grey[600], size: 40),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            destination['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      destination['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: 'Poppins',
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          destination['rating'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          destination['price'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF667EEA),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.grey[500],
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          destination['duration'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Saved ${_getRelativeTime(destination['savedDate'])}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRelativeTime(String savedDate) {
    // Simple relative time calculation
    DateTime date = DateTime.parse(savedDate);
    DateTime now = DateTime.now();
    int daysDifference = now.difference(date).inDays;

    if (daysDifference == 0) return 'today';
    if (daysDifference == 1) return 'yesterday';
    if (daysDifference < 7) return '$daysDifference days ago';
    if (daysDifference < 30) return '${(daysDifference / 7).floor()} weeks ago';
    return '${(daysDifference / 30).floor()} months ago';
  }

  void _showDestinationDetails(Map<String, dynamic> destination) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                child: Stack(
                  children: [
                    Image.asset(
                      destination['image'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            color: Colors.grey[600],
                            size: 40,
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          destination['category'],
                          style: TextStyle(
                            color: Color(0xFF667EEA),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination['name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 4),
                        Text(
                          destination['rating'].toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 15),
                        Icon(
                          Icons.access_time,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        SizedBox(width: 4),
                        Text(
                          destination['duration'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      destination['description'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              destination['price'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF667EEA),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Saved',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              _getRelativeTime(destination['savedDate']),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              color: Color(0xFF667EEA),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Book Now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Remove',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
