# Assumptions

- `custom_field_values` uses `json` data type instead of `jsonb` because it doesn't require encoding/decoding, so it must provide better performance.
- `custom_field_values` is separated from the `users` table because this data is not always required for user selection, so it will have better performance in most cases.
- PostgreSQL provides many JSON processing functions for `json` format so it's easy to search, filter, sort, and group database records.
