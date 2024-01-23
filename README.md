# graz-archaeology-metadata

This repo hold a stylesheet for transforming metadata for the Graz-Archaeology-Project from an export out of mbox to LIDO.

The style sheet is designed in a pull-fashion. While not very idiomatic for XSLT, it seems an easier choice as to achieve the right order of elements in the LIDO record, while the order of fields in the source has no relevance. The raw data is very flat and all records have the same fields. Thus the danger of missing elements of the source seems negligible.

## Running the transformation
Just as a reminder for me, as I tend do forget the most trivial invocations: `saxon-xslt -s:data/Bueste2.xml xslt/mbox2lido.xsl`.

**TODO:** Just write a shell script, will ya?
