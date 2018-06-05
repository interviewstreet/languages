#
# Cookbook:: languages
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved

directory '/var/ml' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? '/var/ml' }
end

## Install Cpp ML libraries
[node[:cpp][:ml_home], node[:cpp][:ml_home] + '/include', node[:cpp][:ml_home] + '/lib'].each do |item|
  directory item do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    not_if { ::Dir.exists? item }
  end
end

node[:cpp][:additional_ml_libraries].each do |library|
  library_name = library['name']
  library_url = library['url']
  # Extract
  tar_extract library_url do
    user 'root'
    target_dir '/tmp/'
    creates '/tmp/' + library_name
  end
  # Build and copy
  execute "build-#{library_name}" do
    user 'root'
    cwd '/tmp/' + library_name
    command <<-EOH
      make lib
      mv *.so.* #{node[:cpp][:ml_home]}/lib
      mv *.h #{node[:cpp][:ml_home]}/include
    EOH
  end
end

execute 'soft-link-cpp-ml-libs' do
  user 'root'
  cwd node[:cpp][:ml_home] + '/lib'
  command <<-EOH
    ln -sfn libsvm.so.2 libsvm.so
    ln -sfn liblinear.so.3 liblinear.so
  EOH
end

## Install clang
package 'clang'

## Install JAVA 7
#include_recipe 'java'
java_ark "install-jdk-7" do
    url node[:java7][:url]
    app_home node[:java7][:home]
    action :install
end

## Install JAVA 8
java_ark "install-jdk-8" do
    url node[:java8][:url]
    app_home node[:java8][:home]
    bin_cmds ["java", "javac"]
    action :install
end

## Install JAVA 9
ark "install-jdk-9" do
    url node[:java9][:url]
    version node['java9']['version']
    path node[:java9][:home]
    action :install
end

execute 'set-java-home' do
  user 'root'
  command <<-EOH
    echo export JAVA_HOME=#{node[:java8][:home]} >> /etc/environment
  EOH
  not_if 'cat /etc/environment | grep "JAVA_HOME"'
end

node[:java][:additional_libraries]. each do |library|
  basename = File.basename(library).gsub(/-\d+.\d+.\d+/, '')
  remote_file (node[:java][:libraries_home] + '/' + basename) do
    user 'root'
    source library
  end
end

## Install Java ML libraries
directory node[:java][:ml_home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:java][:ml_home] }
end

node[:java][:additional_ml_libraries]. each do |library|
  basename = File.basename library
  remote_file ('/tmp/' + basename) do
    user 'root'
    source library
  end
  execute ('/tmp/' + basename) do
    if basename.include? "zip"
      command "unzip -oj /tmp/#{basename} *.jar -d #{node[:java][:ml_home]}"
    else
      command "mv /tmp/#{basename} #{node[:java][:ml_home]}"
    end
    user "root"
  end
end

## Install junixsocket for Java
native_lib_base = "/usr/local/lib"
if node['platform'] == 'ubuntu'
  native_lib = "libjunixsocket-linux-1.5-amd64.so"
else
  native_lib = "libjunixsocket-macosx-1.5-x86_64.dylib"
end

tar_extract 'https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/junixsocket/junixsocket-1.3-bin.tar.bz2' do
  user 'root'
  target_dir '/tmp'
  creates '/tmp/junixsocket-1.3'
  compress_char 'j'
  notifies :run, "execute[install-junixsocket]", :immediately
  not_if  { ::File.exists? "#{native_lib_base}/#{native_lib}" }
end

execute 'install-junixsocket' do
  user 'root'
  cwd '/tmp/junixsocket-1.3'
  command <<-EOH
    cp dist/junixsocket-1.3.jar #{node[:java][:libraries_home]}/junixsocket.jar
    cp lib-native/#{native_lib} #{native_lib_base}
  EOH
  action :nothing
end

