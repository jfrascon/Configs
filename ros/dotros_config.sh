# if set to 'true', always use software rendering
#export LIBGL_ALWAYS_SOFTWARE=1

# OpenGL 3.3 support can be disabled by setting the environment variable SVGA_VGPU10=0.
# You will then have OpenGL 2.1 support. This may be useful to work around application bugs
# (such as incorrect use of the OpenGL 3.x core profile).
#export SVGA_VGPU10=0

alias roscat-config='ccat ${HOME}/.ros_config.sh'
alias rosed-config='subl ${HOME}/.ros_config.sh'

# +--------------------------------------------+
# | BASIC ROS ENVIRONMENT VARIABLES AND ALIASES|
# +--------------------------------------------+

# Find out what shell is being used when sourcing this file
export CURRENT_SHELL=$(ps --no-headers -p $$|awk '{print $4}') #bash or zsh.
export ROSVER="melodic"
export GAZEBOVER="gazebo-9"

alias rmu-local='export ROS_MASTER_URI=http://localhost:11311'

alias rmu-huskypc='export ROS_MASTER_URI=http://HUSKY-PC:11311'  # HUSKY-PC configured in /etc/hosts
alias ssh-huskypc='ssh husky@HUSKY-PC'

# +---------------+
# | ROS FUNCTIONS |
# +---------------+

alias rosbag-pp='rosbag play --pause'

# It should kill all nodes except /rosout
alias roskill-all='rosnode list | grep -v rosout | xargs rosnode kill'

alias catkinc='printf "==> Cleaning workspace ...\n" && catkin clean -y'
alias catkinb='printf "==> Building workspace ...\n" && catkin build -j$(nproc)'
alias catkincb='catkinc && catkinb'

# roscatkin_make_clean
alias catkinmakec='catkin_make clean'
# roscatkin_make_build
alias catkinmakeb='catkin_make -j$(nproc)'
# roscatkin_make_clean_build
alias catkinmakecb='catkin_make clean && catkin_make -j$(nproc)'

function rosReportPackagePath()
{
  echo "* ROS_PACKAGE_PATH  : $ROS_PACKAGE_PATH"
}

alias rosreport-pp='rosReportPackagePath'

function rosReport()
{
  echo "* ROS_DISTRO        : $ROS_DISTRO"
  echo "* ROS_VERSION       : $ROS_VERSION"
  echo "* ROS_MASTER_URI    : $ROS_MASTER_URI"
  echo "* CMAKE_PREFIX_PATH : $CMAKE_PREFIX_PATH"
  rosReportPackagePath
}

alias rosreport='rosReport'

function rosReportExtra()
{
  rosReport
  echo "* ROSLISP_PCKG_DIRS : $ROSLISP_PACKAGE_DIRECTORIES"
  echo "* LD_LIBRARY_PATH   : $LD_LIBRARY_PATH"
  echo "* PKG_CONFIG_PATH   : $PKG_CONFIG_PATH"
  echo "* PYTHONPATH        : $PYTHONPATH"
}

alias rosreport-extra='rosReportExtra'

function rosLoadWS()
{
  printf "==> Loading workspace ...\n"
  SETUP_FILE="$1"
  #shift # Remove the first argument, i.e, the workspace's path
  # "$@" pass all the remaining arguments to setup.{bash|zsh}
  test -e "$SETUP_FILE" && source "$SETUP_FILE" "$@"
  rosReportPackagePath
}

function rosLoadDefault()
{
  printf "==> Loading default ROS environment ...\n"

  # This default values should be stored only once.
  # The first time this function is invoked the variable VARS_BACKED_UP is not defined, then
  # the body of the if statement is executed and the default value of each variable
  # is stored in another variable. Finally the variable VARS_BACKED_UP is defined and set to 1.
  # Next time this function is invoked the variable VARS_BACKED_UP exists and the body
  # of the if statement is not executed.
  if test -z "${VARS_BACKED_UP+x}"; then
    export LD_LIBRARY_PATH_ORIG="$LD_LIBRARY_PATH"
    export PKG_CONFIG_PATH_ORIG="$PKG_CONFIG_PATH"
    export PYTHONPATH_ORIG="$PYTHONPATH"
    export VARS_BACKED_UP=1
  else
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH_ORIG"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH_ORIG"
    export PYTHONPATH="$PYTHONPATH_ORIG"
  fi

  source /usr/share/"$GAZEBOVER"/setup.sh
  # sourcing /opt/ros/"$ROSVER"/setup."$CURRENT_SHELL" does not clean the var
  # CMAKE_PREFIX_PATH completely.
  # It's necessary to reset this var explicitely because I do not
  # want to have leftovers from previous loaded workspaces.
  export CMAKE_PREFIX_PATH=""
  source /opt/ros/"$ROSVER"/setup."$CURRENT_SHELL" # setup.bash or setup.zsh

  export PYTHONPATH="$PYTHONPATH:$ROS_ROOT/core/roslib/src"
}

