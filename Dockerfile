FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy backend source code
COPY .

# Install backend dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 3: Serve frontend and backend using nginx and gunicorn
FROM nginx:latest AS production

# Copy built code from the backenstage
COPY /app

# Expose port 80 for nginx
EXPOSE 80

# Start gunicorn server for backend
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]

