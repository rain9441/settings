@echo on

CP -r "%~dp0.vimrc" "%HOME%"
if %errorlevel% neq 0 exit /b %errorlevel%

CP -r "%~dp0.vsvimrc" "%HOME%"
if %errorlevel% neq 0 exit /b %errorlevel%

mkdir "%HOME%/vimfiles"
mkdir "%HOME%/vimfiles/autoload"
mkdir "%HOME%/vimfiles/bundle"

mklink /d "%HOME%/.vim" "%HOME%/vimfiles"

"c:\Program Files\Git\mingw64\bin\curl.exe" -LSso "%HOME%/vimfiles/autoload/pathogen.vim" "https://tpo.pe/pathogen.vim"

pushd "%HOME%/vimfiles/bundle"
git clone https://github.com/kien/ctrlp.vim.git
REM git clone https://github.com/Shougo/neocomplete.vim.git
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/scrooloose/syntastic.git
git clone https://github.com/tpope/vim-dispatch.git
git clone https://github.com/Lokaltog/vim-easymotion.git

REM git clone https://github.com/Shougo/vimproc.vim.git
REM pushd "%HOME%/vimfiles/bundle/vimproc.vim"
REM make // this should eventually work but doesn't
REM popd

git clone https://github.com/Quramy/tsuquyomi.git
git clone https://github.com/leafgarland/typescript-vim.git
git clone https://github.com/Quramy/vim-js-pretty-template.git
git clone https://github.com/jason0x43/vim-js-indent.git
git clone https://github.com/Quramy/vim-dtsm.git
git clone https://github.com/mhartington/vim-typings.git
git clone https://github.com/dracula/vim.git dracula-theme.git

popd

echo vim settings installed successfully

