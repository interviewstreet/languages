# C & C++
default['cpp']['ml_home'] = '/var/ml/cpp'
default['cpp']['additional_ml_libraries'] = [{'name' => 'libsvm-3.23',
		'url' => 'http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+tar.gz'},
	{'name' => 'liblinear-2.21',
		'url' => 'http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/liblinear.cgi?+http://www.csie.ntu.edu.tw/~cjlin/liblinear+tar.gz'}]

# Java
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['accept_license_agreement'] = true

# Java Version
default['java7']['url'] = 'http://codechecker-install-essentials.s3.amazonaws.com/jdk-7u80-linux-x64.tar.gz'
default['java8']['url'] = 'http://codechecker-install-essentials.s3.amazonaws.com/jdk-8u191-linux-x64.tar.gz'
default['java11']['url'] = 'http://codechecker-install-essentials.s3.amazonaws.com/jdk-11.0.1_linux-x64_bin.tar.gz'
default['java7']['home'] = '/usr/lib/jvm/java-7-sun'
default['java8']['home'] = '/usr/lib/jvm/java-8-sun'
default['java11']['home'] = '/usr/lib/jvm/java-11-sun'
default['java']['ml_home'] = '/var/ml/java'
if node['platform'] == 'ubuntu'
  default['java']['libraries_home'] = '/usr/share/java'
else
default['java']['libraries_home'] = '/usr/local/java_libs'
end
default['java']['additional_libraries'] = ['http://search.maven.org/remotecontent?filepath=org/testng/testng/6.14.3/testng-6.14.3.jar',
	'http://search.maven.org/remotecontent?filepath=com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar',
	'http://search.maven.org/remotecontent?filepath=org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar',
	'https://search.maven.org/remotecontent?filepath=com/google/code/gson/gson/2.8.5/gson-2.8.5.jar',
	'https://search.maven.org/maven2/org/apache/httpcomponents/core5/httpcore5/5.0-beta8/httpcore5-5.0-beta8.jar',
	'https://search.maven.org/remotecontent?filepath=org/apache/httpcomponents/httpasyncclient/4.1.4/httpasyncclient-4.1.4.jar',
	'https://search.maven.org/remotecontent?filepath=org/apache/httpcomponents/client5/httpclient5/5.0-beta5/httpclient5-5.0-beta5.jar',
	'http://central.maven.org/maven2/xml-resolver/xml-resolver/1.2/xml-resolver-1.2.jar',
	'http://central.maven.org/maven2/com/thaiopensource/jing/20091111/jing-20091111.jar',
	'https://search.maven.org/remotecontent?filepath=junit/junit/4.13-beta-1/junit-4.13-beta-1.jar',
	'https://search.maven.org/remotecontent?filepath=org/hamcrest/hamcrest/2.1-rc3/hamcrest-2.1-rc3.jar']

default['java']['additional_ml_libraries'] = ["https://s3.amazonaws.com/codechecker-install-essentials/stanford-corenlp-full-2013-06-20.zip",
	"https://s3.amazonaws.com/codechecker-install-essentials/stanford-classifier-2013-06-20.zip",
	"http://downloads.sourceforge.net/project/java-ml/java-ml/javaml-0.1.7.zip",
	"http://prdownloads.sourceforge.net/weka/weka-3-6-10.zip",
	"http://downloads.sourceforge.net/project/weka/weka-packages/LibSVM1.0.5.zip",
	"https://excellmedia.dl.sourceforge.net/project/ajt/ajt-2.11.zip",
	"http://math.nist.gov/javanumerics/jama/Jama-1.0.3.jar"]

# Go Lang
default['go']['version'] = '1.13'
default['go']['install_dir'] = '/usr/local'
default['go']['gopath'] = '/user/local/go'
default['go']['gobin'] = '/user/local/go/bin'
default['go']['packages'] = ['encoding/json', 'encoding/csv', 'encoding/xml', 'strings', 'math', 'container/heap', 'container/list' , 'net/http']

# NodeJS
default['nodejs']['install_method'] = 'binary'
default['nodejs']['version'] = '10.16.3'
default['nodejs']['binary']['checksum'] = 'd2271fd8cf997fa7447d638dfa92749ff18ca4b0d796bf89f2a82bf7800d5506'
default['nodejs']['npm_packages'] = ['coffee-script', 'typescript', 'underscore', 'lodash', 'jquery', 'bignumber.js', 'babel-cli', 'babel-preset-latest','request','axios'].map {|item| {'name' => item}}

