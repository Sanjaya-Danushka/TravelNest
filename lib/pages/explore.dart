import 'package:flutter/material.dart';
import 'dart:ui';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

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

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.apps, 'color': Colors.purple},
    {'name': 'Beach', 'icon': Icons.beach_access, 'color': Colors.blue},
    {'name': 'Mountain', 'icon': Icons.terrain, 'color': Colors.green},
    {'name': 'City', 'icon': Icons.location_city, 'color': Colors.orange},
    {'name': 'Forest', 'icon': Icons.park, 'color': Colors.teal},
    {'name': 'Desert', 'icon': Icons.wb_sunny, 'color': Colors.yellow},
    {'name': 'Adventure', 'icon': Icons.hiking, 'color': Colors.red},
    {'name': 'Cultural', 'icon': Icons.museum, 'color': Colors.indigo},
    {'name': 'Wildlife', 'icon': Icons.pets, 'color': Colors.brown},
  ];

  final List<Map<String, dynamic>> _destinations = [
    {
      'name': 'Maldives Paradise',
      'location': 'Indian Ocean',
      'category': 'Beach',
      'rating': 4.9,
      'price': '\$2,500',
      'image': 'assets/images/homebg.jpg',
      'description': 'Crystal clear waters and overwater bungalows',
      'duration': '7 days',
    },
    {
      'name': 'Swiss Alps',
      'location': 'Switzerland',
      'category': 'Mountain',
      'rating': 4.8,
      'price': '\$3,200',
      'image': 'assets/images/home3.jpg',
      'description': 'Breathtaking mountain views and skiing',
      'duration': '5 days',
    },
    {
      'name': 'Tokyo Adventure',
      'location': 'Japan',
      'category': 'City',
      'rating': 4.7,
      'price': '\$2,800',
      'image': 'assets/images/homebg.jpg',
      'description': 'Modern city life and ancient traditions',
      'duration': '6 days',
    },
    {
      'name': 'Amazon Rainforest',
      'location': 'Brazil',
      'category': 'Forest',
      'rating': 4.6,
      'price': '\$1,800',
      'image': 'assets/images/home3.jpg',
      'description': 'World\'s largest tropical rainforest',
      'duration': '4 days',
    },
    {
      'name': 'Dubai Luxury',
      'location': 'UAE',
      'category': 'City',
      'rating': 4.8,
      'price': '\$3,500',
      'image': 'assets/images/homebg.jpg',
      'description': 'Ultra-modern architecture and shopping',
      'duration': '5 days',
    },
    {
      'name': 'Safari Kenya',
      'location': 'Kenya',
      'category': 'Wildlife',
      'rating': 4.9,
      'price': '\$2,200',
      'image': 'assets/images/home3.jpg',
      'description': 'Witness the great migration',
      'duration': '8 days',
    },
    {
      'name': 'Santorini Dreams',
      'location': 'Greece',
      'category': 'Beach',
      'rating': 4.8,
      'price': '\$2,100',
      'image': 'assets/images/homebg.jpg',
      'description': 'White-washed buildings and blue domes',
      'duration': '5 days',
    },
    {
      'name': 'Northern Lights',
      'location': 'Iceland',
      'category': 'Adventure',
      'rating': 4.9,
      'price': '\$2,900',
      'image': 'assets/images/home3.jpg',
      'description': 'Aurora borealis and natural wonders',
      'duration': '6 days',
    },
    {
      'name': 'Machu Picchu',
      'location': 'Peru',
      'category': 'Cultural',
      'rating': 4.7,
      'price': '\$1,900',
      'image': 'assets/images/homebg.jpg',
      'description': 'Ancient Incan citadel in the clouds',
      'duration': '4 days',
    },
    {
      'name': 'Sahara Desert',
      'location': 'Morocco',
      'category': 'Desert',
      'rating': 4.5,
      'price': '\$1,500',
      'image': 'assets/images/home3.jpg',
      'description': 'Golden dunes and starry nights',
      'duration': '3 days',
    },
    {
      'name': 'Bali Retreat',
      'location': 'Indonesia',
      'category': 'Beach',
      'rating': 4.8,
      'price': '\$1,700',
      'image': 'assets/images/homebg.jpg',
      'description': 'Tropical paradise and spiritual temples',
      'duration': '5 days',
    },
    {
      'name': 'Grand Canyon',
      'location': 'USA',
      'category': 'Mountain',
      'rating': 4.9,
      'price': '\$1,200',
      'image': 'assets/images/home3.jpg',
      'description': 'Natural wonder of the world',
      'duration': '3 days',
    },
  ];

  List<Map<String, dynamic>> get _filteredDestinations {
    if (_selectedCategory == 'All') {
      return _destinations;
    }
    return _destinations
        .where((dest) => dest['category'] == _selectedCategory)
        .toList();
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
                    _buildCategories(),
                    SizedBox(height: 20),
                    _buildDestinationGrid(),
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
            child: Icon(Icons.explore, color: Colors.white, size: 24),
          ),
          Spacer(),
          Text(
            'Explore',
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
            child: Icon(Icons.filter_list, color: Colors.white, size: 24),
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
            hintText: "Search destinations...",
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
              child: Icon(Icons.tune, color: Colors.white, size: 20),
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

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final isSelected = _selectedCategory == category['name'];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category['name'];
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              category['color'],
                              category['color'].withOpacity(0.7),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.white.withOpacity(0.9),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: category['color'].withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category['icon'],
                        color: isSelected ? Colors.white : Colors.grey[700],
                        size: 18,
                      ),
                      SizedBox(width: 6),
                      Text(
                        category['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationGrid() {
    final filtered = _filteredDestinations.where((dest) {
      final searchQuery = _searchController.text.toLowerCase();
      return dest['name'].toString().toLowerCase().contains(searchQuery) ||
          dest['location'].toString().toLowerCase().contains(searchQuery);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Destinations',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                '${filtered.length} places',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.7,
          ),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return _buildDestinationCard(filtered[index]);
          },
        ),
      ],
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination) {
    return GestureDetector(
      onTap: () {
        _showDestinationDetails(destination);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 25,
              offset: Offset(0, 15),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  destination['image'],
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
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: [0.0, 0.4, 0.6, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        destination['category'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          destination['location'],
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 4),
                              Text(
                                destination['rating'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            destination['price'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            Container(
              height: 200,
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
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
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
                        Icon(
                          Icons.location_on,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          destination['location'],
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
                              'Duration',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text(
                              destination['duration'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                SizedBox(width: 4),
                                Text(
                                  destination['rating'].toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Expanded(
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
                              border: Border.all(color: Color(0xFF667EEA)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Save',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF667EEA),
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
