# C & C++
default['cpp']['ml_home'] = '/var/ml/cpp'
default['cpp']['additional_ml_libraries'] = [{'name' => 'libsvm-3.22',
		'url' => 'http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/libsvm.cgi?+http://www.csie.ntu.edu.tw/~cjlin/libsvm+tar.gz'},
	{'name' => 'liblinear-2.11',
		'url' => 'http://www.csie.ntu.edu.tw/~cjlin/cgi-bin/liblinear.cgi?+http://www.csie.ntu.edu.tw/~cjlin/liblinear+tar.gz'}]

# Java
default['java']['install_flavor'] = 'oracle'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['java']['accept_license_agreement'] = true

# Java Version
default['java7']['url'] = 'http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz'
default['java8']['url'] = 'http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u144-linux-x64.tar.gz'
default['java7']['home'] = '/usr/lib/jvm/java-7-sun'
default['java8']['home'] = '/usr/lib/jvm/java-8-sun'
default['java']['ml_home'] = '/var/ml/java'
if node['platform'] == 'ubuntu'
  default['java']['libraries_home'] = '/usr/share/java'
else
default['java']['libraries_home'] = '/usr/local/java_libs'
end
default['java']['additional_libraries'] = ['http://search.maven.org/remotecontent?filepath=org/testng/testng/6.8.8/testng-6.8.8.jar',
	'http://search.maven.org/remotecontent?filepath=com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar',
	'http://search.maven.org/remotecontent?filepath=org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar',
	'https://search.maven.org/remotecontent?filepath=com/google/code/gson/gson/2.8.2/gson-2.8.2.jar']

default['java']['additional_ml_libraries'] = ["https://s3.amazonaws.com/codechecker-install-essentials/stanford-corenlp-full-2013-06-20.zip",
	"https://s3.amazonaws.com/codechecker-install-essentials/stanford-classifier-2013-06-20.zip",
	"http://downloads.sourceforge.net/project/java-ml/java-ml/javaml-0.1.7.zip",
	"http://prdownloads.sourceforge.net/weka/weka-3-6-10.zip",
	"http://downloads.sourceforge.net/project/weka/weka-packages/LibSVM1.0.5.zip",
	"http://downloads.sourceforge.net/project/ajt/ajt/ajt-2.9.zip",
	"http://math.nist.gov/javanumerics/jama/Jama-1.0.3.jar"]

# Go Lang
default['go']['version'] = '1.9.1'
default['go']['install_dir'] = '/usr/local'
default['go']['gopath'] = '/user/local/go'
default['go']['gobin'] = '/user/local/go/bin'
default['go']['packages'] = ['encoding/json', 'encoding/csv', 'encoding/xml', 'strings', 'math', 'container/heap', 'container/list']

# NodeJS
default['nodejs']['install_method'] = 'binary'
default['nodejs']['npm_packages'] = [{'name' => 'coffee-script'}, {'name' => 'typescript'},
	{'name' => 'underscore'}, {'name' => 'lodash'}, {'name' => 'jquery'}, {'name' => 'bignumber.js'}]

