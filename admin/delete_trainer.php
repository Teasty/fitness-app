<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "DELETE FROM `trainers` WHERE trainer_id = ".$_GET['trainer_id']);
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_trainers.php');
?>