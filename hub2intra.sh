#/bin/bash

github=https://github.com/your_login_github/the_project
intra=git@vogsphere-v2.42sp.org.br:vogsphere/intra-uuid-xxxxxx-your_login_intra
turn_in_files=path/to/turn_in_files


cd /tmp
sort -o /tmp/ref $turn_in_files 
if [ ! -d "launcher" ]; then
  mkdir launcher
fi
cd launcher
if [ ! -d "github" ]; then
  git clone $github github/
fi
if [ ! -d "intra" ]; then
  git clone $intra intra/
fi
cd github
xargs -a /tmp/ref cp -t ../intra
cd ..
ls -1 intra/ > recebido
diff /tmp/ref recebido
cd intra
xargs -a /tmp/ref git add
git commit -m "automated"
git push

cd /tmp
if [ ! -d "landing" ]; then
  mkdir landing
fi
cd landing
if [ ! -d "intra" ]; then
  git clone $intra intra/
fi
ls -1 intra/ > recebido
if [ ! $(diff /tmp/ref recebido) ]; then
  echo "Sucesso!"
  rm -rf /tmp/launcher/
  rm -rf /tmp/landing/
  rm -rf /tmp/ref
fi
