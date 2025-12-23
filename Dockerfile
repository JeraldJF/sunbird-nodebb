FROM node:lts
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV

COPY NodeBB/install/package.json /usr/src/app/package.json
COPY NodeBB/ /usr/src/app
RUN npm install --only=prod && \
    npm cache clean --force


# Install Sunbird custom plugins from JeraldJF GitHub repositories
# Using same branch/tag names as original, just different owner
RUN npm install https://github.com/JeraldJF/nodebb-plugin-sunbird-oidc.git#master
RUN npm install https://github.com/JeraldJF/nodebb-plugin-sunbird-api.git#release-4.6.0
RUN npm install https://github.com/JeraldJF/nodebb-plugin-sunbird-telemetry.git#master
RUN npm install https://github.com/JeraldJF/nodebb-plugin-azure-storage.git#main

# Keep these plugins from upstream (already compatible or deprecated)
RUN npm install https://github.com/NodeBB/nodebb-plugin-write-api.git#master

# Nodebb was not taking the latest version of mentions plugin, That's why we added install command here.
RUN npm install https://github.com/julianlam/nodebb-plugin-mentions.git#master

ENV NODE_ENV=production \
    daemon=false \
    silent=false

EXPOSE 4567

### Below env vars to be set prior running the container
## Note:
## password won't get overwritten if you run
## 'node app --setup' multiple times
## Default username is admin
########################################################
# ENV database=mongo
# ENV secret="1d57ba64-86d4-43ff-bd10-f6e9e0782899"
# ENV url="http://0.0.0.0:4567"
# ENV mongo__host="http://127.0.0.1"
# ENV mongo__database="nodebb"
# ENV admin__password="nodebbAdminPassword00"
########################################################

CMD ["sh", "-c", "node ./nodebb setup ; node ./nodebb start"]
