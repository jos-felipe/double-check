#/bin/bash

github=https://github.com/your_login_github/the_project
intra=git@vogsphere-v2.42sp.org.br:vogsphere/intra-uuid-xxxxxx-your_login_intra
turn_in_files=path/to/turn_in_files


cd /tmp
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
xargs -a $turn_in_files cp -t ../intra
cd ..
ls -1 intra/ > recebido
diff $turn_in_files recebido
cd intra
xargs -a $turn_in_files git add
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
if [ ! $(diff $turn_in_files recebido) ]; then
  echo "Sucesso!"
  rm -rf /tmp/launcher/
  rm -rf /tmp/landing/
fi
