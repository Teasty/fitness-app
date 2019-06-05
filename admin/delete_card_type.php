<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "DELETE FROM `card_type` WHERE card_type_id = ".$_GET['card_type_id']);
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_cards.php');
?>