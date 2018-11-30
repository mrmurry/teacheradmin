echo export DISPNUM=$( w | grep -m 1 "${names[$i]}" | awk '{print $2}')
echo "export SDISPLAY=export DISPLAY=$DISPNUM"
echo sudo sed -i \"1 i $SDISPLAY\" /etc/bash.bashrc
echo sudo sed -i \'2 i xhost +\' /etc/bash.bashrc
