# Use a Node.js base image
FROM node:18 as build

# Set working directory
WORKDIR /app

# Copy frontend files and install dependencies
COPY frontend/package.json frontend/package-lock.json ./frontend/
RUN cd frontend && npm install

# Build the frontend
COPY frontend ./frontend
RUN cd frontend && npm run build

# Copy backend files and install dependencies
COPY backend/package.json backend/package-lock.json ./backend/
RUN cd backend && npm install

# Copy frontend build to backend public directory
RUN cp -r frontend/build/* backend/public/

# Set working directory to backend
WORKDIR /app/backend

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
