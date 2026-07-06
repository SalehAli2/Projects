# Do Deal — Interview Cheat Sheet

## Company Facts
- Founded 2024, 11-50 employees. Offices: Cairo (New Cairo, 5th Settlement), Dubai (UAE), Islamabad (Pakistan, IT team).
- Marketing Services industry. Serves Egypt + UAE clients.
- Core pitch: transparency, collaboration, tailored strategy, "measurable success."

## Service Stack
- **Digital Marketing:** SEM (Google/YouTube Ads), social media campaigns, paid media, content/copywriting/SEO, marketing automation (email, CRM, lead nurturing), performance analytics dashboards.
- **Development:** web dev, custom platforms, admin panels/dashboards, CRM & automation, mobile apps.

## Client Base — REAL ESTATE HEAVY
Hikal Real Estate, Lychee Gardens, Apraj, Redestate, Apoelezz Properties, Archer Corporation (construction), ASM Real Estate, Prime Season Real Estate, **AP Properties (Dubai)**.

### AP Properties Case Study (Dubai) — most detailed public case study
- Problem: competing with Emaar/Damac, weak positioning, low brand recognition.
- What Do Deal did: brand positioning map, competitor benchmarking, brand archetype work (Caregiver + Explorer), naming/logo/identity, **brand lift studies on Meta & YouTube**, campaign activation.
- Key insight: they sell **strategy + brand measurement**, not just execution.

## Testimonial Themes (what clients value)
- Integrating branding + website + CRM + automation + content into one system
- Reducing manual work via automation
- Making campaign performance "make sense" (clearer reporting/attribution)

## AI Project Ideas Mapped to Their Business

| Their Need | AI Angle | Your Matching Project |
|---|---|---|
| Real estate lead qualification / client chatbots | RAG + tool-calling agent for FAQs, viewings, availability | NovaBite (multi-agent RAG) |
| Automation reducing manual work (CRM) | Auto-qualify/score leads from ad campaigns before human handoff | Churn prediction (RF/LightGBM) |
| Ad copy / content at scale, bilingual (AR/EN) | Multi-agent content generation pipeline | StoryTeller (LangGraph agents) |
| Brand lift / competitor positioning (AP Properties) | Scrape competitor ads/content, embed + cluster to map positioning gaps | Embeddings/FAISS experience |
| Campaign performance dashboards | Anomaly detection on KPIs, plain-language summaries | Data science + Power BI background |
| Product/property visuals, brand consistency | CLIP-based QA to check creative matches brand guidelines | CV background (CLIP, YOLO) |
| Arabic-market sentiment / social listening | AraBERT/CAMeLBERT sentiment classification, or LLM-prompted sentiment as MVP | Gap area — be honest but show awareness |

## Sharp Questions to Ask Them
1. "Most of your case studies are real estate — is AI expected to support that vertical specifically (lead qualification, property matching), or more general internal tooling?"
2. "Is there a current pain point — content generation, reporting, or client-facing chat — that's the immediate priority?"
3. "How does the Pakistan IT team collaborate with the Cairo/Dubai side — is this role more independent or tightly integrated with their pipeline?"

## Your 60-Second Bridge Line (memorize this)
"I noticed most of your clients are in real estate, and the AP Properties case study shows you're already doing deep competitive positioning and brand lift measurement. My NovaBite project — a multi-agent RAG system with an orchestrator, retrieval agent, and tool-calling agent — maps directly onto a real estate lead-qualification chatbot: answering property FAQs and handling viewing bookings. And on the analysis side, my data science background (churn prediction, Random Forest/LightGBM) is the same skill set needed to build predictive layers on top of your campaign reporting."
