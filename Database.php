<?php
// File: Database.php

class Database {
    private $host = "localhost";
    private $db_name = "TokoBangunan";
    private $username = "root"; // Default XAMPP
    private $password = "";     // Default XAMPP kosong
    public $conn;

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name, 
                $this->username, 
                $this->password
            );
            // Set error mode ke exception untuk mempermudah debugging
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch(PDOException $exception) {
            echo "Koneksi database gagal: " . $exception->getMessage();
        }
        return $this->conn;
    }
}
?>