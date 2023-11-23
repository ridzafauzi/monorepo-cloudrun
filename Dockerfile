FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS build
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run -r build
RUN pnpm deploy --filter=admin --prod /prod/admin
RUN pnpm deploy --filter=client --prod /prod/client
RUN cp -r admin/dist /prod/admin
RUN cp -r client/dist /prod/client

#FROM base AS admin
#COPY --from=build /prod/admin /prod/admin
#WORKDIR /prod/admin
#EXPOSE 8000
#CMD [ "pnpm", "preview" ]

FROM nginx:stable-alpine AS admin
COPY --from=build /prod/admin/dist /usr/share/nginx/html
COPY nginx-admin.conf /etc/nginx/conf.d/default.conf
EXPOSE 8000
CMD ["nginx", "-g", "daemon off;"]

FROM nginx:stable-alpine AS client
COPY --from=build /prod/client/dist /usr/share/nginx/html
COPY nginx-client.conf /etc/nginx/conf.d/default.conf
EXPOSE 8001
CMD ["nginx", "-g", "daemon off;"]