## Install Scala
ark "scala" do
  url node[:scala][:url]
  checksum node[:scala][:checksum]
  home_dir node[:scala][:home]
  version node[:scala][:version]
  append_env_path true
  action :install
  mode 0755
end

template "/etc/profile.d/scala_home.sh" do
  mode 0755
  source "scala_home.sh.erb"
  variables(:scala_home => node[:scala][:home])
end

node[:scala][:additional_libraries]. each do |library|
basename = File.basename(library).gsub(/-\d+.\d+.\d+/, '')
  remote_file (node[:scala][:home] + '/lib/' + basename) do
    user 'root'
    source library
  end
end

node[:scala][:twitter_libraries]. each do |library|
  basename = File.basename(library).gsub(/-\d+.\d+.\d+/, '')
  remote_file (node[:java][:ml_home] + '/' + basename) do
    user 'root'
    source library
  end
end

## Install sbt
apt_repository "sbt" do
  uri "https://dl.bintray.com/sbt/debian"
  distribution '/'
  keyserver "keyserver.ubuntu.com"
  key '2EE0EA64E40A89B84B2DF73499E82A75642AC823'
end
package ['sbt']

## Install Go Lang
include_recipe 'golang::default'
include_recipe 'golang::packages'

## Install NodeJS & NPM packages
include_recipe "nodejs"
include_recipe "nodejs::npm_packages"

# Install .Net Core
#include_recipe "dotnetcore"

# Install Mono
apt_repository 'latest-mono' do
  uri 'http://download.mono-project.com/repo/debian'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key '3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF'
end
package ['mono-devel', 'mono-complete', 'ca-certificates-mono']
package node['mono']['additional_libraries']

## VBNC
package 'mono-vbnc'

## PHP7.2
apt_repository 'latest-php7.2' do
  uri          'ppa:ondrej/php'
end
package 'php7.2'

## Install PHP7.2
package node['php']['additional_libraries']

remote_file '/usr/local/bin/phpunit' do
  user 'root'
  mode '0755'
  source 'https://phar.phpunit.de/phpunit.phar'
end

## Install Clisp
package 'clisp'

## Install LUA
package 'lua5.3'

## Install Fsharp
package 'fsharp'

## Install R Lang and libraries
apt_repository "latest-r-base" do
  uri "http://cran.rstudio.com/bin/linux/ubuntu"
  distribution node['lsb']['codename'] + '/'
  keyserver 'keyserver.ubuntu.com'
  key 'E084DAB9'
end
package ['r-base', 'r-base-dev']

link '/usr/lib/x86_64-linux-gnu/libgfortran.so' do
  to '/usr/lib/x86_64-linux-gnu/libgfortran.so.3.0.0'
  link_type :symbolic
end

execute "update-r-lang" do
  user 'root'
  command "R -e \"update.packages(checkBuilt = TRUE, ask=FALSE, repos=\'http://cran.us.r-project.org\')\""
  only_if "dpkg -l r-base"
end

node[:r][:additional_libraries].each do |library|
  execute "install-r-#{library}" do
    user 'root'
    command <<-EOH
      PATH=$PATH:/usr/lib/x86_64-linux-gnu R -e "install.packages(\'#{library}\', repos='http://cran.us.r-project.org', dependencies=TRUE)"
      PATH=$PATH:/usr/lib/x86_64-linux-gnu R -e "library(#{library})"
    EOH
  end
end

## Install Erlang and Elixir
apt_repository "erlang" do
  uri "https://packages.erlang-solutions.com/ubuntu"
  distribution node['lsb']['codename']
  components ['contrib']
  keyserver "keyserver.ubuntu.com"
  key 'A14F4FCA'
end
package ['erlang-base', 'erlang', 'elixir']

## Install Nim
directory node[:nim][:home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:nim][:home] }
end

tar_extract "http://nim-lang.org/download/nim-#{node[:nim][:version]}.tar.xz" do
  user 'root'
  target_dir node[:nim][:home]
  creates node[:nim][:home] + '/bin'
  tar_flags [ '-P', '--strip-components 1' ]
  notifies :run, "execute[build-nim]", :immediately
