#!/usr/bin/env bash
set -e

echo "======================================================"
echo "  🚄  AI Railway Operations Copilot — Startup"
echo "======================================================"

# Generate dataset if not present
if [ ! -f "data/railway_operations.csv" ]; then
  echo "📊 Generating synthetic railway dataset..."
  python3 data/generate_dataset.py
  echo "✅ Dataset generated"
else
  echo "✅ Dataset already present"
fi

echo ""
echo "🐳 Starting Docker stack..."
docker compose up --build -d

echo ""
echo "⏳ Waiting for backend to be ready..."
until curl -sf http://localhost:8000/api/health > /dev/null 2>&1; do
  printf "."
  sleep 3
done

echo ""
echo ""
echo "======================================================"
echo "  ✅ Railway Copilot is running!"
echo "======================================================"
echo "  Frontend :  http://localhost:3000"
echo "  API Docs :  http://localhost:8000/api/docs"
echo "  Health   :  http://localhost:8000/api/health"
echo ""
echo "  👤 admin    / admin123    (Admin)"
echo "  👤 operator / operator123 (Operator)"
echo "======================================================"
