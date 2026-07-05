FROM node:20-alpine

WORKDIR /app

# Copy package files first (for better caching)
COPY package*.json ./
COPY prisma ./prisma/

# Install dependencies
RUN npm install

# Generate Prisma client
RUN npx prisma generate

# Copy the rest of the app
COPY . .

# Build the app
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