alias rosload-default='rosLoadDefault && rosReport'

function rosInitializeWorkspace()
{
  echo "+------------------------+"
  echo "| Initializing workspace |"
  echo "+------------------------+"

  #COMMAND="${@: -1}" # last argument in CLI
  if test $# -lt 2;then
    echo -e "Arguments needed"
    exit
  fi

  mkdir -p "$2/src"

  if test "$1" = "new_catkin_tools";then
    cd "$2"
    catkin init
    cd src
  else
    cd "$2/src"
    catkin_init_workspace
  fi

  PKG=${3:-default_pkg}

  catkin_create_pkg -V 1.0.0 -a juan.rascon -m juan.rascon "$PKG" cmake_modules message_generation message_runtime roscpp roslib rospy std_msgs
  sed -i -e 's/<maintainer email="juan.rascon@todo.todo">juan.rascon/<maintainer email="juan.rascon@eurecat.org">Juan Francisco Rascon/g' "$PKG"/package.xml
  sed -i -e 's/<author >juan.rascon/<author email="juan.rascon@eurecat.org">Juan Francisco Rascon/g' "$PKG"/package.xml
  #sed -i -e 's/# add_executable/add_executable/g' "$PKG"/CMakeLists.txt
  #sed -i -e 's/# include/  include/g' "$PKG"/CMakeLists.txt
  #sed -i -e 's/# target_link_libraries(${PROJECT_NAME}_node/target_link_libraries(${PROJECT_NAME}_node ${catkin_LIBRARIES})/g' "$PKG"/CMakeLists.txt # Insert a new line after the line 'target_link_libraries ...'
  #sed -i -e '/#   ${catkin_LIBRARIES}/,+1d' "$PKG"/CMakeLists.txt #Delete the line with the pattern and the next one.
  #echo -e '#include <iostream>
  #using namespace std;
  #int main() {
  #  cout << "Hello World!" << endl;
  #  return 0;
  #}' > "$PKG"/src/"$PKG"_node.cpp

  cd ..

  if test "$1" = "new_catkin_tools";then
    rosBuildPackages new_catkin_tools --clean
  else
    rosBuildPackages old_catkin_tools --clean
  fi
}

alias rosinit-ow='rosInitializeWorkspace old_catkin_tools' # ros initialize workspace old
alias rosinit-nw='rosInitializeWorkspace new_catkin_tools' # ros initialize workspace new

# +-----------------------------+
# | SETUP ACTIVE ROS WORKSPACES |
# +-----------------------------+
export WORKSPACE_ROOT="$HOME/workspaces"

# +=======+
# | ASTRA |
# +=======+
export WS_ASTRA="$WORKSPACE_ROOT/ws_astra"
alias roscd-astra='cd $WS_ASTRA'
alias rossetup-astra='rosload-default && cd $WS_ASTRA && catkincb'
alias rosload-astra='rosLoadWS $WS_ASTRA/devel/setup.$CURRENT_SHELL'
alias rossl-astra='rossetup-astra && rosload-astra'
alias rosbl-astra='cd $WS_ASTRA && catkinb && rosload-astra'

# +=======+
# | HUSKY |
# +=======+
export WS_HUSKY="$WORKSPACE_ROOT/ws_husky"
alias roscd-husky='cd $WS_HUSKY'
alias rossetup-husky='rosload-default && cd $WS_HUSKY && catkincb'
alias rosload-husky='rosLoadWS $WS_HUSKY/devel/setup.$CURRENT_SHELL'
alias rossl-husky='rossetup-husky && rosload-husky'
alias rosbl-husky='cd $WS_HUSKY && catkinb && rosload-husky'

# =====-----=====-----=====-----=====-----=====-----

# +=============+
# | COBOLLEAGUE |
# +=============+
export WS_COBOLLEAGUE="$WORKSPACE_ROOT/ws_cobolleague"
alias roscd-cobolleague='cd $WS_COBOLLEAGUE'
alias rossetup-cobolleague='rossl-husky && cd $WS_COBOLLEAGUE && catkincb'
alias rosload-cobolleague='rosLoadWS $WS_COBOLLEAGUE/devel/setup.$CURRENT_SHELL && source $WS_COBOLLEAGUE/src/cobolleague/simulation_setup/robot_simulation_setup.sh'
alias rossl-cobolleague='rossetup-cobolleague && rosload-cobolleague'
alias rosbl-cobolleague='cd $WS_COBOLLEAGUE && catkinb && rosload-cobolleague'

