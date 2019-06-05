<?php
    session_start();
    $db = mysqli_connect("localhost","id9292332_user","33883573","id9292332_fitness");
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="..//style/main.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
        integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <title>Тренера</title>
</head>

<body>
    <div class="menu" id="login_form">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar"
                aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link"
                            href="https://firsttryapi.000webhostapp.com/admin/admin_activities.php">Занятия<span
                                class="sr-only"></span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                            href="https://firsttryapi.000webhostapp.com/admin/admin_cards.php">Карты<span
                                class="sr-only"></span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link"
                            href="https://firsttryapi.000webhostapp.com/admin/admin_trainers.php">Треннера<span
                                class="sr-only"></span></a>
                    </li>
                </ul>
                <form class="form-inline my-2 my-lg-0">
                    <?php if (!isset($_SESSION['username'])) { ?>
                    <input type="text" class="nav-item form-control mr-sm-2" name="username" id="login_username"
                        placeholder="login" />
                    <?php } ?>
                    <?php if (!isset($_SESSION['username'])) { ?>
                    <input type="password" class="nav-item form-control mr-sm-2" name="password" id="login_password"
                        placeholder="password" />
                    <?php } ?>
                    <?php if (!isset($_SESSION['username'])) { ?>
                    <a id="login_button" class="nav-item btn btn-outline-primary my-2 my-sm-0" class="menu_element"
                        onclick="post_query('login', 'manage', 'login_username.login_password', 'login_func'); return false;"
                        href="#">Войти</a>
                    <?php } ?>
                    <?php if (isset($_SESSION['username'])) { ?>
                    <a class="nav-item nav-link" href="/blog/templates/profile.php">
                        <?php echo $_SESSION['username'];?></a>
                    <?php } ?>
                    <?php if (isset($_SESSION['username'])) { ?>
                    <a class="nav-item btn btn-outline-primary my-2 my-sm-0" id="exit_button"
                        onclick="post_query('exit', 'manage', '', 'login_func'); window.location.pathname = '/blog/templates/home.php'; return false; "
                        href="#">Выход</a>
                    <?php } ?>
                    <!-- <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-info my-2 my-sm-0" type="submit">Search</button> -->
                </form>
            </div>
        </nav>
    </div>

    <div class="container">
        <h1 class="m-5">Тренера</h1>
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th scope="col"># тренера</th>
                    <th scope="col">Фамилия тренера</th>
                    <th scope="col">Имя тренера</th>
                    <th scope="col">Отчество тренера</th>
                    <th scope="col">Телефон тренера</th>
                    <th scope="col">E-mail тренера</th>
                    <th scope="col">Изменить</th>
                    <th scope="col">Удалить</th>
                </tr>
            </thead>
            <tbody>
                <?php
                        $result = mysqli_query($db, "SELECT * FROM `trainers`");
                        while($row = $result->fetch_assoc()){
                    ?>
                <tr>
                    <th scope="col"><?php echo $row['trainer_id'] ?></th>
                    <th scope="col"><?php echo $row['trainer_familia'] ?></th>
                    <th scope="col"><?php echo $row['trainer_name'] ?></th>
                    <th scope="col"><?php echo $row['trainer_otchestvo'] ?></th>
                    <th scope="col"><?php echo $row['trainer_telephone'] ?></th>
                    <th scope="col"><?php echo $row['trainer_email'] ?></th>
                    <th scope="col"><a href="https://firsttryapi.000webhostapp.com/admin/edit_trainer.php?trainer_id=<?php echo $row['trainer_id'] ?>&trainer_name=<?php echo $row['trainer_name'] ?>&trainer_familia=<?php echo $row['trainer_familia'] ?>&trainer_otchestvo=<?php echo $row['trainer_otchestvo'] ?>&trainer_telephone=<?php echo $row['trainer_telephone'] ?>&trainer_email=<?php echo $row['trainer_email'] ?>" style="color:orange;"><i class="fas fa-edit"></i></a></th>
                    <th scope="col"><a href="https://firsttryapi.000webhostapp.com/admin/delete_trainer.php?trainer_id=<?php echo $row['trainer_id'] ?>" style="color:red;"><i class="fas fa-times"></i></a></th>
                </tr>
                <?php 
                    }
                    ?>
            </tbody>
        </table>
        <h1 class="m-5">Добавить тренера</h1>
        <form action="https://firsttryapi.000webhostapp.com/admin/create_trainer.php" method="post">
            <div class="form-row mb-5" align="center">
                <div class="form-group col-md-4">
                    <label for="trainer_familia">Фамилия тренера</label>
                    <input type="text" class="form-control" name="trainer_familia" id="trainer_familia">
                </div>
                <div class="form-group col-md-4">
                    <label for="trainer_name">Имя тренера</label>
                    <input type="text" class="form-control" name="trainer_name" id="trainer_name">
                </div>
                <div class="form-group col-md-4">
                    <label for="trainer_otchestvo">Отчество тренера</label>
                    <input type="text" class="form-control" name="trainer_otchestvo" id="trainer_otchestvo">
                </div>
                <div class="form-group col-md-6">
                    <label for="trainer_telephone">Телефон тренера</label>
                    <input type="text" class="form-control" name="trainer_telephone" id="trainer_telephone">
                </div>
                <div class="form-group col-md-6">
                    <label for="trainer_email">E-mail тренера</label>
                    <input type="email" class="form-control" name="trainer_email" id="trainer_email">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Добавить</button>
        </form>
    </div>


</body>
<!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
    integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
</script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
    integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
</script>

</html>