#!/bin/bash

# Check if response.json exists
if [ ! -f "response.json" ]; then
  echo "Error: response.json file not found!"
  exit 1
fi

# Check if the API call was successful by looking for the "choices" field in the JSON
if ! jq -e '.choices' response.json > /dev/null; then
  echo "Error: API call failed or response is malformed!"
  exit 1
fi

# Extract the response content from the JSON
RESPONSE_CONTENT=$(jq -r '.choices[0].message.content' response.json)

# Check if the response content is empty or not
if [ -z "$RESPONSE_CONTENT" ]; then
  echo "Error: No content found in the response!"
  exit 1
fi

# Display the response content
echo "API Response Content:"
echo "$RESPONSE_CONTENT"

# Clean up (optional)
rm -f #Website URL goes here response.json

echo "Check completed successfully."
exit 0