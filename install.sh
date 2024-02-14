SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
SCRIPT_NAME=$(basename ${SOURCE})
SCRIPT_PATH="${SCRIPT_DIR}/${SCRIPT_NAME}"

mv ${HOME}/.vim ${HOME}/.vimbak$(date -d "today" +"%Y%m%d_%H%M")
mkdir -p ${HOME}/.vim
mkdir -p ${HOME}/.vim/colors && cd ${HOME}/.vim/colors && ln -s $SCRIPT_DIR/miscfiles/wombat256mod.vim wombat256mod.vim
xrdb -merge ${HOME}/.Xresources
mkdir -p ${HOME}/.vim/autoload ${HOME}/.vim/bundle
cd ${HOME}/.vim
git clone https://github.com/tpope/vim-pathogen.git --depth=1
cd ${HOME}/.vim/autoload
ln -s ../vim-pathogen/autoload/pathogen.vim ./pathogen.vim
cd ${HOME}/.vim/vim-pathogen
cd ${HOME}/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git --depth=1
git clone https://github.com/scrooloose/syntastic.git --depth=1
git clone https://github.com/tpope/vim-commentary.git --depth=1
git clone https://github.com/tpope/vim-surround.git --depth=1
git clone https://github.com/ntpeters/vim-better-whitespace.git --depth=1
git clone https://github.com/ervandew/supertab.git --depth=1
git clone https://github.com/majutsushi/tagbar.git --depth=1
cp ${HOME}/syncfiles/patches/tagbar.patch ${HOME}/.vim/bundle/tagbar/plugin/
patch ${HOME}/.vim/bundle/tagbar/plugin/tagbar.vim -bnN -i ${HOME}/.vim/bundle/tagbar/plugin/tagbar.patch
mkdir -p ${HOME}/.vim/plugin
cd ${HOME}/.vim/plugin
ln -s $SCRIPT_DIR/resources/toggle.vim

rm -f ${HOME}/.bashrc && ln -s ${HOME}/syncfiles/dotfiles/bashrc ${HOME}/.bashrc
rm -f ${HOME}/.screenrc && ln -s ${HOME}/syncfiles/dotfiles/screenrc ${HOME}/.screenrc
rm -f ${HOME}/.vimrc && ln -s ${HOME}/syncfiles/dotfiles/vimrc ${HOME}/.vimrc
rm -f ${HOME}/.Xresources && ln -s ${HOME}/syncfiles/dotfiles/Xresources ${HOME}/.Xresources
rm -f ${HOME}/.tmux.conf && ln -s ${HOME}/syncfiles/dotfiles/tmuxrc ${HOME}/.tmux.conf
