<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "INSERT INTO `trainers`(`trainer_name`, `trainer_familia`, `trainer_otchestvo`, `trainer_telephone`, `trainer_email`) VALUES ('".$_POST['trainer_name']."','".$_POST['trainer_familia']."','".$_POST['trainer_otchestvo']."','".$_POST['trainer_telephone']."','".$_POST['trainer_email']."')");
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_trainers.php');
?>