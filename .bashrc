# ziyuan Wang 10/05/2011 at LW


#enviromental variables
export HISTCONTROL=ignoredups
export HISTFILESIZE=5000
export ASSERT=/home/zwang/CODE/assert/assert-v0.14b
export TINY_SVM=/home/zwang/tools/TinySVM/
export YAMCHA=/home/zwang/tools/yamcha/
export CHARNIAK_PARSER=/home/zwang/CODE/reranking-parser/
export PATH=.:/usr/lib64/ccache/:/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin/:/home/zwang/tools/:$TINY_SVM/bin:$YAMCHA/bin:$CHARNIAK_PARSER:/home/zwang/CODE/ASEtools/genapex/trunk/App/:/home/zwang/perl5/bin/:/home/zwang/tools/valgrind3.8.1/bin
export CLICOLOR=1
export PS1="\u@\H \W \! \$ "
export LANG=en_US.UTF-8
export LS_COLORS='di=1;93:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=36'
export SVN_EDITOR=emacs
#export RACERX_THIRDPARTY_PATH=/c05_data/zwang/code/x/3rdParty
export XMT_EXTERNALS_PATH=/home/zwang/CODE/xmt-externals/FC12
export PYTHONPATH=/home/zwang/CODE/xmt-git/python/:$PYTHONPATH
export SRILM=/home/zwang/tools/srilm/

# export PERL_LOCAL_LIB_ROOT="/home/zwang/perl5";
# export PERL_MB_OPT="--install_base /home/zwang/perl5";
# export PERL_MM_OPT="INSTALL_BASE=/home/zwang/perl5";
export PERL5LIB=/home/zwang/CODE/ct/coretraining/main/3rdParty/perl_libs/:/home/zwang/CODE/ct/coretraining/main/Shared/PerlLib/:/home/zwang/CODE/ct/coretraining/main/Shared/PerlLib/TroyPerlLib/
#:/home/zwang/lib/perl/:/home/zwang/lib/perl/lib64/perl5/site_perl/5.10.0/x86_64-linux-thread-multi/:/home/zwang/lib/perl/lib/perl5/site_perl/5.10.0/:/home/zwang/perl5/lib/perl5/x86_64-linux-thread-multi:/home/zwang/perl5/lib/perl5;

export LANG=en_US.UTF-8
export CT=/home/zwang/CODE/ct/coretraining/main/

#cpp variables
export C_INCLUDE_PATH=/home/zwang/include/:/usr/include/:$C_INCLUDE_PATH; #set include path for gcc
export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH;
export LIBRARY_PATH=/home/zwang/lib/:$LIBRARY_PATH  # set static lib path for gcc
export LD_RUN_PATH=/home/zwang/lib/:$LD_RUN_PATH #set rpath, which affects linker, by doing so, we don't need LD_LIBRARY_PATH at runtime

export LD_LIBRARY_PATH=.:/home/zwang/CODE/ct/coretraining/main/libtbb-4_0_5/:/home/zwang/CODE/ct/coretraining/main/lib/:/home/zwang/CODE/xmt/xmt-externals/libraries/icu-4.8/lib/:/home/mdreyer/software/openfst-1.3.1/lib/:/home/TrainEval/trainmt/lib/boost-1_35_1_64:/home/TrainEval/trainmt/lib/boost-1_33_1_64:/home/TrainEval/trainmt/lib/smartheap:/home/TrainEval/trainmt/lib/cmph:/home/TrainEval/trainmt/lib/octopus_libs:/home/zwang/CODE/xmt/xmt-externals/libraries/boost_1_49_0/lib/

# source this file to set the environment for Cloudera 3 update 3 on loch
# need JAVA home set and in the path, if it isn't already
if [  "x$JAVA_HOME" == "x" ]; then
 export JAVA_HOME=/home/hadoop/jdk1.6.0_24
 export PATH=$JAVA_HOME/bin:$PATH
fi
# hadoop variables needed to run utilities at the command line, e.g., pig/hadoop
export HADOOP_INSTALL=/home/hadoop/hadoop/hadoop-0.20.2-cdh3u3
export PATH=$HADOOP_INSTALL/bin:$PATH
export HADOOP_CONF_DIR=/home/hadoop/loch-client-conf
export HADOOP_HOME=$HADOOP_INSTALL
export PIG_INSTALL=/home/hadoop/hadoop/pig-0.8.1-cdh3u3
export PATH=$PIG_INSTALL/bin:$PATH
export PIG_HADOOP_VERSION=20
export PIG_CLASSPATH=$HADOOP_CONF_DIR:/home/hadoop/hadoop/jython/jython.jar


# local history
alias useHistory='grep -v "^ls$\|^lt$\|^ll$\|^l$\|^dir$\|^cd \|^h$\|^gh$\|^h \|^bg$\|^fg$\|^qsm$\|^quser$\|^cStat\|^note \|^mutt\|^std\|^jobs\|^less\|^emacs" | wc -l'
alias h='cat .history | grep --binary-file=text '

function myLocalHistory()
{
    if [[ $? -eq 0 ]]; then
	if [[ `ls -ld "$PWD" | awk '{print $3}'` == "$USER"  ]] ; then
	    HISTORYLINE=`history | tail -1 | sed 's:^ *[0-9]* *::g'`;
            if [[ `echo $HISTORYLINE | useHistory` == 1 && "$HISTORYLINE" != "$LAST_HISTORYLINE" ]] ; then
		(((date +%F.%H-%M-%S.;uname -n) | tr -d '\n' ; echo " $HISTORYLINE") >>.history) 2>/dev/null
		export LAST_HISTORYLINE=$HISTORYLINE;
            #sync
            # hostname | awk '{printf(" %-20s ",$1)}'
            fi
	fi
    fi
}

export PROMPT_COMMAND="myLocalHistory"

#aliasing
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ltm='ls -lt |more'
alias lt='ls -ltr'
alias x='emacs -nw'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias psm='ps aux | grep "^zwang40"'
alias tar='tar -k'
alias q='condor_q'
alias diff='diff -wBb' # ignore white spaces and blank lines
alias ediff='emacs -diff'

# git stuff
. ~/.git-completion.bash
