#
# SCRIPT start mgmt_cli operations - tear-down - Simple
#
# Version :  00.01.00
# Date    :  2016-06-29
#

echo
echo 'Logout of mgmt_cli!'
echo
mgmt_cli logout -s id.txt

echo 'CLI Operations Completed'

rm id.txt

ls -alh

echo
echo 'All done!'
echo
echo