end

execute 'build-nim' do
  user 'root'
  cwd node[:nim][:home]
  command 'sh build.sh'
  action :nothing
end

## Install MIT Scheme
directory node[:mitscheme][:home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:mitscheme][:home] }
end

tar_extract "http://ftp.gnu.org/gnu/mit-scheme/stable.pkg/#{node[:mitscheme][:version]}/mit-scheme-#{node[:mitscheme][:version]}-x86-64.tar.gz" do
  user 'root'
  target_dir node[:mitscheme][:home]
  creates node[:mitscheme][:home] + '/src'
  tar_flags [ '-P', '--strip-components 1' ]
  notifies :run, "execute[build-mitscheme]", :immediately
end

execute 'build-mitscheme' do
  user 'root'
  cwd node[:mitscheme][:home] + '/src'
  command <<-EOH
    ./configure
    make compile-microcode
    make install
  EOH
  action :nothing
end


## Install Ruby
include_recipe 'ruby_build'
ruby_build_ruby node[:ruby][:version] do
  prefix_path node[:ruby][:home]
end

## Install Python 2 & 3
include_recipe 'poise-python'

## Install Python 3.6
apt_repository 'latest-python3' do
    uri        'ppa:jonathonf/python-3.6'
end

package 'python' + node['python3']['version']

alternatives 'python3 alternatives' do
  link_name 'python3'
  path '/usr/bin/python' + node['python3']['version']
  priority 100
  action :install
end

## Install Python 2 packages
python_runtime '2'
python_package node[:python][:additional_libraries]

## Install Python 2 ML virtualenv
python_virtualenv node[:python][:ml_home]
python_package (node[:python][:additional_libraries] + node[:python][:additional_ml_libraries]) do
  virtualenv node[:python][:ml_home]
end

## Install Python 3 packages
python_runtime '3'
python_package node[:python][:additional_libraries]

## Install Python 3 ML virtualenv
python_virtualenv node[:python3][:ml_home]
python_package (node[:python][:additional_libraries] + node[:python][:additional_ml_libraries]) do
  virtualenv node[:python3][:ml_home]
end

## install Rust
remote_file '/tmp/rustup.sh' do
  user 'root'
  mode '0755'
  source 'https://static.rust-lang.org/rustup.sh'
  notifies :run, "execute[install-rust]", :immediately
end

execute 'install-rust' do
  command '/tmp/rustup.sh --yes'
  user 'root'
  action :nothing
end

## Cache rust libraries as rebuilding them takes a lot of time
execute 'cache-rust-libraries' do
  user 'root'
  cwd '/usr/local/lib'
  command <<-EOH
    cargo new rust_hello_world --bin
    echo '#{node[:rust][:additional_libraries]}' | cat >> /usr/local/lib/rust_hello_world/Cargo.toml
    cd /usr/local/lib/rust_hello_world && cargo build --release
  EOH
end

## Install Dart lang
package 'apt-transport-https'
apt_repository "dart" do
  uri "https://storage.googleapis.com/download.dartlang.org/linux/debian"
  distribution ''
  components ['stable', 'main']
  key 'https://dl-ssl.google.com/linux/linux_signing_key.pub'
  trusted true # TODO: Fix this
end
package ['dart']

## Install D lang
apt_repository "dlang" do
  uri "http://master.dl.sourceforge.net/project/d-apt/"
  distribution ''
  components ['d-apt', 'main']
  key 'https://dlang.org/d-keyring.gpg'
  trusted true # TODO: Fix this
end
package ['dmd-bin']

## Install SBCL
tar_extract "http://prdownloads.sourceforge.net/sbcl/sbcl-#{node[:sbcl][:version]}-x86-64-linux-binary.tar.bz2" do
  user 'root'
  target_dir '/tmp'
  creates '/tmp/sbcl-' + node[:sbcl][:version] + '-x86-64-linux'
  compress_char 'j'
