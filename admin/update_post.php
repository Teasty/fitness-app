<?php 
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
    $result = mysqli_query($db, "UPDATE `posts` SET `post_id`=".$_POST['post_id'].",`post_title`='".$_POST['post_title']."',`post_short_desc`='".$_POST['post_short_desc']."',`post_text`='".$_POST['post_text']."',`post_start_date`='".$_POST['post_start_date']."',`post_end_date`='".$_POST['post_end_date']."'] WHERE post_id = ".$_POST['post_id']);
    header('Location: https://firsttryapi.000webhostapp.com/admin/admin_posts.php');
?>