# API Design Rules

Instruction set for an LLM-powered code review agent.
These rules encode **default heuristics**, not dogma. Enforce them unless a documented exception is justified by domain constraints.

The goal is not REST purity. The goal is **low cognitive load, safe evolution, and predictable client behavior**.

---

## Rule 1: Resources Are Nouns by Default

**Requirement:** URL paths should model resources (nouns). The HTTP method supplies the verb.

**Incorrect:**
- `GET /getUsers`
- `POST /deleteOrder`
- `GET /sendEmail`

**Correct:**
- `GET /users`
- `DELETE /orders/123`
- `POST /emails`

**Allowed exceptions (must be justified):**
- Command- or workflow-oriented domains where the primary concept is an action or transition (e.g., jobs, tasks, exports).
- In such cases, model the *action as a resource*:
  - `POST /exports`
  - `POST /payments/refunds`

**Rationale:** Resource-oriented paths are easier to reason about, cache, extend, and document. Exceptions must preserve clarity and consistency.

---

## Rule 2: Plural Nouns Only

**Requirement:** All resource names must use plural form.

**Incorrect:**
- `/user`
- `/order/123`

**Correct:**
- `/users`
- `/orders/123`

**Rationale:** Consistency eliminates ambiguity and reduces cognitive load across large APIs. Pick plural once and apply universally.

---

## Rule 3: Client-Facing Identifiers Must Be Opaque by Default

**Requirement:** Public or external APIs must not expose identifiers whose structure creates security, enumeration, coupling, or migration risk.

**Incorrect (public APIs):**
- `/users/1`
- `/orders/42`
- `{"userId": 12345}`

**Correct:**
- `/users/550e8400-e29b-41d4-a716-446655440000`
- `/users/cust_01H7XYZ...`
- `{"userId": "usr_9k3j2h1..."}`

**Notes:**
- Internal APIs behind strong auth *may* use numeric IDs if risk is understood and accepted.
- Never assume today’s “internal” API will stay internal.

**Rationale:** Sequential IDs leak cardinality, enable enumeration, and tightly couple clients to storage details.

---

## Rule 4: HTTP Methods Must Match Semantics

**Requirement:** Use HTTP methods according to their semantic meaning.

**Read-only:**
- `GET` – Retrieve resource(s)

**State-changing:**
- `POST` – Create or trigger a non-idempotent operation
- `PUT` – Replace entire resource (idempotent)
- `PATCH` – Partial update (idempotent if possible)
- `DELETE` – Remove resource (idempotent)

**Incorrect:**
- `GET /users/123/delete`
- `POST /users/123/activate`

**Correct:**
- `DELETE /users/123`
- `POST /users/123/activation`

**Rationale:** Correct semantics enable caching, retries, idempotency, and sane client behavior.

---

## Rule 5: Version the Contract Explicitly

**Requirement:** Breaking API changes must be isolated behind a versioned contract.

**Preferred default:**
- URL versioning: `/api/v1/users`, `/api/v2/users`

**Notes:**
- Headers or content negotiation are acceptable only with strong discipline and tooling.
- The invariant is **parallel contract support**, not the mechanism.

**Rationale:** Clients must not be forced to upgrade on your schedule.

---

## Rule 6: Errors Are Predictable, Structured JSON

**Requirement:** All error responses must follow a consistent schema.

**Required fields:**
- `error` – Machine-readable code (UPPER_SNAKE_CASE)
- `message` – Human-readable summary
- `requestId` – Unique request identifier

**Optional fields:**
- `detail` – Context-specific information safe to expose

**Example:**
```json
{
  "error": "INSUFFICIENT_FUNDS",
  "message": "Account balance too low",
  "detail": "Required: 100.00 USD, available: 3.42 USD",
  "requestId": "req_01H..."
}
```

**Rationale:** Predictability enables robust client handling, logging, and support workflows.

---

## Rule 7: Filtering, Sorting, Pagination Must Be Uniform

**Requirement:** All collection endpoints must share the same query conventions.

**Standard pattern:**
```
GET /orders?status=shipped&sort=-createdAt&page=3&limit=50
```

**Conventions:**
- Filtering: `?field=value`
- Sorting: `?sort=field` or `?sort=-field`
- Pagination: `page + limit` or `offset + limit` (choose one)

**Incorrect:**
- Mixing `filter[...]`, `sortBy`, `orderBy`, etc.
- Endpoint-specific query grammars

**Rationale:** Uniformity prevents bugs, reduces client complexity, and simplifies tooling.

---

## Rule 8: Design the Contract First

**Requirement:** The API contract must be defined before implementation.

**Workflow:**
1. Write OpenAPI specification
2. Review contract semantics and edge cases
3. Generate server stubs and client SDKs
4. Implement logic
5. Validate implementation against spec

**Rationale:** Contract-first design exposes ambiguity early and enables parallel development.

---

## Rule 9: Idempotency and Retries Are First-Class Emissions

**Requirement:** Any endpoint that can be retried safely **must** be idempotent or support idempotency keys.

**Examples:**
- `POST /payments` supports `Idempotency-Key`
- `PUT` and `DELETE` are idempotent by design

**Rationale:** Networks fail. Clients retry. APIs that ignore this reality break money, data, and trust.

---

## Anti-Patterns (Reject in Review)

- `POST /processPaymentAndSendEmailAndUpdateInventory`
- `GET /api/v1/doEverything?type=refund&userId=456&amount=99.99`
- `GET` endpoints that mutate state
- Endpoint-specific query syntaxes
- Exposing storage details as contract

---

## Enforcement Guidance for LLM Reviewer

- Treat rules as **strong defaults**, not religious laws.
- Allow exceptions **only** when:
  - The domain demands it, and
  - The exception is explicitly documented in the PR.
- Favor predictability, safety, and evolvability over stylistic purity.