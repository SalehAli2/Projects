# Agents + Deployment + Monitoring Cheat Sheet

## Part 1: AI Agents

**What is an agent?**
An LLM given the ability to (1) reason about a task, (2) call tools/APIs, and (3) use the results to decide its next step — in a loop, until the task is done. Not just a single prompt→response; it's a *loop with decisions*.

**Core components**
- **LLM (the brain)** — reasons and decides what to do next
- **Tools** — functions the agent can call (search, DB query, API, calculator)
- **Memory** — short-term (conversation context) vs long-term (vector store recall)
- **Orchestration/control flow** — how steps chain together

**Single-agent vs Multi-agent**
- Single agent: one LLM handles reasoning + tool use for the whole task. Simpler, fine for narrow tasks.
- Multi-agent: task split across specialized agents (e.g., one for retrieval, one for tool-calling, one orchestrator routing between them). Better for complex workflows — each agent has a focused prompt/context instead of one agent doing everything, which reduces errors and confusion.
- **Your example (NovaBite):** orchestrator + RAG agent + tool-calling operations agent — a clean case of task decomposition.

**LangChain vs LangGraph (know the distinction)**
- LangChain: building blocks for chains of LLM calls + tools (mostly linear/simple flows)
- LangGraph: models the agent workflow as a **graph with state** — supports loops, conditionals, branching between agents. Needed when workflow isn't strictly linear (e.g., "if retrieval confidence is low, retry with different query").

**RAG in one sentence**
"Instead of relying only on what the LLM learned in training, retrieve relevant documents at query time and feed them into the prompt, so answers are grounded in current, specific data."

**Common RAG design choices to be ready to justify**
- Hybrid retrieval (BM25 + dense/FAISS): BM25 catches exact keyword matches, dense embeddings catch semantic similarity — combining catches more cases than either alone.
- Chunking strategy: too small loses context, too large dilutes relevance — usually 200-500 tokens with overlap.
- Hallucination mitigation: cite sources, use "I don't know" fallback if retrieval confidence is low, evaluate with LLM-as-judge (your NovaBite: 95% quality score).

**Agent failure modes to know**
- Tool misuse (wrong tool called, or malformed arguments)
- Infinite loops (agent keeps retrying without converging) — mitigate with max iteration limits
- Hallucinated tool outputs (agent "imagines" a result instead of calling the tool) — mitigate with strict function-calling schemas
- Context window overflow in long multi-turn agent runs — mitigate with summarization/memory pruning

---

## Part 2: Deployment

**Typical path**
1. Model/pipeline ready → wrap in an API (FastAPI — you've done this)
2. Containerize (Docker) — locks in dependencies/environment so it runs identically anywhere
3. Serve:
   - Simple: VM (EC2, DigitalOcean droplet)
   - Managed: SageMaker, Vertex AI, Azure ML — handles scaling
   - Serverless: Lambda, Cloud Run — good for bursty/low-traffic, pay-per-request, scales to zero
4. Frontend: Streamlit (internal tools/demos, you've used this) vs React/Next.js (client-facing production)
5. CI/CD: Git → tests → auto-deploy (even basic GitHub Actions counts)

**LLM-specific deployment concerns (beyond typical MLOps)**
- **Cost per request** — every LLM call costs tokens; cache repeated/similar queries
- **Latency** — streaming responses to feel faster; smaller/cheaper model for simple cases with fallback to bigger model for complex ones (routing)
- **Rate limits** — batching or queuing (Celery/Redis) for heavy async workloads

**Inference optimization (you have a real example: YOLO → ONNX)**
- ONNX export: converts model to a runtime-optimized format, faster inference, works across hardware
- Quantization: reduce precision (FP32→INT8) to shrink model size/speed up inference at small accuracy cost
- Distillation: train a smaller model to mimic a larger one

**One-liner if asked "how would you deploy X for us"**
"I'd start with a FastAPI backend wrapping the model, containerize with Docker for consistency, and serve on a cloud service behind a simple API gateway — with monitoring on latency and, for LLM components, token cost and output quality."

---

## Part 3: Monitoring

**What to monitor — split by layer**

*Infrastructure level (standard software monitoring)*
- Latency (p50/p95/p99, not just average — averages hide bad tail experiences)
- Error rate / uptime
- Throughput (requests per second)

*Model/ML level*
- Prediction drift — is the model's output distribution shifting over time vs training data?
- Data drift — is incoming data (e.g., customer messages) statistically different from what the model was trained/tested on?
- Accuracy decay — periodic re-evaluation against labeled samples if ground truth becomes available later

*LLM/GenAI-specific level*
- **Hallucination rate** — sample outputs, check groundedness against retrieved context
- **Retrieval quality** (for RAG) — are the right documents being retrieved? (precision@k)
- **Token usage / cost per request** — track spend, catch runaway prompts
- **User feedback loop** — thumbs up/down, flag rate

**Tools/approaches worth naming**
- Logging + dashboards: Prometheus + Grafana (infra-level), or simpler custom logging to a DB for smaller projects
- LLM-specific eval: LLM-as-judge (your NovaBite approach), or frameworks like RAGAS for RAG-specific metrics (faithfulness, answer relevance, context precision)
- Alerting: threshold-based alerts on error rate/latency spikes, and on cost anomalies for LLM apps specifically

**One-liner if asked about monitoring an AI product**
"Beyond standard latency/error monitoring, for LLM-based features I'd specifically track hallucination rate through periodic groundedness checks, retrieval quality if it's RAG-based, and token cost per request — since that's the metric that silently breaks budgets if a prompt or retrieval step misbehaves."
