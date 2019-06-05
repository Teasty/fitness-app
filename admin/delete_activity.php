<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "DELETE FROM `activities` WHERE trainer_id = ".$_GET['trainer_id']."  AND activity_type_id = ".$_GET['activity_type_id']."  AND day_of_week = '".$_GET['day_of_week']."' AND start_time = '".$_GET['start_time']."'");
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_activities.php');
?>