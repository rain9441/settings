@echo on

CP -r "%~dp0.vimrc" "%HOME%"
if %errorlevel% neq 0 exit /b %errorlevel%

CP -r "%~dp0.vsvimrc" "%HOME%"
if %errorlevel% neq 0 exit /b %errorlevel%

mkdir "%HOME%/vimfiles"
mkdir "%HOME%/vimfiles/autoload"
mkdir "%HOME%/vimfiles/bundle"

ln -s "%HOME%/vimfiles" "%HOME%/.vim"

"c:\Program Files\Git\mingw64\bin\curl.exe" -LSso "%HOME%/vimfiles/autoload/pathogen.vim" "https://tpo.pe/pathogen.vim"

git clone https://github.com/kien/ctrlp.vim.git "%HOME%/vimfiles/bundle/ctrlp.vim"
git clone https://github.com/Shougo/neocomplete.vim.git "%HOME%/vimfiles/bundle/neocomplete.vim"
git clone https://github.com/scrooloose/nerdtree.git "%HOME%/vimfiles/bundle/nerdtree.vim"
git clone https://github.com/scrooloose/syntastic.git "%HOME%/vimfiles/bundle/syntastic.vim"
git clone https://github.com/tpope/vim-dispatch.git "%HOME%/vimfiles/bundle/vim-dispatch.vim"
git clone https://github.com/Lokaltog/vim-easymotion.git "%HOME%/vimfiles/bundle/vim-easymotion.vim"

echo vim settings installed successfully

