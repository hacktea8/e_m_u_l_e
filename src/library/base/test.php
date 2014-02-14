<?php

define('WEKIT_VERSION',1);

require 'PwBaseRediscache.php';

$redis = new PwBaseRediscache();

$ip = '127.0.0.1';
$id = 100;
$key = sprintf('hitslog:%s:%d',$ip,$id);
                if(!$redis->exists($key)){
                   $redis->set($key, 1, 3600);
echo "the key value storage!\n";
                }else{
echo "the key exists!\n";
}

$key = $redis->keys('hitslog:*');
var_dump($key);
