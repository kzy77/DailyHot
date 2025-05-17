#!/bin/sh

# Path to the template and output config file
TEMPLATE_FILE="/usr/share/nginx/html/config.template.js"
CONFIG_FILE="/usr/share/nginx/html/config.js"

# Create a copy of the template to work with
cp ${TEMPLATE_FILE} ${CONFIG_FILE}

# Replace placeholders with environment variable values
# If an environment variable is not set, use an empty string or a default value if appropriate

# VITE_GLOBAL_API
if [ -n "${VITE_GLOBAL_API}" ]; then
  sed -i "s#\\${VITE_GLOBAL_API}#${VITE_GLOBAL_API}#g" ${CONFIG_FILE}
else
  # Fallback to a default or leave as is if the template handles it
  sed -i "s#\\${VITE_GLOBAL_API}#https://api-hot.efefee.cn#g" ${CONFIG_FILE} # Default example
fi

# VITE_ICP
if [ -n "${VITE_ICP}" ]; then
  sed -i "s#\\${VITE_ICP}#${VITE_ICP}#g" ${CONFIG_FILE}
else
  sed -i "s#\\${VITE_ICP}##g" ${CONFIG_FILE} # Default to empty if not set
fi

# VITE_DIR
if [ -n "${VITE_DIR}" ]; then
  sed -i "s#\\${VITE_DIR}#${VITE_DIR}#g" ${CONFIG_FILE}
else
  sed -i "s#\\${VITE_DIR}#/#g" ${CONFIG_FILE} # Default to '/' if not set
fi

# Make sure the original template is not served by Nginx
# We can remove it after generating the config.js or ensure Nginx doesn't serve .template.js files
rm ${TEMPLATE_FILE}

# Execute the CMD from the Dockerfile (e.g., nginx -g 'daemon off;')
exec "$@"