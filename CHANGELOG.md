# Changelog

## 0.1.2
### Breaking changes
- Change to configuration `pdf_generator_url`. It should not contain the path only the url to the service.
    - Before: `https://your-service/forms/chromium/convert/url,`
    - After: `https://your-service`

### New features
- Add health function to check if the service is up and running.