end

execute 'build-sbcl' do
  user 'root'
  cwd '/tmp/sbcl-' + node[:sbcl][:version] + '-x86-64-linux'
  command 'sh install.sh'
end

## Install Lolcode
tar_extract "https://github.com/justinmeza/lci/archive/master.tar.gz" do
  user 'root'
  target_dir '/tmp'
  creates '/tmp/lci-master'
end

execute 'build-lolcode' do
  user 'root'
  cwd '/tmp/lci-master'
  command "python install.py --prefix=\"#{node[:lolcode][:home]}\""
end

## Install kotlin
remote_file '/tmp/kotlin.zip' do
  user 'root'
  source "https://github.com/JetBrains/kotlin/releases/download/v#{node[:kotlin][:version]}/kotlin-compiler-#{node[:kotlin][:version]}.zip"
end
zipfile '/tmp/kotlin.zip' do
  into '/usr/local'
end

## Install Groovy
ark "groovy" do
  url node[:groovy][:url]
  checksum node[:groovy][:checksum]
  home_dir node[:groovy][:home]
  version node[:groovy][:version]
  append_env_path true
  action :install
end

template "/etc/profile.d/groovy_home.sh" do
  mode 0755
  source "groovy_home.sh.erb"
  variables(:groovy_home => node[:groovy][:home])
end

## Install Haxe
apt_repository 'latest-haxe' do
  uri          'ppa:haxe/releases'
end
package 'haxe'

## Install gfortran
package 'gfortran'

# Setup Haxe
directory node[:haxe][:lib_home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:haxe][:lib_home] }
  notifies :run, "execute[setup-haxe]", :immediately
end

execute 'setup-haxe' do
  user 'root'
  command <<-EOH
    haxelib setup #{node[:haxe][:lib_home]}
    haxelib install hxjava
    haxelib install hxcpp
  EOH
  action :nothing
end

## Install Haskell
remote_file '/tmp/haskellstack.sh' do
  user 'root'
  mode '0755'
  source 'https://get.haskellstack.org/'
  notifies :run, "execute[install-haskell]", :immediately
end

execute 'install-haskell' do
  user 'root'
  command <<-EOH
    sh /tmp/haskellstack.sh
    # Upgrade stack version
    stack --stack-root #{node[:haskell][:home]} upgrade
    # Updates packages info
    stack --stack-root #{node[:haskell][:home]} update
    # Setting up ghc compiler
    stack --stack-root #{node[:haskell][:home]} setup
    # Install packages
    stack --stack-root #{node[:haskell][:home]} install #{node[:haskell][:additional_libraries]}
  EOH
  action :nothing
end

## Install OCaml
package ['opam']
execute 'install-ocaml-packages' do
  user 'root'
  command <<-EOH
    opam init --yes --root=#{node[:ocaml][:home]}
    eval `opam config env --root=#{node[:ocaml][:home]}`
    opam update --yes
    opam switch --yes #{node[:ocaml][:version]}
    opam install --yes #{node[:ocaml][:additional_libraries]}
    opam upgrade --yes
  EOH
end

## Install PYPY 2&3
[node[:pypy][:home], node[:pypy3][:home]].each do |dir|
  directory dir do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    not_if { ::Dir.exists? dir }
  end
end

tar_extract "https://bitbucket.org/pypy/pypy/downloads/#{node[:pypy][:version]}-linux64.tar.bz2" do
  user 'root'
  target_dir node[:pypy][:home]
  creates node[:pypy][:home] + "/bin"
  compress_char 'j'
  tar_flags [ '-P', '--strip-components 1' ]
  notifies :run, "execute[setup-pypy-pip]", :immediately
end

execute 'setup-pypy-pip' do
  user 'root'
  cwd node[:pypy][:home]
  command <<-EOH
    bin/pypy -m ensurepip
    bin/pip update
    bin/pip install #{node[:pypy][:additional_libraries].join(' ')}
  EOH
  action :nothing
