# 🚄 AI-Powered Railway Operations Copilot

> A production-ready, full-stack AI platform for intelligent railway operations — delay prediction, route optimisation, simulation, platform management, and real-time AI recommendations.

---

## ✨ Features

| Module | Description |
|---|---|
| **Delay Prediction** | XGBoost, LightGBM, Random Forest, Gradient Boosting — auto-trained, compared, SHAP explainability |
| **Route Planner** | Shortest path, K-shortest paths, congestion-aware routing via NetworkX |
| **Passenger Connections** | Multi-hop A→B→C recommendations when no direct train exists |
| **Network Map** | SVG topology with congestion heatmap and bottleneck detection |
| **Platform Manager** | Conflict detection, OR-Tools optimisation, crowd forecasting |
| **SimPy Simulator** | What-if scenarios: normal / high congestion / weather disruption / maintenance |
| **AI Copilot** | Auto-generated prioritised recommendations with expected delay savings |
| **Analytics** | Zone, train type, weather, hourly, monthly breakdowns |
| **Dataset Manager** | CSV/XLSX upload, auto schema detection, data profiling, quality scoring |
| **Auth & RBAC** | JWT, Admin + Operator roles |

---

## 🚀 Quick Start (One Command)

```bash
git clone <repo>
cd railway-copilot

# Copy dataset (already included as synthetic data)
# data/railway_operations.csv  ← 5,000 rows, 42 columns, auto-generated

# Start everything
docker compose up --build
```

| Service | URL |
|---|---|
| Frontend | http://localhost:3000 |
| Backend API | http://localhost:8000 |
| API Docs | http://localhost:8000/api/docs |

**Default credentials:**
- Admin: `admin` / `admin123`
- Operator: `operator` / `operator123`

---

## 🏗️ Architecture

```
railway-copilot/
├── backend/                  # Python FastAPI
│   ├── app/
│   │   ├── api/              # REST endpoints (auth, data, ml, network, simulation)
│   │   ├── core/             # Config, security (JWT, bcrypt)
│   │   ├── db/               # SQLAlchemy models + session
│   │   ├── ml/               # Delay predictor, network graph, simulator
│   │   └── services/         # Data service, copilot service
│   ├── tests/                # Pytest unit + integration tests
│   └── Dockerfile
├── frontend/                 # React 18 + TypeScript + TailwindCSS
│   ├── src/
│   │   ├── components/       # Layout, UI primitives, charts
│   │   ├── pages/            # All 11 dashboard pages
│   │   ├── stores/           # Zustand auth store
│   │   └── utils/            # Axios API client
│   └── Dockerfile
├── data/
│   └── railway_operations.csv  # 5,000-row synthetic Indian Railways dataset
├── docker-compose.yml          # Production stack
├── docker-compose.dev.yml      # Dev with hot reload
└── README.md
```

### Tech Stack

**Backend:** Python 3.11 · FastAPI · SQLAlchemy · PostgreSQL · Pandas · NumPy  
**ML:** XGBoost · LightGBM · CatBoost · Scikit-Learn · SHAP · Prophet  
**Graph/Optimisation:** NetworkX · Google OR-Tools · SimPy  
**Frontend:** React 18 · TypeScript · Vite · TailwindCSS · Recharts · Zustand · React Query  
**Infra:** Docker · Docker Compose · Nginx · PostgreSQL 16  

---

## 📊 Dataset

The platform ships with a **synthetic 5,000-row Indian Railways dataset** (`data/railway_operations.csv`) with 42 columns:

- Train identifiers, names, types, zones
- Origin/destination stations with lat/lng
- Scheduled & actual departure/arrival times
- Delay metrics (departure delay, arrival delay)
- Platform assignments and conflict flags
- Passenger counts, capacity, occupancy rates
- Weather conditions and weather-induced delays
- Track congestion levels
- Maintenance status, locomotive age
- Holiday flags, signal failures
- Revenue and ticket pricing

**Upload your own dataset** via the Dataset page — the system auto-detects schema fields and adapts all ML models and services accordingly.

---

## 🔌 API Reference

Full Swagger docs at `/api/docs`. Key endpoints:

