# languages

languages chef cookbook is the infrastructure code to install all the languages, frameowrks and libraries that are supported in codechecker. Codechecker infrastructure runs on Ubuntu 16.04 (LTS) AMD64 virtualized c3.large EC2 instances.

[attributes](https://github.com/interviewstreet/languages/tree/master/attributes) folder consists of all the configuration information, language / frameowrk versions and installation URLs 
[recipes](https://github.com/interviewstreet/languages/tree/master/recipes) folder contains actual installation scripts

## Updating language version

**Eg: Java 8:** Updating the installation URL will ensure newer version is installed during next upgrade.
```ruby
default['java8']['url'] = 'http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-8u144-linux-x64.tar.gz'
```

## Adding a new standard library or ML library

**1. Eg: Java:** Adding a new maven jar URL will ensure the library is available for all Java submissions by default
```ruby
default['java']['additional_libraries'] = ['http://search.maven.org/remotecontent?filepath=org/testng/testng/6.8.8/testng-6.8.8.jar',
	'http://search.maven.org/remotecontent?filepath=com/googlecode/json-simple/json-simple/1.1.1/json-simple-1.1.1.jar',
	'http://search.maven.org/remotecontent?filepath=org/ccil/cowan/tagsoup/tagsoup/1.2.1/tagsoup-1.2.1.jar',
	'https://search.maven.org/remotecontent?filepath=com/google/code/gson/gson/2.8.2/gson-2.8.2.jar']
```
**2. Eg: Perl:** If libraries are installed from a package manager then just add the new library to the list and it will be installed during next upgrade.
```ruby
default['perl6']['additional_libraries'] = ['JSON::Class', 'Math::Constants', 'Stats', 'XML::Class', 'Math::Matrix', 'Math::Vector']
```