end

tar_extract "https://bitbucket.org/pypy/pypy/downloads/#{node[:pypy3][:version]}-linux64.tar.bz2" do
  user 'root'
  target_dir node[:pypy3][:home]
  creates node[:pypy3][:home] + "/bin"
  compress_char 'j'
  tar_flags [ '-P', '--strip-components 1' ]
  notifies :run, "execute[setup-pypy3-pip]", :immediately
end

execute 'setup-pypy3-pip' do
  user 'root'
  cwd node[:pypy3][:home]
  command <<-EOH
    bin/pypy3 -m ensurepip
    bin/pip3 update
    bin/pip3 install #{node[:pypy][:additional_libraries].join(' ')}
  EOH
  action :nothing
end

execute 'setup-pypy-ml' do
  user 'root'
  command <<-EOH
    virtualenv -p #{node[:pypy][:home]}/bin/pypy #{node[:pypy][:ml_home]}
    source #{node[:pypy][:ml_home]}/bin/activate
    #{node[:pypy][:ml_home]}/bin/pip install #{node[:pypy][:additional_libraries].join(" ")}
    #{node[:pypy][:ml_home]}/bin/pip install #{node[:pypy][:additional_ml_libraries].join(" ")}
  EOH
  #live_stream true if Chef::Resource::Execute.method_defined?(:live_stream)
  not_if { ::Dir.exists? node[:pypy][:ml_home] }
end

execute 'setup-pypy3-ml' do
  user 'root'
  command <<-EOH
    virtualenv -p #{node[:pypy3][:home]}/bin/pypy3 #{node[:pypy3][:ml_home]}
    source #{node[:pypy3][:ml_home]}/bin/activate
    #{node[:pypy3][:ml_home]}/bin/pip3 install #{node[:pypy][:additional_libraries].join(" ")}
    #{node[:pypy3][:ml_home]}/bin/pip3 install #{node[:pypy][:additional_ml_libraries].join(" ")}
  EOH
  #live_stream true if Chef::Resource::Execute.method_defined?(:live_stream)
  not_if { ::Dir.exists? node[:pypy3][:ml_home] }
end

## pypy installation is broken in the recipe poise-python
# ## Install PYPY 2
# python_runtime 'pypy' do
#   provider :portable_pypy
#   version node[:pypy][:version]
#   options folder: node[:pypy][:home]
# end
# python_package node[:python][:additional_libraries]

# ## Install PYPY 2 ML virtualenv
# python_virtualenv node[:pypy][:ml_home]
# python_package (node[:pypy][:additional_libraries] + node[:pypy][:additional_ml_libraries]) do
#   virtualenv node[:pypy][:ml_home]
# end

# ## Install PYPY 3
# python_runtime 'pypy3' do
#   provider :portable_pypy3
#   version node[:pypy3][:version]
#   options folder: node[:pypy3][:home]
# end
# python_package node[:python][:additional_libraries]

# ## Install PYPY 3 ML virtualenv
# python_virtualenv node[:pypy3][:ml_home]
# python_package (node[:pypy][:additional_libraries] + node[:pypy][:additional_ml_libraries]) do
#   virtualenv node[:pypy3][:ml_home]
# end

## Install pascal
package 'fpc'

# Racket 6.10.1 is crashing during execution. Installing previous version for the time being
# ## Install Racket
# apt_repository 'latest-racket' do
#   uri          'ppa:plt/racket'
# end
# package 'racket'

## Install Racket
remote_file '/tmp/racket-linux.sh' do
  user 'root'
  mode '0755'
  source node[:racket][:url]
  notifies :run, "execute[install-racket]", :immediately
end

execute 'install-racket' do
  command "bash /tmp/racket-linux.sh --unix-style --dest #{node[:racket][:home]} --create-dir"
  user 'root'
  action :nothing
end

