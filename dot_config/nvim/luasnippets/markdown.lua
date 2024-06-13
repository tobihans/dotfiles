return {
  s("daily-report", {
    t { "# Daily Report", "", "" },
    t { string.format("**Date**: %s", os.date "%Y-%m-%d"), "", "" },
    t { "**Tasks**: ", "- " },
    i(0),
    t { "", "", "**Blockers**: ", "- " },
    i(1, "None"),
    t { "", "", "Thanks." },
  }),
}
