#
# SCRIPT start mgmt_cli operations - setup - Simple
#
# Version :  00.01.00
# Date    :  2016-06-29
#

export DATE=`date +%Y-%m-%d-%H%M%Z`

echo 'Date Time Group   :  '$DATE
echo

echo
echo 'Login of mgmt_cli!'
echo

mgmt_cli login user administrator > id.txt
echo

echo
cat id.txt
echo

echo
echo 'Start mgmt_cli operations now...'
echo
echo

