import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_result.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _initialCamera;
  Position? _currentPosition;
  Marker? _pickedMarker;
  String? _pickedAddress;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _setupLocation();
  }

  Future<void> _setupLocation() async {
    try {
      final position = await _getPermissions();
      _currentPosition = position;
      _initialCamera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
      );
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final p = placemarks.first;
      if (mounted) {
        setState(() {
          _pickedAddress = '${p.name}, ${p.locality}, ${p.country}';
        });
      }
    } catch (e) {
      _initialCamera = const CameraPosition(target: LatLng(0, 0), zoom: 2);
      if (mounted) {
        setState(() {});
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mendapatkan lokasi: $e')));
      }
    }
  }

  Future<Position> _getPermissions() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Layanan lokasi belum aktif';
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Izin lokasi ditolak';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw 'Izin lokasi ditolak selamanya';
    }
    return Geolocator.getCurrentPosition();
  }

  Future<void> _onTap(LatLng latLng) async {
    setState(() => _isLoading = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      final p = placemarks.first;
      _pickedMarker = Marker(
        markerId: const MarkerId('picked'),
        position: latLng,
        infoWindow: InfoWindow(
          title: p.name ?? 'Lokasi Dipilih',
          snippet: '${p.street}, ${p.locality}',
        ),
      );
      final ctrl = await _controller.future;
      await ctrl.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
      _pickedAddress =
          '${p.name}, ${p.street}, ${p.locality}, ${p.country}, ${p.postalCode}';
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal mengambil alamat: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _confirmSelection() {
    if (_pickedAddress == null || _pickedMarker == null) return;
    final result = MapResult(
      latitude: _pickedMarker!.position.latitude,
      longitude: _pickedMarker!.position.longitude,
      address: _pickedAddress!,
    );
    Navigator.pop(context, result);
  }

  Future<void> _useCurrentLocation() async {
    if (_currentPosition != null) {
      final latLng = LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      await _onTap(latLng);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Lokasi belum tersedia')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialCamera == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Lokasi'), centerTitle: true),
      body: Stack(
        children: [
          // MAP
          GoogleMap(
            initialCameraPosition: _initialCamera!,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            compassEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            padding: const EdgeInsets.only(bottom: 40),
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
            markers: _pickedMarker != null ? {_pickedMarker!} : {},
            onTap: _onTap,
          ),
          // ADDRESS CARD
          if (_pickedAddress != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 180,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFF8BA2E7)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _pickedAddress!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // LOADING OVERLAY
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Button Lokasi Saya
            FloatingActionButton(
              heroTag: 'current_location',
              onPressed: _useCurrentLocation,
              backgroundColor: const Color.fromARGB(255, 247, 247, 248),
              tooltip: 'Lokasi Saya',
              child: const Icon(Icons.my_location, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            // Jika Ada Lokasi Dipilih
            if (_pickedAddress != null) ...[
              FloatingActionButton.extended(
                heroTag: 'confirm',
                onPressed: _confirmSelection,
                backgroundColor: const Color.fromARGB(255, 78, 179, 230),
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  "Pilih",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FloatingActionButton.extended(
                heroTag: 'clear',
                onPressed: () {
                  setState(() {
                    _pickedAddress = null;
                    _pickedMarker = null;
                  });
                },
                backgroundColor: Colors.redAccent,
                icon: const Icon(Icons.clear, color: Colors.white),
                label: const Text(
                  "Hapus",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
