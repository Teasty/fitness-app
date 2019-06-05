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
    <title>Карты</title>
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
                    <li class="nav-item active">
                        <a class="nav-link"
                            href="https://firsttryapi.000webhostapp.com/admin/admin_cards.php">Карты<span
                                class="sr-only"></span></a>
                    </li>
                    <li class="nav-item">
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
        <div clas="row">

            <div class="col col-12">
                <h1 class="m-5">Виды карт</h1>
                <table class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Название вида абонемента</th>
                            <th scope="col"># вида абонемента</th>
                            <th scope="col">Название вида карты</th>
                            <th scope="col">Длительность карты</th>
                            <th scope="col">Стоимость карты</th>
                            <th scope="col">Удалить</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                        $result = mysqli_query($db, "SELECT card_categories.card_category_name, card_type.card_type_id, card_type.card_category_id, card_type.card_type_name, card_type.card_type_length, card_type.card_type_cost FROM `card_type`, card_categories WHERE card_categories.card_category_id = card_type.card_category_id");
                        while($row = $result->fetch_assoc()){
                    ?>
                        <tr>
                            <th scope="col"><?php echo $row['card_category_name'] ?></th>
                            <th scope="col"><?php echo $row['card_category_id'] ?></th>
                            <th scope="col"><?php echo $row['card_type_name'] ?></th>
                            <th scope="col"><?php echo $row['card_type_length'] ?> дней</th>
                            <th scope="col"><?php echo $row['card_type_cost'] ?> руб</th>
                            <th scope="col"><a href="https://firsttryapi.000webhostapp.com/admin/delete_card_type.php?card_type_id=<?php echo $row['card_type_id'] ?>" style="color:red;"><i class="fas fa-times"></i></a></th>
                        </tr>
                        <?php 
                    }
                    ?>
                    </tbody>
                </table>
                <h1 class="m-5">Добавить вид карты</h1>
                <form action="https://firsttryapi.000webhostapp.com/admin/create_type.php" method="post">
                    <div class="form-row mb-5" align="center">
                        <div class="form-group col-md-2">
                            <label for="category_id"># вида абонемента</label>
                            <input type="number" class="form-control" name="category_id" id="category_id">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="card_name">Название вида карты</label>
                            <input type="text" class="form-control" name="card_name" id="card_name">
                        </div>
                        <div class="form-group col-md-2">
                            <label for="card_length">Срок работы карты</label>
                            <input type="number" class="form-control" name="card_length" id="card_length">
                        </div>
                        <div class="form-group col-md-2">
                            <label for="card_cost">Стоимость карты</label>
                            <input type="number" class="form-control" name="card_cost" id="card_cost">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Добавить</button>
                </form>
            </div>
        </div>
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