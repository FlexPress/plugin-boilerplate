<?php

use FlexPress\Plugins\NewPlugin\DependencyInjection\DependencyInjectionContainer;

// Dependency Injection
$dic = new DependencyInjectionContainer();
$dic->init();

// Run app
$dic['NewPlugin']->init(__FILE__);
