import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AsiCoffeeApp());
}

class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsiCoffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class CoffeeItem {
  final String name;
  final double price;
  final String imageUrl;
  final String category;

  CoffeeItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<CoffeeItem> _menu = [
    CoffeeItem(
      name: 'Expresso Asimov',
      price: 5.50,
      category: 'Clássicos',
      imageUrl: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=400&q=80',
    ),
    CoffeeItem(
      name: 'Latte Nebulosa',
      price: 8.90,
      category: 'Com Leite',
      imageUrl: 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?auto=format&fit=crop&w=400&q=80',
    ),
    CoffeeItem(
      name: 'Mocha Robótico',
      price: 12.00,
      category: 'Especiais',
      imageUrl: 'https://images.unsplash.com/photo-1578314675249-a6910f80cc4e?auto=format&fit=crop&w=400&q=80',
    ),
    CoffeeItem(
      name: 'Cappuccino Tech',
      price: 9.50,
      category: 'Com Leite',
      imageUrl: 'https://images.unsplash.com/photo-1534778101976-62847782c213?auto=format&fit=crop&w=400&q=80',
    ),
    CoffeeItem(
      name: 'Cold Brew Isaac',
      price: 10.00,
      category: 'Gelados',
      imageUrl: 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?auto=format&fit=crop&w=400&q=80',
    ),
    CoffeeItem(
      name: 'Frappé da Galáxia',
      price: 14.50,
      category: 'Gelados',
      imageUrl: 'https://images.unsplash.com/photo-1579888944880-d98341245702?auto=format&fit=crop&w=400&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900], // Azul Asimov
        centerTitle: true,
        title: Text(
          'AsiCoffee',
          style: GoogleFonts.orbitron( // Diferencial: Fonte Sci-Fi
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _menu.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = _menu[index];
          // Chamada do Widget separado para cada item
          return CoffeeTile(item: item);
        },
      ),
    );
  }
}

class CoffeeTile extends StatefulWidget {
  final CoffeeItem item;

  const CoffeeTile({super.key, required this.item});

  @override
  State<CoffeeTile> createState() => _CoffeeTileState();
}

class _CoffeeTileState extends State<CoffeeTile> {
  // Estado local para controlar o favorito
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        // Diferencial: Feedback ao clicar no card
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.item.name} adicionado ao carrinho!'),
              backgroundColor: Colors.blue[800],
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Imagem do produto
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.item.imageUrl,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.coffee, size: 80, color: Colors.brown),
                ),
              ),
              const SizedBox(width: 16),
              // Informações do produto (Nome e Preço)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${widget.item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[900],
                      ),
                    ),
                  ],
                ),
              ),
              // Botão de favorito
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                  size: 30,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}