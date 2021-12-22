# Edition der Familienkorrespondenz Ferdinands I.


## dev set up

* run `./script.sh` to download and install needed libraries

## data preparation

* download XML/TEI files with `$ ./dl_data.sh`
* create `./data/register/listperson.xml|listplace.xml` with `$ python make_register.py`

## build static-sites

* run `$ ant` to apply xslt-transformations on XML/TEI data


## build search index

* run 

build with [DSE-Static-Cookiecutter](https://github.com/acdh-oeaw/dse-static-cookiecutter)
