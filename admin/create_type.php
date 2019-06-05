<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "INSERT INTO `card_type`(`card_category_id`, `card_type_name`, `card_type_length`, `card_type_cost`) VALUES ('".$_POST['category_id']."','".$_POST['card_name']."','".$_POST['card_length']."','".$_POST['card_cost']."')");
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_cards.php');
?>