# Scala
default["scala"]["version"] = "2.13.0"
default["scala"]["url"] = "http://www.scala-lang.org/files/archive/scala-#{default[:scala][:version]}.tgz"
default["scala"]["checksum"] = "8beb410ad9bfc3087589d13f07f062fba0091cf1c4e8534c334e28d1213ed675"
default['scala']['home'] = '/usr/local/scala'
default['scala']['additional_libraries'] = %w(https://search.maven.org/remotecontent?filepath=org/scalaz/scalaz-core_2.12/7.3.0-M27/scalaz-core_2.12-7.3.0-M27.jar
	https://search.maven.org/remotecontent?filepath=org/typelevel/cats-macros_2.12/2.0.0/cats-macros_2.12-2.0.0.jar
	https://search.maven.org/remotecontent?filepath=org/typelevel/cats-kernel_2.12/2.0.0/cats-kernel_2.12-2.0.0.jar
	https://search.maven.org/remotecontent?filepath=org/typelevel/cats-core_2.12/2.0.0/cats-core_2.12-2.0.0.jar
	https://search.maven.org/remotecontent?filepath=org/typelevel/cats-free_2.12/2.0.0/cats-free_2.12-2.0.0.jar)

default['scala']['twitter_libraries'] = %w(http://central.maven.org/maven2/com/twitter/algebird-core_2.12/0.13.5/algebird-core_2.12-0.13.5.jar
	http://central.maven.org/maven2/com/twitter/algebird-util_2.12/0.13.5/algebird-util_2.12-0.13.5.jar
	http://central.maven.org/maven2/com/twitter/algebird-bijection_2.12/0.13.5/algebird-bijection_2.12-0.13.5.jar
	http://central.maven.org/maven2/com/twitter/algebird-test_2.12/0.13.5/algebird-test_2.12-0.13.5.jar
	http://central.maven.org/maven2/com/twitter/algebird_2.11/0.12.2/algebird_2.11-0.12.2.jar)

# .Net
default['dotnetcore']['package']['name'] = 'dotnet-sdk-2.2.1'

# Mono Csharp
default['mono']['additional_libraries'] = %w(libmono-system-numerics4.0-cil libmono-system-design4.0-cil
	libmono-system-data-datasetextensions4.0-cil libmono-sqlite4.0-cil
	libnewtonsoft-json-cil-dev libmono-system-net-http4.0-cil
	libmono-system-net-http-formatting4.0-cil libmono-system-net-http-webrequest4.0-cil libmono-system-net4.0-cil)

# PHP
default['php']['additional_libraries'] = %w(php7.3-cli php7.3-json php7.3-gmp php7.3-common php7.3-mbstring php7.3-bcmath php7.3-ctype php7.3-xml php-http-request2 php-guzzlehttp-promises)
default['php']['additional_composer_libraries'] = ['phpunit/phpunit', 'guzzlehttp/guzzle', 'guzzlehttp/psr7', 'rmccue/requests', 'php-http/httplug']
# R
default['r']['additional_libraries'] = %w(foreach base64enc bayesm Formula class g.data cluster
	numDeriv scales codetools permute date spatial psy digest pwt statmod stringr
	iterators lattice latticeExtra timeDate evaluate tseries fastcluster fBasics
	XML Matrix rjson zoo car plyr sqldf dplyr lubridate randomForest survival data.table
	parallel xts neuralnet e1071 caret deepnet tm bit64 glmnet forecast reshape2 xgboost readr)

# Perl
default['perl']['ml_home'] = '/var/ml/perl'
default['perl']['additional_libraries'] = ['JSON::XS', 'XML::Parser', 'Set::Scalar', 'Math::SparseVector', 'Math::SparseMatrix']
default['perl']['additional_ml_libraries'] = ['Text::NSP', 'PDL']
# Perl 6
default['perl6']['additional_libraries'] = ['JSON::Class', 'Math::Constants', 'Stats', 'XML::Class', 'Math::Matrix', 'Math::Vector']

# Nim
default['nim']['version'] = '0.20.2'
default['nim']['home'] = '/usr/local/nim'

# MIT Scheme
default['mitscheme']['version'] = '10.1.10'
default['mitscheme']['home'] = '/tmp/mitscheme'

# Ruby
default['ruby']['version'] = '2.6.4'
default['ruby']['home'] = '/usr/local/ruby'
default['ruby']['additional_libraries'] = ['json', 'xml-simple', 'http', 'faraday', 'rest-client', 'httpclient', 'httparty']
# Rust
default['rust']['additional_libraries'] = %w(num serde serde_json serde_derive rustc-serialize regex time text_io rand).join(" = \"*\"\n") + (' = "*"')

# Racket
default['racket']['version'] = '7.4'
default['racket']['home'] = '/usr/local/racket'
default['racket']['url'] = "https://download.racket-lang.org/releases/#{default[:racket][:version]}/installers/racket-#{default[:racket][:version]}-x86_64-linux.sh"

# Python 2 & 3
override['poise-python']['options']['pip_version'] = '19.2.3'
default['poise-python']['install_python2'] = true
default['poise-python']['install_python3'] = true
default['poise-python']['install_pypy'] = false

default['python']['ml_home'] = '/var/ml/python'
default['python3']['ml_home'] = '/var/ml/python3'
default['python']['additional_libraries'] = %w(requests[security] beautifulsoup4 pycrypto cryptography urllib3)
default['python']['additional_ml_libraries'] = %w(numpy scipy sympy scikit-learn nltk pandas statsmodels)

# Pypy 2
default['pypy']['version'] = 'pypy2-v7.1.1'
default['pypy']['home'] = '/usr/local/pypy'
default['pypy']['ml_home'] = '/var/ml/pypy'
# Pypy 3
default['pypy3']['version'] = 'pypy3-v7.0.0'
default['pypy3']['home'] = '/usr/local/pypy3'
#default['pypy3']['url'] = "https://bitbucket.org/squeaky/portable-pypy/downloads/#{node[:pypy3][:version]}-linux_x86_64-portable.tar.bz2"
default['pypy3']['ml_home'] = '/var/ml/pypy3'
# Pypy packages
default['pypy']['additional_libraries'] = ['requests[security]', 'beautifulsoup4', 'virtualenv']
default['pypy']['additional_ml_libraries'] = ['numpy', 'sympy', 'nltk']

# SBCL
default['sbcl']['version'] = '1.4.2'

# Lolcode
default['lolcode']['home'] = '/usr/local/lolcode'

# Kotlin
default['kotlin']['version'] = '1.3.50'

# Julia
default['julia']['home'] = '/usr/local/julia'
default['julia']['version'] = '1.2.0'
default['julia']['url'] = "https://julialang-s3.julialang.org/bin/linux/x64/#{default[:julia][:version].match('\d+.\d+')[0]}/julia-#{default[:julia][:version]}-linux-x86_64.tar.gz"

# Groovy
default['groovy']['version'] = "2.5.8"
default['groovy']['url'] = "https://dl.bintray.com/groovy/maven/apache-groovy-sdk-#{default[:groovy][:version]}.zip"
default['groovy']['checksum'] = "37e030bbb14746869e822702db1c6dd57d7d077ceef4c12938b1c6c4d341f459"

# Haxe
default['haxe']['lib_home'] = '/usr/local/haxelibs'

# Haskell
default['haskell']['home'] = '/usr/local/haskell'
default['haskell']['additional_libraries'] = %w(base-prelude logict pipes hashtables
	random text vector aeson lens lens-aeson split
	bytestring array arrow-list
	regex-applicative regex-base regex-compat regex-pcre-builtin
	regex-posix regex-tdfa
	parsec unordered-containers attoparsec
	comonad deepseq dlist either matrix
	MemoTrie threads monad-memo memoize
	base-unicode-symbols basic-prelude bifunctors).join(" ")

# Ocaml
default['ocaml']['version'] = '4.08.0'
default['ocaml']['home'] = '/usr/local/lib/ocaml'
default['ocaml']['additional_libraries'] = %w(core async core_extended ocamlfind).join(" ")

# Clojure
default['clojure']['additional_libraries'] = [
	{name: 'algo.generic', version: '0.1.3'},
    {name: 'algo.monads', version: '0.1.6'},
    {name: 'core.logic', version: '0.8.11'},
    {name: 'data.avl', version: '0.1.0'},
    {name: 'data.int-map', version: '0.2.4'},
    {name: 'data.json', version: '0.2.6'},
    {name: 'data.priority-map', version: '0.0.10'},
    {name: 'data.xml', version: '0.0.8'},
    {name: 'spec.alpha', version: '0.2.176'}]
