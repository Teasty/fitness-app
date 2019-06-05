<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "UPDATE `trainers` SET `trainer_id`=".$_POST['trainer_id'].",`trainer_name`='".$_POST['trainer_name']."',`trainer_familia`='".$_POST['trainer_familia']."',`trainer_otchestvo`='".$_POST['trainer_otchestvo']."',`trainer_telephone`= '".$_POST['trainer_telephone']."',`trainer_email`='".$_POST['trainer_email']."' WHERE trainer_id = ".$_POST['trainer_id']);
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_trainers.php');
?>