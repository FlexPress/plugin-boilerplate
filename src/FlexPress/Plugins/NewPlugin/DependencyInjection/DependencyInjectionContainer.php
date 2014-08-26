<?php

namespace FlexPress\Plugins\NewPlugin\DependencyInjection;

use FlexPress\Plugins\NewPlugin\NewPlugin;

class DependencyInjectionContainer extends \Pimple
{

    public function init()
    {
        $this['NewPlugin'] = function () {
            return new NewPlugin();
        };
    }
}