# +=======+
# | HORSE |
# +=======+
export WS_HORSE="$WORKSPACE_ROOT/ws_horse"
alias roscd-horse='cd $WS_HORSE'
alias rossetup-horse='rosload-default && cd $WS_HORSE && catkincb'
alias rosload-horse='rosLoadWS $WS_HORSE/devel/setup.$CURRENT_SHELL'
alias rossl-horse='rossetup-horse && rosload-horse'
alias rosbl-horse='cd $WS_HORSE && catkinb && rosload-horse'

alias rosrun-horse-pub='reset && rosrun horse_adapter pubsim_node'
alias rosrun-horse-sub='reset && rosrun horse_adapter subsim_node'
alias rosrun-horseadapter='reset && rosrun horse_adapter hadapter_node'
alias rostopic-pub-horse='reset && rostopic pub -f $WS_HORSE/src/horse_adapter/scripts/response.yaml /horse_order_id horse_adapter/HorseResponse'

# +==========+
# | IOT DEMO |
# +==========+
export WS_IOTDEMO="$WORKSPACE_ROOT/ws_iot_demo"
alias roscd-iotdemo='cd $WS_IOTDEMO'
alias rossetup-iotdemo='rossetup-husky && rosload-husky && cd $WS_IOTDEMO && catkincb'
alias rosload-iotdemo='rosLoadWS $WS_IOTDEMO/devel/setup.$CURRENT_SHELL && source $WS_IOTDEMO/src/stack_iot_demo/iot_demo/scripts/iot_demo_config.sh'
alias rossl-iotdemo='rossetup-iotdemo && rosload-iotdemo'
alias rosbl-iotdemo='cd $WS_IOTDEMO && catkinb && rosload-iotdemo'

# +========+
# | KIVNON |
# +========+
export WS_KIVNON="$WORKSPACE_ROOT/ws_kivnon"
alias roscd-kivnon='cd $WS_KIVNON'
# alias rossetup-kivnon='rosload-default && cd $WS_KIVNON && catkincb'
alias rossetup-kivnon='rossl-astra && cd $WS_KIVNON && catkincb'
alias rosload-kivnon='rosLoadWS $WS_KIVNON/devel/setup.$CURRENT_SHELL'
alias rossl-kivnon='rossetup-kivnon && rosload-kivnon'
alias rosbl-kivnon='cd $WS_KIVNON && catkinb && rosload-kivnon'

# +===========+
# | LOGIMATIC |
# +===========+
export WS_LOGIMATIC="$WORKSPACE_ROOT/ws_logimatic"
alias roscd-logimatic='cd $WS_LOGIMATIC'
alias rossetup-logimatic='rosload-default && cd $WS_LOGIMATIC && catkincb'
alias rosload-logimatic='rosLoadWS $WS_LOGIMATIC/devel/setup.$CURRENT_SHELL && source $WS_LOGIMATIC/setup_workspace.sh'
alias rossl-logimatic='rossetup-logimatic && rosload-logimatic'
alias rosbl-logimatic='cd $WS_LOGIMATIC && catkinb && rosload-logimatic'

# +==================+
# | MASTER RAMON RIU |
# +==================+
export WS_RIVER="$WORKSPACE_ROOT/ws_river"
alias roscd-river='cd $WS_RIVER'
alias rossetup-river='rossetup-husky && rosload-husky && cd $WS_RIVER && catkincb'
alias rosload-river='rosLoadWS $WS_RIVER/devel/setup.$CURRENT_SHELL && source $WS_RIVER/src/nav3d/nav3d_gazebo/simulation_setup/robot_simulation_setup.sh'
alias rossl-river='rossetup-river && rosload-river'
alias rosbl-river='cd $WS_RIVER && catkinb && rosload-river'

# ROBOT IGNITE ACADEMY
#export WS_RIA="$WORKSPACE_ROOT/ws_ria"
#alias rosload-ria='rosLoadWS $WS_RIA'

# TURTLE DEMO
#export WS_TURTLE_DEMO="$WORKSPACE_ROOT/ws_turtle_demo"
#alias rosload-tdemo='rosLoadWS $WS_TURTLE_DEMO'

# ==========================================================================
# ==========================================================================
# ==========================================================================
# ==========================================================================
# ==========================================================================

# ==========================================================================

# I do not want the messages echoed in the function 'rosLoadDefault' printed
# in the terminal when the script '.ros_config.sh' is sourced when launching a
# that terminal.
rosLoadDefault 1> /dev/null

# ==========================================================================



