-- ============================================================
-- spainish.chat Database Schema
-- All tables include:
--   - version       : integer for optimistic concurrency
--   - created_at    : record creation time
--   - updated_at    : last update time
-- ============================================================

-- Students: one row per learner
CREATE TABLE students (
    id          UUID PRIMARY KEY,
    name        TEXT NOT NULL,
    level       TEXT CHECK (level IN ('beginner','intermediate','advanced')),
    goals       TEXT[],                           -- optional learning goals
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Learning sessions
CREATE TABLE sessions (
    id          UUID PRIMARY KEY,
    student_id  UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    started_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at    TIMESTAMPTZ,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Individual message exchanges during a session
CREATE TABLE messages (
    id          UUID PRIMARY KEY,
    session_id  UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    speaker     TEXT CHECK (speaker IN ('user','ai')) NOT NULL,
    content     TEXT NOT NULL,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Detected mistakes (grammar, vocabulary, pronunciation)
CREATE TABLE mistakes (
    id          UUID PRIMARY KEY,
    session_id  UUID NOT NULL REFERENCES sessions(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Optional spaced-repetition queue for future flashcards
CREATE TABLE study_plan (
    id          UUID PRIMARY KEY,
    student_id  UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    word        TEXT NOT NULL,
    next_review TIMESTAMPTZ NOT NULL,
    ease_factor NUMERIC(4,2) DEFAULT 2.5,  -- SRS tuning
    interval_days INTEGER DEFAULT 1,
    version     INTEGER NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ============================================================
-- Triggers to auto-update updated_at on every UPDATE
-- ============================================================
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_students_updated
BEFORE UPDATE ON students
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_sessions_updated
BEFORE UPDATE ON sessions
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_messages_updated
BEFORE UPDATE ON messages
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_mistakes_updated
BEFORE UPDATE ON mistakes
FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_study_plan_updated
BEFORE UPDATE ON study_plan
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
