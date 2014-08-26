#! /bin/bash

if [ -f .installdone ]
then
    echo -e "Error, installer has already been ran, if something went wrong please re-download the project\n";
    exit 0;
fi

pluginName='';
while true; do
    read -p "Please enter the plugin name e.g. twitter will become component-twitter: " name
    if [ ! -x $name ]
    then
        pluginName=$name
        break
    fi
done

formattedPluginName='';
while true; do
    read -p "Please enter the formatted plugin name e.g. twitter will become Twitter: " name
    if [ ! -x $name ]
    then
        formattedPluginName=$name
        break
    fi
done

echo -e "Righto, lets create a plugin called component-$pluginName\n";

sed -i '' "s/NewPlugin/$formattedPluginName/g" newplugin.php
mv newplugin.php $pluginName.php

mv src/FlexPress/Plugins/NewPlugin src/FlexPress/Plugins/$formattedPluginName
mv src/FlexPress/Plugins/$formattedPluginName/NewPlugin.php src/FlexPress/Plugins/$formattedPluginName/$formattedPluginName.php

find src/ -type f -exec sed -i '' "s/NewPlugin/$formattedPluginName/g" {} \;
sed -i '' "s/NewPlugin/$formattedPluginName/g" composer.json
sed -i '' "s/newplugin/$pluginName/g" composer.json

touch .installdone