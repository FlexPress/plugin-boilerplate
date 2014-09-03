#! /bin/bash

INSTALL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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

echo -e "Righto, lets create a plugin called component-$pluginName\n"

echo -e "Moving folders\n";
sed -i '' "s/NewPlugin/$formattedPluginName/g" newplugin.php >> $INSTALL_DIR/install.log 2>&1
mv newplugin.php $pluginName.php >> $INSTALL_DIR/install.log 2>&1

mv src/FlexPress/Plugins/NewPlugin src/FlexPress/Plugins/$formattedPluginName
mv src/FlexPress/Plugins/$formattedPluginName/NewPlugin.php src/FlexPress/Plugins/$formattedPluginName/$formattedPluginName.php >> $INSTALL_DIR/install.log 2>&1

echo -e "Replacing instances in files...\n"
find src/ -type f -exec sed -i '' "s/NewPlugin/$formattedPluginName/g" {} \; >> $INSTALL_DIR/install.log 2>&1
sed -i '' "s/NewPlugin/$formattedPluginName/g" composer.json >> $INSTALL_DIR/install.log 2>&1
sed -i '' "s/plugin-framework/plugin-$pluginName/g" composer.json >> $INSTALL_DIR/install.log 2>&1

touch .installdone >> $INSTALL_DIR/install.log 2>&1

echo -e "All done\n";