### Auth
```
POST /api/v1/auth/register    — Register user
POST /api/v1/auth/login       — Login (JWT)
GET  /api/v1/auth/me          — Current user
GET  /api/v1/auth/users       — List users (admin only)
```

### Data
```
GET  /api/v1/data/dashboard   — KPI stats
GET  /api/v1/data/profile     — Dataset profiling
GET  /api/v1/data/trains      — Paginated train records
GET  /api/v1/data/stations    — Station list
POST /api/v1/data/upload      — Upload CSV/XLSX
```

### ML
```
POST /api/v1/ml/train/sync          — Train all models (sync)
POST /api/v1/ml/predict             — Predict delay for a train
GET  /api/v1/ml/model-info          — Model metadata
GET  /api/v1/ml/feature-importance  — Top features
GET  /api/v1/ml/metrics             — MAE/RMSE/R² per model
```

### Network
```
GET /api/v1/network/stats                        — Graph stats
GET /api/v1/network/route?origin=X&destination=Y — Shortest path
GET /api/v1/network/k-routes?origin=X&destination=Y&k=3
GET /api/v1/network/connections?origin=X&destination=Y
GET /api/v1/network/bottlenecks
```

### Simulation & Copilot
```
POST /api/v1/simulation/run      — Run SimPy simulation
POST /api/v1/simulation/compare  — Baseline vs Optimized
GET  /api/v1/copilot/recommendations
GET  /api/v1/copilot/platform-optimize/{station_code}
GET  /api/v1/copilot/crowd-forecast/{station_code}
```

---

## 🧪 Running Tests

```bash
cd backend
pip install -r requirements.txt
pytest tests/ -v
```

Tests cover:
- Data service (schema detection, profiling, paging, search)
- Delay predictor (train, predict, bulk predict, feature importance)
- Network graph (shortest path, K-paths, bottlenecks, connections)
- Copilot service (recommendations, platform optimise, crowd forecast)
- SimPy simulator (all scenarios, optimisation effectiveness)
- Security (password hashing, JWT token lifecycle)
- API smoke tests (health, auth, protected routes)

---

## 🔧 Development

```bash
# Backend only (with hot reload)
cd backend
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000

# Frontend only
cd frontend
npm install
npm run dev  # → http://localhost:3000
```

Or use the dev compose:
```bash
docker compose -f docker-compose.dev.yml up
```

---

## 🌐 Environment Variables

Copy `.env.example` to `.env` and adjust:

| Variable | Default | Description |
|---|---|---|
| `DATABASE_URL` | postgresql://... | PostgreSQL connection string |
| `SECRET_KEY` | change-me | JWT signing key (min 32 chars) |
| `DATASET_PATH` | /app/data/... | Path to CSV dataset |
| `MODELS_DIR` | /app/models | Where trained models are saved |
| `VITE_API_URL` | http://localhost:8000 | Backend URL for frontend |

---

## 📦 Production Deployment

```bash
# Build and start
docker compose up --build -d

# View logs
docker compose logs -f backend

# Rebuild after code change
docker compose up --build backend -d

# Stop
docker compose down
```

---

## 🔐 Default Roles

| Role | Capabilities |
|---|---|
| **Admin** | All features + user management |
| **Operator** | All operational features, no user management |

---

## 📈 ML Model Performance (on synthetic dataset)

Models are auto-selected based on lowest MAE:

| Model | Typical MAE | Notes |
|---|---|---|
| XGBoost | 8-12 min | Usually best performer |
| LightGBM | 9-13 min | Fast training |
| Random Forest | 10-15 min | Stable, interpretable |
| Gradient Boosting | 10-14 min | Good generalisation |

---

## 🗺️ Roadmap

- [ ] Real-time WebSocket updates
- [ ] Leaflet map integration with live train markers
- [ ] CatBoost integration
- [ ] Prophet-based time-series forecasting UI
- [ ] Email/SMS alerting for high-priority recommendations
- [ ] Multi-tenant support
- [ ] Kubernetes Helm chart

---

Built with ❤️ — AI Railway Operations Copilot v1.0
