<?php
// File: Produk.php

class Produk {
    private $conn;
    private $table_name = "Produk";

    // Atribut Produk
    public $id_produk;
    public $nama_produk;
    public $harga_jual;
    public $stok;
    public $satuan;

    // Constructor untuk menerima koneksi database
    public function __construct($db) {
        $this->conn = $db;
    }

    // Method OOP untuk mengambil semua data produk toko bangunan
    public function readAll() {
        $query = "SELECT p.id_produk, p.nama_produk, p.harga_jual, p.stok, p.satuan, k.nama_kategori 
                  FROM " . $this->table_name . " p
                  LEFT JOIN Kategori k ON p.id_kategori = k.id_kategori
                  ORDER BY p.id_produk DESC";

        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }
}
?>