# TODO: libgfortran seem to go missing at this stage
execute 'force-install-libgfortran' do
  user 'root'
  command 'apt-get install --reinstall libgfortran3'
end

## Install Octave
apt_repository 'latest-octave' do
  uri          'ppa:octave/stable'
end
package ['octave', 'octave-image']

## Install Brainf*ck
package 'bf'

## Install open-cobol
package 'open-cobol'

## Install Common Lisp
package 'cl-ppcre'

## Install GNU Smalltalk
package 'gnu-smalltalk'

## Install XQuery
package 'basex'

## Install Julia
directory node[:julia][:home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:julia][:home] }
end

tar_extract node[:julia][:url] do
  user 'root'
  target_dir node[:julia][:home]
  creates node[:julia][:home] + '/bin'
  tar_flags [ '-P', '--strip-components 1' ]
end

## Install Tool Command Language
package 'tcl'

## Install GNU Ada
package 'gnat'

## Install GNU Prolog
package 'gprolog'

## Install SML/NJ
package 'smlnj'

## Install Clojure
node[:clojure][:additional_libraries]. each do |library|
  basename = File.basename(library).gsub(/-\d+.\d+.\d+/, '')
  remote_file (node[:java][:libraries_home] + '/' + basename) do
    user 'root'
    source library
  end
end
package 'clojure1.6'

## Install Perl
# # Upgrade perl
# execute 'upgrade-perl' do
#   user 'root'
#   cwd '/tmp'
#   command 'PERL_MM_USE_DEFAULT=1 perl -MCPAN -e \'upgrade\''
# end

node['perl']['additional_libraries'].each do |library|
  execute "install-perl-#{library}" do
    user 'root'
    command "PERL_MM_USE_DEFAULT=1 perl -MCPAN -e \'install #{library}\';"
  end
end

directory node[:perl][:ml_home] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  not_if { ::Dir.exists? node[:perl][:ml_home] }
end

# Ref: http://pierre.palatin.fr/entries/perl-virtual-env
remote_file "/tmp/local-lib-2.tar.gz" do
  user 'root'
  source "http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/local-lib-2.000019.tar.gz"
  notifies :run, "execute[install-perl-ml-root]", :immediately
end

execute "install-perl-ml-root" do
  user "root"
  cwd node[:perl][:ml_home]
  command <<-EOH
    sudo tar -zxf /tmp/local-lib-2.tar.gz
    cd local-lib-*
    sudo perl Makefile.PL --bootstrap=#{node[:perl][:ml_home]}
    sudo make test
    sudo make install
  EOH
  action :nothing
  only_if { ::File.exists? "/tmp/local-lib-2.tar.gz" }
end

(node['perl']['additional_libraries'] + node['perl']['additional_ml_libraries']).each do |library|
  execute "install-perl-ml-#{library}" do
    user 'root'
    command "PERL_MM_USE_DEFAULT=1 perl -I/var/ml/perl/lib/perl5 -Mlocal::lib=/var/ml/perl -MCPAN -e \"CPAN::Shell->notest(\'install\', \'#{library}\')\";"
  end
end

## Perl 6
apt_repository 'latest-perl6' do
  uri          'ppa:jonathonf/perl6'
end
package 'rakudo'

# Install zef which is a package manager for perl6
git "/tmp/zef" do
  repository 'https://github.com/ugexe/zef'
  revision 'master'
  notifies :run, "execute[install-rakudo-zef]", :immediately
end
execute 'install-rakudo-zef' do
  cwd '/tmp/zef'
  command 'perl6 -Ilib bin/zef install .'
  action :nothing
end

# Install additional libraries
node['perl6']['additional_libraries'].each do |library|
  execute "install-perl6-#{library}" do
    user 'root'
    command "/usr/lib/perl6/site/bin/zef install #{library}"
  end
end

## Install Idris
# execute 'install-idris' do
#   user 'root'
#   command <<-EOH
#     stack --stack-root #{node[:haskell][:home]} install idris
#   EOH
# end
