#!/bin/bash

if [ ! -d "pdfs" ]; then
  echo "The 'pdfs' directory does not exist."
  exit 1
fi

# "xmls_sciencebeam" directory
if [ ! -d "xmls_sciencebeam" ]; then
  mkdir "xmls_sciencebeam"
fi

# Iterate through PDF files in "pdfs"
for pdf_file in pdfs/*.pdf; do
  # Extract the filename
  base_name=$(basename "$pdf_file" .pdf)

  # curl command to convert
  curl --fail --show-error \
    --output "xmls_sciencebeam/${base_name}.xml" \
    --form "file=@${pdf_file};filename=${base_name}.pdf" \
    --silent "http://localhost:8070/api/processFulltextDocument"

  # Check for errors and echo results
  if [ $? -ne 0 ]; then
    echo "Failed to process ${pdf_file}"
  else
    echo "Processed ${pdf_file} and saved as xmls_sciencebeam/${base_name}.xml"
  fi
done
