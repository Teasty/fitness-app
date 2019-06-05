<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "INSERT INTO `activities`(`activity_type_id`, `trainer_id`, `day_of_week`, `start_time`) VALUES ('".$_POST['activity_id']."','".$_POST['trainer_id']."','".$_POST['day_of_week']."','".$_POST['start_time']."')");
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_activities.php');
?>