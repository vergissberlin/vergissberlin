# README automation

`README.md` is partly generated. Marker pairs in the file mark the regions that
GitHub Actions rewrites; everything outside them is hand-written and safe to
edit.

## Workflows

| Workflow | Schedule (UTC) | Writes | Secrets |
| --- | --- | --- | --- |
| [`readme-feeds.yml`](../.github/workflows/readme-feeds.yml) | `0 3 * * *` | `MEDIUM`, `HASHNODE`, `STACKOVERFLOW`, `YOUTUBE`, `TTN` | – |
| [`readme-codestats.yml`](../.github/workflows/readme-codestats.yml) | `20 3 * * *` | `START_SECTION:codestats` | – |
| [`readme-wakatime.yml`](../.github/workflows/readme-wakatime.yml) | `40 3 * * *` | `START_SECTION:waka` | `WAKATIME_API_KEY` |
| [`lint.yml`](../.github/workflows/lint.yml) | on push / PR to `.github/**` | – | – |

All three README writers can also be started by hand via **Actions →
*workflow* → Run workflow** (`workflow_dispatch`).

## Markers

The markers are matched literally. A stray space (`<!--START_SECTION: waka-->`)
silently stops a section from ever updating again, so leave them exactly as they
are:

```html
<!-- MEDIUM:START -->        …  <!-- MEDIUM:END -->
<!-- HASHNODE:START -->      …  <!-- HASHNODE:END -->
<!-- STACKOVERFLOW:START --> …  <!-- STACKOVERFLOW:END -->
<!-- YOUTUBE:START -->       …  <!-- YOUTUBE:END -->
<!-- TTN:START -->           …  <!-- TTN:END -->
<!--START_SECTION:waka-->    …  <!--END_SECTION:waka-->
<!-- START_SECTION:codestats --> … <!-- END_SECTION:codestats -->
```

The two `START_SECTION` blocks must never be collapsed to two adjacent lines
with nothing between them — both actions match on "at least one character" and
skip the section otherwise.

## Design decisions

**One feed workflow, one commit.** The five feed sources used to live in five
workflows on the same cron. They raced each other pushing to the same branch and
produced up to five commits a day. They are now sequential steps in one job:
each writes the file with `skip_commit: true`, and the job commits once at the
end. `enable_keepalive: false` is required alongside `skip_commit` — otherwise
the action falls into its keepalive branch on every run and makes dummy commits.

**Staggered schedules.** The three writers touch the same file, so they run 20
minutes apart at `:00`, `:20` and `:40`. They start at 03:00 rather than
midnight because GitHub's scheduler is heavily oversubscribed at the top of the
hour and around 00:00 UTC in particular.

**Actions pinned to commit SHAs.** These jobs run with `contents: write`, so a
mutable tag on a third-party action is a write-access supply-chain risk. Every
`uses:` is pinned to a SHA with the version in a trailing comment; Dependabot
([`dependabot.yml`](../.github/dependabot.yml)) bumps both together, once a week
in a single grouped PR. The one exception is the `docker://` image in
`lint.yml` — Dependabot does not track those, so bump it by hand.

**Job-scoped `GITHUB_TOKEN` instead of a PAT.** `readme-wakatime.yml` used a
long-lived `secrets.GH_TOKEN`. It now uses `${{ github.token }}`, which is
minted per run, expires with the job, and carries only the permissions the job
declares. The `GH_TOKEN` secret can be deleted from the repository settings.

**No `DEBUG` on codestats-readme.** That action dumps the entire process
environment — including `INPUT_GITHUB_TOKEN` — into the run log whenever the
variable is present, regardless of its value.

## Known constraints

- `vergissberlin/codestats-readme` is pinned to `v0.1.0`. Its default branch
  (`main`) carries a TypeScript rewrite with no built `index.js`, which is what
  `action.yml` still points at, so `main` is not runnable as an action. The old
  `@master` reference in this repository pointed at a branch that does not
  exist at all.
- The TTN feed is a third-party scrape (fetchrss.com) without publish dates,
  hence `disable_item_validation: true`.
- The social icons in the README are pinned to `simple-icons@v3` on jsDelivr.
  Newer majors renamed `twitter` to `x`; verify each icon path resolves before
  bumping the pin.
