FROM node:20-alpine

# Set working directory
WORKDIR /server

# Copy package files
COPY package.json package-lock.json ./

# Install all dependencies
RUN npm install --legacy-peer-deps

# Copy source code
COPY . .

# Build Medusa to .medusa/server
RUN npm run build

# Move into the compiled directory
WORKDIR /server/.medusa/server

# Install production dependencies INSIDE the build folder
RUN npm install --legacy-peer-deps

#creating admin
#RUN npx medusa user -e ali@clinic.com -p StrongPass123! || true

EXPOSE 9000
CMD ["sh", "-c", "npx medusa db:migrate && (npx medusa user -e ali@clinic.com -p StrongPass123! || true) && npx medusa start"]
