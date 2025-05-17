#!/bin/sh

# Path to the template and output config file
TEMPLATE_FILE="/usr/share/nginx/html/config.template.js"
CONFIG_FILE="/usr/share/nginx/html/config.js"

# Create a copy of the template to work with
cp ${TEMPLATE_FILE} ${CONFIG_FILE}

# Replace placeholders with environment variable values
# If an environment variable is not set, use an empty string or a default value if appropriate

# VITE_GLOBAL_API
PLACEHOLDER_VITE_GLOBAL_API="\${VITE_GLOBAL_API}"
DEFAULT_VITE_GLOBAL_API="https://scrawny-flss-chunkj-4938f5f4.koyeb.app"

if [ -n "${VITE_GLOBAL_API}" ] && [ "${VITE_GLOBAL_API}" != "\${VITE_GLOBAL_API}" ]; then
  sed -i "s#${PLACEHOLDER_VITE_GLOBAL_API}#${VITE_GLOBAL_API}#g" ${CONFIG_FILE}
else
  sed -i "s#${PLACEHOLDER_VITE_GLOBAL_API}#${DEFAULT_VITE_GLOBAL_API}#g" ${CONFIG_FILE}
fi

# VITE_ICP
PLACEHOLDER_VITE_ICP="\${VITE_ICP}"
DEFAULT_VITE_ICP="豫ICP备2022018134号-1"

if [ -n "${VITE_ICP}" ] && [ "${VITE_ICP}" != "\${VITE_ICP}" ]; then
  sed -i "s#${PLACEHOLDER_VITE_ICP}#${VITE_ICP}#g" ${CONFIG_FILE}
else
  sed -i "s#${PLACEHOLDER_VITE_ICP}#${DEFAULT_VITE_ICP}#g" ${CONFIG_FILE}
fi

# VITE_DIR
PLACEHOLDER_VITE_DIR="\${VITE_DIR}"
DEFAULT_VITE_DIR="/"

if [ -n "${VITE_DIR}" ] && [ "${VITE_DIR}" != "\${VITE_DIR}" ]; then
  sed -i "s#${PLACEHOLDER_VITE_DIR}#${VITE_DIR}#g" ${CONFIG_FILE}
else
  sed -i "s#${PLACEHOLDER_VITE_DIR}#${DEFAULT_VITE_DIR}#g" ${CONFIG_FILE}
fi

# Make sure the original template is not served by Nginx
# We can remove it after generating the config.js or ensure Nginx doesn't serve .template.js files
rm ${TEMPLATE_FILE}

# Execute the CMD from the Dockerfile (e.g., nginx -g 'daemon off;')
exec "$@"