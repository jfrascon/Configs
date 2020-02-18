alias logimatic_RMU='export ROS_MASTER_URI=http://logimatic-desktop:11311'
alias logimatic_ssh_obu='ssh logimatic@logimatic-desktop'

function logimaticRosbagPlayOld()
{
	rosbag play $1 /septentrio/baseline:=/septentrio/rtklib/baseline /septentrio/latlon:=/septentrio/rtklib/fix  /ublox/baseline:=/ublox/rtklib/baseline /ublox/latlon:=/ublox/rtklib/fix
}

alias logimatic_rbp_old='logimaticRosbagPlayOld'

function logimaticRosbagFilter()
{
    rosbag filter $1 $2 "topic == '/ublox/raw/nav' or topic == '/ublox/raw/obs' or topic == '/ublox/fix' or topic == '/ublox/raw_nmea' or topic == '/ublox/time_reference' or topic == '/ublox/rtklib/baseline' or topic == '/ublox/rtklib/fix' or topic == '/septentrio/raw/nav' or topic == '/septentrio/raw/obs' or topic == '/septentrio/fix' or topic == '/septentrio/raw_nmea' or topic == '/septentrio/time_reference' or topic == '/septentrio/rtklib/baseline' or topic == '/septentrio/rtklib/fix'"
}

alias logimatic_rbfilter='logimaticRosbagFilter'