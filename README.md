# oscal-cli-action

A GitHub Action to process, convert, and validate OSCAL content with the NIST oscal-cli tool.

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
- name: Run oscal-cli for version check (debugging on)
  uses: oscal-club/oscal-cli-action@v1.0.0
  with:
    args: ssp validate repo/path/to/ssp.xml
  id: convert_ssp
```