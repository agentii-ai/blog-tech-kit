Below are three complete visual design standards for **agentii-kit**, aligned with your three themes and your target users. Think of each theme as a “skin” on the same product: a GitHub-like gallery of kit cards for different jobs.

***

##  “GitHub Geek with a Twist”

### 1.1 Brand Narrative

- **Concept:** “Feels like GitHub, behaves like GitHub, but clearly not *only* for coders.”
- **Personality:** Trustworthy, technical, calm—but with a small playful spark that signals “marketing and PMs welcome.”
- **Steve Jobs link:** Clarity and function first; no visual noise. A single, disciplined accent color carries the personality.

### 1.2 Color System

**Base mode: Dark first, Light as secondary option.**

- **Backgrounds**
  - Main app background: `#0D1117` (deep graphite, GitHub-like)
  - Sub-panels / surfaces: `#161B22`, `#1F2933`
- **Text**
  - Primary: `#E5E7EB` (light gray)
  - Secondary: `#9CA3AF`
  - Muted / meta: `#6B7280`
- **Accent (to attract non-devs)**
  - Primary accent: choose one:
    - Electric teal: `#36D399`
    - or Soft coral: `#F97373`
  - Use accent for:
    - Primary buttons, active nav item, links on hover, tag pills.
- **Status colors (subtle, developer-friendly)**
  - Success: `#22C55E`
  - Warning: `#F59E0B`
  - Error: `#EF4444`
- **Usage rules**
  - Limit accents: max 10–15% of any screen.
  - Never mix more than one accent family per page (no “rainbow UI”).

### 1.3 Typography

- **Primary font:** `Inter` or `SF Pro Text` (if system Apple fonts allowed).
- **Secondary monospace font:** `JetBrains Mono` or `IBM Plex Mono` for code-like labels or kit identifiers.
- **Hierarchy**
  - H1 (page titles): 28–32px, semi-bold.
  - H2 (section titles): 22–24px, semi-bold.
  - Body: 14–16px, regular.
  - Overline / meta (e.g., “MARKETING-KIT”): 11–12px uppercase, letter-spacing +0.08em.

Tone: neutral, slightly nerdy; avoid overly playful typefaces.

### 1.4 Layout & Grid

- **Grid:** 12-column, 80–1200px content width.
- **Navigation:**
  - Top nav bar, full-width, dark background.
  - Left-aligned: jobs-kit logotype.
  - Right-aligned: links (“Kits”, “Categories”, “Docs”, “GitHub”), “Sign in with GitHub” button.
- **Main content:**
  - Hero: simple headline, one-line subcopy, one prominent CTA (“Browse kits”), small “View on GitHub” secondary CTA.
  - Below: responsive grid of **kit cards** (3–4 per row desktop, 2 tablet, 1 mobile).

### 1.5 Kit Card Design (Core of the Product)

- **Card container**
  - Background: `#161B22`
  - Border: `1px` solid `#1F2933` (on hover: accent-colored shadow or border).
  - Radius: 8px.
  - Padding: 16–20px.
- **Content structure**
  - Top: Badge for category (`DEV-KIT`, `PM-KIT`, `LEGAL-KIT`) in accent-colored pill.
  - Title: 16–18px, semi-bold.
  - Subtitle: 13–14px, muted gray, 1–2 lines explaining “What job this kit helps with.”
  - Meta row: icons/text for:
    - “On GitHub” icon + org/repo name
    - Stars / likes
    - Last updated.
- **Hover state**
  - Slight scale (1.02x), subtle glow of accent color on border or shadow.
  - Show quick-actions: “View spec”, “Open on GitHub”.

### 1.6 Iconography & Illustration

- **Icons**
  - Simple line icons with 1.5–2px stroke.
  - Prefer icon sets similar to Feather or Heroicons.
  - Use accent color sparingly (only active/primary actions).
- **Illustration**
  - Minimal, diagram-like: folder trees, nodes/edges, flow diagrams.
  - Avoid cute characters; keep it serious enough for lawyers and PMs, but not sterile.

### 1.7 Motion & Microinteractions

- Durations: 150–250ms, ease-in-out.
- Hover effects on:
  - Kit cards, nav items, buttons.
- Subtle loading indicators when fetching kit details (a thin accent-color progress bar at the top, GitHub-style).

### 1.8 Accessibility & Responsiveness

- Text contrast: meet WCAG AA on dark background.
- Focus states: visible outlines around cards and buttons (accent-colored outline).
- Keyboard navigation: tab through cards and actions; Enter to open kit.

***
