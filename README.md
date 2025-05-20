# oscal-cli-action

A GitHub Action to process, convert, and validate OSCAL content with the [`oscal-cli` that the metaschema-framework community maintains](https://github.com/metaschema-framework/oscal-cli) or the original [NIST version of the tool](https://github.com/usnistgov/oscal-cli).

# Usage

**NOTE**: This is a composite action for the GitHub Actions and you must check
the code and setup a Java runtime as dependencies, or it will fail.

```yaml
- name: Checkout
  uses: actions/checkout@755da8c3cf115ac066823e79a1e1788f8940201b
  id: checkout
- name: Setup Java
  uses: actions/setup-java@c3ac5dd0ed8db40fedb61c32fbe677e6b355e94c
  with:
    distribution: adopt
    java-version: 11
  id: setup_java
- name: Validate SSP schema and constraints
  uses: oscal-club/oscal-cli-action@v2.0.1
  with:
    args: validate workspace/path/to/ssp.xml
  id: validate_ssp
- name: Run shell command  with all setup and context from before
  run: |
    ls -lha
  id: post_setup_shell_command
```
