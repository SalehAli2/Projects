# RAG + LangGraph Cheat Sheet

## Part 1: RAG (Retrieval-Augmented Generation)

**One-sentence definition**
"Instead of relying only on what the LLM learned during training, RAG retrieves relevant documents at query time and feeds them into the prompt, so answers are grounded in current, specific, or proprietary data."

**Why RAG instead of just fine-tuning**
- Fine-tuning bakes knowledge into weights — expensive to update, can't cite sources, risk of forgetting.
- RAG keeps knowledge external and swappable — update the document store, no retraining needed. Also gives you traceability (you can point to which chunk the answer came from).
- Use fine-tuning when you need consistent *behavior/format/style*; use RAG when you need current or proprietary *knowledge*.

**The pipeline (know each stage)**
1. **Ingest** — load documents (PDFs, web pages, DB records)
2. **Chunk** — split into pieces (~200-500 tokens, with overlap so context isn't cut mid-thought)
3. **Embed** — convert chunks to vectors (embedding model: nomic-embed-text, e5, OpenAI embeddings, or AraBERT-based for Arabic)
4. **Store** — vector DB (FAISS, Chroma — both on your CV)
5. **Retrieve** — at query time, embed the query, find nearest chunks (cosine similarity/ANN search)
6. **Augment + Generate** — insert retrieved chunks into the LLM prompt, generate the final answer

**Key design decisions to justify out loud**
- **Chunk size** — too small loses context, too large dilutes relevance and wastes tokens
- **Hybrid retrieval (BM25 + dense/FAISS)** — BM25 catches exact keyword/term matches (good for names, IDs, exact phrases); dense embeddings catch semantic similarity (good for paraphrased queries). Combining catches more cases than either alone. **This is literally what you did in NovaBite — mention it by name.**
- **Top-k** — how many chunks to retrieve; too few misses info, too many adds noise and cost
- **Re-ranking** — optional second pass that re-scores retrieved chunks with a more precise (often cross-encoder) model before feeding to the LLM

**Hallucination mitigation (be ready with 2-3 concrete techniques)**
- Ground every claim in retrieved context; instruct the model to say "I don't know" if context is insufficient
- Cite sources in the output so users can verify
- Evaluate with **LLM-as-judge** — have another LLM call score faithfulness/relevance (your NovaBite: 95% quality score using this method)
- Frameworks worth naming if pushed: **RAGAS** (metrics: faithfulness, answer relevance, context precision/recall)

**RAG failure modes**
- Retrieval miss (right answer exists but wasn't retrieved) → fix: better chunking, hybrid retrieval, higher top-k
- Retrieval noise (irrelevant chunks retrieved) → fix: re-ranking, better embeddings, filtering by metadata
- Generation ignores context (LLM answers from its own memory instead of retrieved docs) → fix: stronger system prompt instructions, smaller/more focused context

**Your one-liner**
"My NovaBite project used hybrid retrieval — BM25 plus FAISS — specifically because keyword matching alone misses semantic paraphrases, and pure dense retrieval alone can miss exact terms like specials or reservation codes. I evaluated the pipeline with an LLM-as-judge framework and hit 95% quality, focusing especially on hallucination prevention."

---

## Part 2: LangGraph

**What problem it solves**
LangChain alone handles mostly linear chains (step 1 → step 2 → step 3). Real agent workflows aren't linear — you need branching, loops, retries, and shared state across multiple agents. LangGraph models the workflow as a **graph**: nodes = steps/agents, edges = transitions (including conditional ones), with a shared state object passed along.

**Core concepts**
- **State** — a shared object (like a dict/schema) that persists and updates across nodes — e.g., conversation history, retrieved docs, current task status
- **Nodes** — individual steps or agents (e.g., "RAG agent," "tool-calling agent," "orchestrator")
- **Edges** — define what happens next; can be fixed or **conditional** (e.g., "if retrieval confidence is low, go back and retry with reformulated query, else proceed to generation")
- **Cycles/loops** — unlike a simple chain, LangGraph allows going back to a previous node — critical for retry logic or iterative refinement

**Why multi-agent (via LangGraph) over single-agent**
- Task decomposition: each agent has a focused prompt/context instead of one agent trying to reason about everything at once — reduces confusion and errors
- Specialization: a retrieval agent doesn't need the same instructions as a tool-calling agent; separating them keeps each prompt clean
- Easier debugging: you can see exactly which agent/step failed in the graph, rather than untangling one giant prompt

**Your example architecture (NovaBite) — describe this structure clearly**
- **Orchestrator** — routes incoming queries to the right agent based on intent (is this a menu/FAQ question, or a reservation/action request?)
- **RAG agent** — handles retrieval + grounded Q&A (menu, hours, specials)
- **Tool-calling / operations agent** — calls simulated MCP tools: reservations, availability checks, daily specials, loyalty points
- This is a clean example of **conditional routing + specialized nodes + shared state** (the conversation/session state flows through all of them)

**StoryTeller example (sequential multi-agent, different pattern)**
- Segmentation agent → prompt generation agent → image synthesis agent, in sequence with state carried forward (the story context informs each subsequent step)
- Good contrast to mention: NovaBite = **routing/branching** graph, StoryTeller = **sequential pipeline** graph — shows you understand LangGraph isn't just one pattern

**Common LangGraph failure modes to know**
- Infinite loops if a conditional edge never resolves to an exit condition → mitigate with max iteration/step limits
- State bloat — passing too much accumulated state between nodes slows things down and can blow context windows → mitigate with pruning/summarizing state periodically
- Agent miscommunication — one agent's output format doesn't match what the next agent expects → mitigate with strict schemas (Pydantic models) for state

**Your one-liner**
"I used LangGraph over plain LangChain chains specifically because the workflow needed branching — an orchestrator deciding whether a query needs retrieval or a tool call — and shared state across agents, which a linear chain can't handle. LangGraph's graph structure with conditional edges made that routing explicit and debuggable."

---

## Quick contrast if asked "LangChain vs LangGraph"
| | LangChain | LangGraph |
|---|---|---|
| Structure | Mostly linear chains | Graph (nodes + edges), supports branching/loops |
| State | Passed through the chain | Explicit shared state object |
| Best for | Simple sequential tasks | Multi-agent, conditional routing, retries |
