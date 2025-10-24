# Use official Python image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI app
COPY test.py .

# Expose the port FastAPI will run on
EXPOSE 8001

# Run the FastAPI app with uvicorn
CMD ["uvicorn", "test:app", "--host", "0.0.0.0", "--port", "8001"]