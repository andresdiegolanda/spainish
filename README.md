# SpAInish.chat

**SpAInish.chat** is an AI-powered Spanish learning companion designed for natural conversation practice.  
It combines **ChatGPT**’s voice capabilities with a custom backend to track progress, analyze mistakes, and generate weekly learning reports.

---

## 🌟 Project Goals
- Provide **fun, real-time Spanish conversations** (voice or text) for learners—starting with a 13-year-old pilot user.
- Deliver **personalized feedback** on grammar, vocabulary, and pronunciation.
- Track learning data and produce **automatic weekly reports** for parents or teachers.
- Build a scalable backend that can evolve from a personal project into a small EdTech product.

---

## 🏗️ Architecture (MVP)
- **Frontend**: ChatGPT mobile app (voice mode) + optional web client.
- **Backend**:  
  - AWS Lambda (Java 21 / Spring Boot optional)  
  - API Gateway for HTTPS endpoints  
  - PostgreSQL (RDS) for sessions, mistakes, and spaced-repetition data  
  - S3 for optional audio/log storage
- **AI**: Custom GPT with Actions calling the backend to:
  - Retrieve student profile & learning goals
  - Log session data and analysis
  - Trigger weekly report generation

---

## 🚀 Current Status
- ✅ Domain registered: **spainish.chat**  
- ✅ GitHub repository created  
- ✅ Notion workspace set up for documentation  
- ⏳ Backend skeleton & database schema (in progress)

---

## 📂 Repository Structure (planned)
/backend # Java/Spring Boot Lambda code
/frontend # (optional) Web UI if added later
/docs # Architecture diagrams, API specs, prompts


---

## 🗺️ Roadmap (next milestones)
1. **Backend API skeleton** – Lambda + API Gateway “Hello World”.
2. **Database schema** – tables for users, sessions, mistakes, spaced-repetition queue.
3. **Custom GPT Actions** – connect ChatGPT to backend endpoints.
4. **Weekly report generator** – compile learning metrics and email parents.

---

## 🤝 Contributing
This is an early-stage personal project.  
Issues and pull requests are welcome as the codebase becomes public.

---

## 📄 License
MIT (to be confirmed).  
Please check `LICENSE` before using code in production.

---

## 💬 Contact
Project creator: [Andrés Landa](mailto:your.email@example.com)  
Project updates: [spainish.chat](https://spainish.chat) (coming soon)
