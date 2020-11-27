<?php

//database connection parameters
$host= getenv('MYSQL_HOST'); //SQL server name
$port='3306'; //SQL server port
$db_name= getenv('MYSQL_DATABASE'); //database name
$charset= 'utf8'; //database charset default utf8
$user= getenv('MYSQL_USER'); //database user name
$password= getenv('MYSQL_PASSWORD'); //database password

//database connection
try {$db = new PDO("mysql:host=$host;port=$port;dbname=$db_name;charset=$charset", "$user", "$password" , array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));}
catch (Exception $e)
{die('Error : ' . $e->getMessage());}

?>
