#!/bin/bash

# Generate static files with buster
buster generate --domain=http://127.0.0.1:2368  

# Copy sitemap files
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://127.0.0.1:2368/sitemap.xsl
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://127.0.0.1:2368/sitemap.xml
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://localhost:2368/sitemap-pages.xml
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://localhost:2368/sitemap-posts.xml
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://localhost:2368/sitemap-authors.xml
wget --convert-links --page-requisites --no-parent --directory-prefix static --no-host-directories --restrict-file-name=unix http://localhost:2368/sitemap-tags.xml

find static -name *.html -type f -exec sed -i'' 's#http://localhost:2368#https://inevity.github.io#g' {} \;
# Replace urls that were missed by buster
find static/* -name robots.txt -type f -exec sed -i'' 's#http://localhost:2368#https://inevity.github.io#g' {} \;
find static/* -name *.xsl -type f -exec sed -i'' 's#http://localhost:2368#https://inevity.github.io#g' {} \;
find static/* -name *.xml -type f -exec sed -i'' 's#loc>http://localhost:2368#loc>https://inevity.github.io#g' {} \;
find static/* -name *.html -type f -exec sed -i'' 's#u=http://localhost:2368#u=https://inevity.github.io#g' {} \;  
find static/* -name *.html -type f -exec sed -i'' 's#url=http://localhost:2368#url=https://inevity.github.io#g' {} \;  
find static/* -name *.html -type f -exec sed -i'' 's#href="http://localhost:2368#href=https://inevity.github.io"#g' {} \;  
find static/* -name *.html -type f -exec sed -i'' 's#src="http://localhost:2368#src=https://inevity.github.io"#g' {} \;  
find static/* -name *.html -type f -exec sed -i'' 's#link>http://localhost:2368#link>https://inevity.github.io#g' {} \; 

# Add CNAME file for github pages
#buster add-domain joshgerdes.com

# Copy files that were missed by buster
cp humans.txt static/humans.txt
cp -R content/images static/content
grep -nri localhost static/
# another static file?
