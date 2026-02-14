Write end-to-end smoke tests for a set of features using the Playwright-based test framework at `frontend/tests-end-to-end`.

When you need to create a project with a drawing for an end-to-end test, you the drawing files located in [drawings](../../frontend/tests-end-to-end/drawings)

# Test Philosophy

End-to-end tests are **smoke tests** - high-level verification that features work. Key principles:
- **UI-only**: All interactions through UI elements (clicks, fills, navigations). Never call APIs directly.
- **Simple and focused**: Test the happy path. Don't test edge cases or error handling unless critical.
- **Fragile by nature**: UI tests break easily. Simpler tests break less.
- **Minimize test methods**: There is significant overhead with running each test method (browser setup, authentication, etc.). Prefer fewer, longer test methods that verify multiple related behaviors over many small single-assertion tests. A single test method that validates an entire user flow is better than five separate methods testing each step.

# Step 1: Understand the Features to Test

Review the feature description provided with this keyword. Identify:
1. What user flows need testing (e.g., "user can create a project", "user can upload a document")
2. What pages/URLs are involved
3. What UI interactions are required (clicks, form fills, file uploads)
4. What constitutes success (URL changes, elements appearing, data displayed)


# Step 2: Review Existing Test Framework

Before writing tests, review:
1. `frontend/tests-end-to-end/conftest.py` - Available fixtures (`base_url`, `browser`, `page`)
2. `frontend/tests-end-to-end/create_test_users.py` - Helper functions (`generate_test_email`, `register_user_via_ui`, `login_user_via_ui`, etc.)
3. `frontend/tests-end-to-end/tests/test_registration_login.py` - Example test patterns

# Step 3: Identify UI Selectors

For each feature flow:
1. Navigate to the relevant frontend page
2. Inspect the React components to identify CSS classes, IDs, or data attributes for:
   - Buttons to click
   - Inputs to fill
   - Elements to verify exist
   - URLs to wait for

**Selector priority** (most stable to least):
1. `data-testid` attributes (if present)
2. Unique IDs (`#element-id`)
3. Semantic class names (`.submit-button`, `.project-name-input`)
4. Element type + class combinations (`button.primary-action`)

# Step 4: Write the Tests

Update existing (preferred) or create a new test file at `frontend/tests-end-to-end/tests/test_<feature_name>.py`

**important reminder to minimize test methods**
There is significant overhead with running each test method (browser setup, authentication, etc.). Prefer fewer, longer test methods that verify multiple related behaviors over many small single-assertion tests. A single test method that validates an entire user flow is better than five separate methods testing each step.


## Test File Structure

```python
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from create_test_users import generate_test_email, login_user_via_ui, TEST_PASSWORD


class Test<FeatureName>:
    """Tests for <feature> functionality."""

    def test_<feature>_complete_flow(self, page, base_url):
        """Test the complete user flow for <feature>.

        Verifies: page loads, form interactions, data persistence, etc.
        """
        # 1. Set up user if needed (register/login)
        email = generate_test_email()
        login_user_via_ui(page, base_url, email)

        # 2. Navigate to page and verify it loads
        page.goto(f"{base_url}/feature-page")
        assert page.locator(".page-header").count() == 1

        # 3. Perform main user flow actions
        page.locator("input.name-input").fill("test value")
        page.locator("button.submit-button").click()

        # 4. Verify success and data persistence
        page.wait_for_url("**/success**", timeout=15000)
        assert page.locator(".success-message").count() == 1

        # 5. Verify additional behaviors in same test
        # (continue testing related functionality here rather than
        #  creating separate test methods)
        pass
```

**Note:** Consolidate related verifications into a single test method. The overhead of browser setup, authentication, and navigation for each test method is significant. Test multiple aspects of a feature flow within one method rather than splitting into many small tests.

## Test Patterns

### Navigation and Waiting
```python
page.goto(f"{base_url}/some-page")
page.wait_for_url("**/expected-url**", timeout=15000)
page.wait_for_selector(".element-class", timeout=10000)
page.wait_for_load_state("networkidle")
```

### Form Interactions
```python
page.locator("input.email-input").fill("test@example.com")
page.locator("button.submit-button").click()
```

### Element Verification
```python
assert page.locator(".success-message").count() == 1
assert "/dashboard" in page.url
```

### Multiple Inputs
```python
inputs = page.locator("input.form-input")
inputs.nth(0).fill("first value")
inputs.nth(1).fill("second value")
```

### File Uploads
```python
page.locator("input[type='file']").set_input_files("/path/to/file.pdf")
```

## Timeouts

Use appropriate timeouts for different operations:
- Page navigation: 15000ms
- Element appearance: 10000ms
- Network operations: 30000ms (if waiting for backend processing)

# Step 5: Test Organization

- **One test class per feature area** (e.g., `TestProjectCreation`, `TestDocumentUpload`)
- **Minimize test methods**: Consolidate related assertions and flows into as few test methods as possible. Each test method has significant overhead (browser launch, authentication, page navigation). A single comprehensive test method is better than many small ones.
- **Test method naming**: `test_<feature>_complete_flow` or `test_<what>_<expected_outcome>` (e.g., `test_project_creation_flow`)
- **Keep tests independent**: Each test should set up its own state (create user, navigate from scratch)

# Step 6: Validate Code Quality

Before declaring done:
1. Verify tests follow patterns from `test_registration_login.py`
2. Check selectors match actual frontend elements
3. Ensure timeouts are reasonable
4. Run `git add` on new test files

Follow all principles in [instructions--coding_principles.md](instructions--coding_principles.md)
