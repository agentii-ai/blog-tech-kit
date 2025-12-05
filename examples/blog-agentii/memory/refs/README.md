# Agentii AI - Financial Document Analysis Platform

**Project:** Agentii AI - Financial Document Analysis Platform  
**Purpose:** Multi-dimensional parallel agent orchestration and result management for Wall Street professionals  
**Last Updated:** October 27, 2025

**Website:** agentii.ai  
**Official Name:** Agentii AI  
**Also Use:** AGENTII AI, Agentii, agentii

---

## Quick Start

### Start the Frontend (Recommended)

From the repository root:

```bash
npm run dev
```

This will start the frontend application at `http://localhost:3000`

### Start the Backend (Separate Server)

In a separate terminal:

```bash
npm run backend:dev
```

This starts the backend API at `http://localhost:3000` (backend)

---

## Project Architecture

### Frontend (`frontend/`)
- **Technology:** Next.js 14 with App Router
- **Purpose:** Main application UI
- **Features:**
  - Landing page (marketing site)
  - Financial dashboard (project management)
  - Agent Matrix (agent orchestration)
  - Agent Chat (conversations with agents)

### Backend (`backend/`)
- **Technology:** Next.js 14 (SaaS Starter Kit)
- **Purpose:** Authentication, payments, API
- **Features:**
  - Supabase authentication
  - Stripe payments
  - Postgres database (via Drizzle ORM)

---

## Features

### 1. Landing Page
- Marketing site for Agentii AI
- Feature showcases
- Call-to-action buttons

### 2. Financial Dashboard
- Project overview statistics
- Recent activity feed
- Agent run metrics
- System health monitoring

### 3. Project Management
- Create and manage projects
- Track sessions and chats
- View agent run history

### 4. Agent Matrix (Coming Soon)
- Configure multiple agents
- Parallel agent execution
- Real-time status updates

### 5. Agent Chat (Coming Soon)
- Chat interface for agent runs
- Real-time streaming responses
- Agent reasoning display

---

## Development Setup

### Prerequisites
- Node.js 18+
- npm 9+
- PostgreSQL (for backend)
- Supabase account (for authentication)
- Stripe account (for payments)

### Install Dependencies

```bash
# Install frontend dependencies
cd frontend
npm install

# Install backend dependencies
cd ../backend
npm install
```

### Environment Variables

Create `.env.local` files in both `frontend/` and `backend/` directories:

**Backend `.env.local`:**
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
DATABASE_URL=your_postgres_url
STRIPE_SECRET_KEY=your_stripe_secret_key
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
```

**Frontend `.env.local`:**
```
NEXT_PUBLIC_API_URL=http://localhost:3001
```

---

## Directory Structure

```
agentii/
├── frontend/              # Next.js frontend application
│   ├── app/
│   │   ├── page.tsx      # Landing page
│   │   └── dashboard/     # Dashboard pages
│   ├── components/
│   │   ├── ui/            # shadcn/ui components
│   │   └── dashboard/     # Dashboard components
│   └── lib/               # Utilities
├── backend/               # Next.js backend (SaaS kit)
│   ├── app/               # Backend routes
│   ├── components/        # Backend components
│   └── utils/             # Backend utilities
├── agentii_alpha/        # Lovable.dev landing page (legacy)
├── shadcn-admin/         # Admin dashboard template (reference)
├── agent-ui/             # Agent chat UI (reference)
└── package.json          # Root workspace configuration
```

---

## Available Scripts

### Root Level
- `npm run dev` - Start frontend development server
- `npm run build` - Build frontend for production
- `npm run start` - Start frontend in production mode
- `npm run backend:dev` - Start backend development server
- `npm run backend:build` - Build backend for production

### Frontend (`frontend/`)
- `npm run dev` - Start Next.js dev server
- `npm run build` - Build for production
- `npm start` - Start production server
- `npm run lint` - Run ESLint

### Backend (`backend/`)
- `npm run dev` - Start Next.js backend
- `npm run build` - Build backend
- `npm run db:generate` - Generate database migrations
- `npm run db:migrate` - Run database migrations

---

## Technology Stack

### Frontend
- **Framework:** Next.js 14
- **UI Library:** shadcn/ui (Radix UI)
- **Styling:** Tailwind CSS
- **Charts:** Recharts
- **Icons:** Lucide React

### Backend
- **Framework:** Next.js 14
- **Database:** PostgreSQL (via Supabase)
- **ORM:** Drizzle ORM
- **Auth:** Supabase Auth
- **Payments:** Stripe
- **Backend Database:** Postgres (projects, sessions, chats)
- **Agent Database:** SQLite (agent runs, detailed outputs)

---

## Development Status

### ✅ Completed
- Auth bypass for development
- Financial dashboard UI
- Landing page structure
- Project scaffolding

### 🚧 In Progress
- Agent Matrix implementation
- Real-time agent updates
- Database integration
- API routes

### 📋 Planned
- Agent chat UI
- Full CRUD operations
- Real-time WebSocket integration
- Agent execution backend

---

## Integration Plan

See `INTEGRATION_PLAN.md` for detailed integration strategy.

---

## Database Architecture

### Postgres (Supabase)
- Users
- Projects
- Sessions
- Chats
- Agent runs (metadata)

### SQLite (FastAPI Backend)
- Agent run details
- Agent outputs
- Conversations

See `DATABASE_RECOMMENDATION.md` for detailed schema.

---

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

## License

MIT License

---

## Support

For questions or issues, please open an issue on GitHub.



### Technology Constraints

- Frontend: Next.js 14+ with TypeScript and shadcn/ui components
- Backend: FastAPI with AgentOS framework integration
- Databases: Supabase (PostgreSQL) for application data, SQLite for document storage
- Agent Framework: Agno framework with configurable LLM providers
- Testing: Jest/Vitest for frontend, pytest for backend