# Scala
default["scala"]["version"] = "2.12.4"
default["scala"]["url"] = "http://www.scala-lang.org/files/archive/scala-#{default[:scala][:version]}.tgz"
default["scala"]["checksum"] = "9554a0ca31aa8701863e881281b1772370a87e993ce785bb24505f2431292a21"
default['scala']['home'] = '/usr/local/scala'
default['scala']['additional_libraries'] = %w(https://search.maven.org/remotecontent?filepath=org/scalaz/scalaz-core_2.12/7.3.0-M13/scalaz-core_2.12-7.3.0-M13.jar
	https://search.maven.org/remotecontent?filepath=org/typelevel/cats-core_2.12/0.9.0/cats-core_2.12-0.9.0.jar)

default['scala']['twitter_libraries'] = %w(http://central.maven.org/maven2/com/twitter/algebird-core_2.10/0.6.0/algebird-core_2.10-0.6.0.jar
	http://central.maven.org/maven2/com/twitter/algebird-util_2.10/0.6.0/algebird-util_2.10-0.6.0.jar
	http://central.maven.org/maven2/com/twitter/algebird-bijection_2.10/0.6.0/algebird-bijection_2.10-0.6.0.jar
	http://central.maven.org/maven2/com/twitter/algebird-test_2.10/0.6.0/algebird-test_2.10-0.6.0.jar
	http://central.maven.org/maven2/com/twitter/algebird_2.10/0.6.0/algebird_2.10-0.6.0.jar)

# .Net
default['dotnetcore']['package']['name'] = 'dotnet-sdk-2.0.0'

# Mono Csharp
default['mono']['additional_libraries'] = %w(libmono-system-numerics4.0-cil libmono-system-design4.0-cil
	libmono-system-data-datasetextensions4.0-cil libmono-sqlite4.0-cil
	libnewtonsoft-json-cil-dev libmono-system-net-http4.0-cil
	libmono-system-net-http-formatting4.0-cil libmono-system-net-http-webrequest4.0-cil)

# PHP
default['php']['additional_libraries'] = %w(php7.0-cli php7.0-json php7.0-gmp php7.0-common php7.0-mbstring php7.0-bcmath php7.0-ctype php7.0-xml)

# R
default['r']['additional_libraries'] = %w(foreach base64enc bayesm Formula class g.data cluster
	numDeriv scales codetools permute date spatial psy digest pwt statmod stringr
	iterators lattice latticeExtra timeDate evaluate tseries fastcluster fBasics
	XML Matrix rjson zoo car plyr sqldf dplyr lubridate randomForest survival data.table
	parallel xts neuralnet e1071 caret deepnet darch tm bit64 glmnet forecast reshape2 xgboost readr)

# Perl
default['perl']['ml_home'] = '/var/ml/perl'
default['perl']['additional_libraries'] = ['Set::Scalar', 'Math::SparseVector', 'Math::SparseMatrix']
default['perl']['additional_ml_libraries'] = ['Text::NSP', 'PDL']
# Perl 6
default['perl6']['additional_libraries'] = ['JSON::Class', 'Math::Constants', 'Stats', 'XML::Class', 'Math::Matrix', 'Math::Vector']

# Nim
default['nim']['version'] = '0.17.2'
default['nim']['home'] = '/usr/local/nim'

# MIT Scheme
default['mitscheme']['version'] = '9.2'
default['mitscheme']['home'] = '/tmp/mitscheme'

# Ruby
default['ruby']['version'] = '2.4.2'
default['ruby']['home'] = '/usr/local/ruby'

# Rust
default['rust']['additional_libraries'] = %w(num serde serde_json serde_derive rustc-serialize regex time text_io).join(" = \"*\"\n") + (' = "*"')

# Racket
default['racket']['version'] = '6.8'
default['racket']['home'] = '/usr/local/racket'
default['racket']['url'] = "https://download.racket-lang.org/releases/#{default[:racket][:version]}/installers/racket-#{default[:racket][:version]}-x86_64-linux.sh"

# Python 2 & 3
default['poise-python']['install_python2'] = true
default['poise-python']['install_python3'] = true

default['python']['ml_home'] = '/var/ml/python'
default['python3']['ml_home'] = '/var/ml/python3'
default['python']['additional_libraries'] = %w(requests[security] beautifulsoup4)
default['python']['additional_ml_libraries'] = %w(numpy scipy sympy scikit-learn nltk pandas statsmodels)

# Pypy 2
default['pypy']['version'] = 'pypy2-v5.9.0'
default['pypy']['home'] = '/usr/local/pypy'
default['pypy']['ml_home'] = '/var/ml/pypy'
# Pypy 3
default['pypy3']['version'] = 'pypy3-v5.9.0'
default['pypy3']['home'] = '/usr/local/pypy3'
default['pypy3']['ml_home'] = '/var/ml/pypy3'
# Pypy packages
default['pypy']['additional_libraries'] = ['requests[security]', 'beautifulsoup4']
default['pypy']['additional_ml_libraries'] = ['numpy', 'sympy', 'nltk']

# SBCL
default['sbcl']['version'] = '1.4.0'

# Lolcode
default['lolcode']['home'] = '/usr/local/lolcode'

# Kotlin
default['kotlin']['version'] = '1.1.51'

# Julia
default['julia']['home'] = '/usr/local/julia'
default['julia']['version'] = '0.6.0'
default['julia']['url'] = "https://julialang-s3.julialang.org/bin/linux/x64/#{default[:julia][:version].match('\d+.\d+')[0]}/julia-#{default[:julia][:version]}-linux-x86_64.tar.gz"

# Groovy
default['groovy']['version'] = "2.4.12"
default['groovy']['url'] = "https://dl.bintray.com/groovy/maven/apache-groovy-sdk-#{default[:groovy][:version]}.zip"
default['groovy']['checksum'] = "2dea0d021d74184ca2659f964d88b7e7c849e9e694b74289da682834f425bbb0"

# Haxe
default['haxe']['lib_home'] = '/usr/local/haxelibs'

# Haskell
default['haskell']['home'] = '/usr/local/haskell'
default['haskell']['additional_libraries'] = %w(base-prelude logict pipes hashtables
	random text vector aeson lens lens-aeson split
	bytestring array arrow-list
	regex-applicative regex-base regex-compat regex-pcre-builtin
	regex-posix regex-tdfa
	generic-aeson parsec unordered-containers attoparsec
	comonad deepseq dlist either matrix
	MemoTrie threads monad-memo memoize
	base-unicode-symbols basic-prelude bifunctors).join(" ")

# Ocaml
default['ocaml']['version'] = '4.05.0'
default['ocaml']['home'] = '/usr/local/lib/ocaml'
default['ocaml']['additional_libraries'] = %w(core async core_extended ocamlfind).join(" ")

# Clojure
default['clojure']['additional_libraries'] = ['https://search.maven.org/remotecontent?filepath=org/clojure/clojure/1.8.0/clojure-1.8.0.jar',
	'https://repo1.maven.org/maven2/org/clojure/data.int-map/0.2.1/data.int-map-0.2.1.jar',
	'http://search.maven.org/remotecontent?filepath=org/clojure/data.priority-map/0.0.7/data.priority-map-0.0.7.jar',
	'http://search.maven.org/remotecontent?filepath=org/clojure/core.logic/0.8.10/core.logic-0.8.10.jar',
	'http://search.maven.org/remotecontent?filepath=org/clojure/data.json/0.2.6/data.json-0.2.6.jar']
