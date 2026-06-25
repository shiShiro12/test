-- ========================================================
-- SCRIPT DATABASE TOKO BANGUNAN LENGKAP
-- ========================================================

-- 1. MEMBUAT DATABASE & MENGGUNAKANNYA
CREATE DATABASE IF NOT EXISTS TokoBangunan;
USE TokoBangunan;

-- 2. MEMBUAT TABEL-TABEL UTAMA
-- Tabel Kategori Produk (untuk mengelompokkan bahan bangunan)
CREATE TABLE Kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL
);

-- Tabel Produk (Stok ditaruh di sini)
CREATE TABLE Produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    id_kategori INT,
    harga_jual DECIMAL(10, 2) NOT NULL,
    stok INT DEFAULT 0,
    satuan VARCHAR(20) NOT NULL, -- Contoh: Sak, Batang, Kg, Pcs
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori) ON DELETE SET NULL
);

-- Tabel Pelanggan
CREATE TABLE Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    no_telp VARCHAR(15),
    alamat TEXT
);

-- Tabel Transaksi (Header Penjualan)
CREATE TABLE Transaksi (
    id_transaksi INT AUTO_INCREMENT PRIMARY KEY,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_pelanggan INT,
    total_bayar DECIMAL(10, 2) DEFAULT 0.00,
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE SET NULL
);

-- Tabel Detail Transaksi (Untuk menampung banyak produk dalam satu struk/nota)
CREATE TABLE Detail_Transaksi (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_transaksi INT,
    id_produk INT,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (jumlah * harga_satuan) STORED,
    FOREIGN KEY (id_transaksi) REFERENCES Transaksi(id_transaksi) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES Produk(id_produk)
);


-- 3. MEMASUKKAN DATA CONTOH (INSERT DATA)
-- Isi Kategori
INSERT INTO Kategori (nama_kategori) VALUES 
('Semen'), 
('Besi & Baja'), 
('Alat Tukang');

-- Isi Produk
INSERT INTO Produk (nama_produk, id_kategori, harga_jual, stok, satuan) VALUES 
('Semen Tiga Roda 40kg', 1, 65000.00, 100, 'Sak'),
('Besi Beton 10mm', 2, 85000.00, 50, 'Batang'),
('Palu Kambing Camel', 3, 45000.00, 15, 'Pcs');

-- Isi Pelanggan
INSERT INTO Pelanggan (nama_pelanggan, no_telp, alamat) VALUES 
('Budi Santoso', '08123456789', 'Jl. Merdeka No. 10'),
('Karya Kontraktor', '08998877665', 'Kawasan Industri Blok C');


-- 4. SIMULASI TRANSAKSI BARU (Pelanggan Beli 2 Sak Semen & 1 Palu)
-- Bikin nota/transaksi baru untuk Pelanggan ID 1
INSERT INTO Transaksi (id_pelanggan) VALUES (1); 

-- Masukkan item yang dibeli (Otomatis masuk ke id_transaksi nomor 1)
INSERT INTO Detail_Transaksi (id_transaksi, id_produk, jumlah, harga_satuan) VALUES 
(1, 1, 2, 65000.00),  -- 2 Sak Semen Tiga Roda