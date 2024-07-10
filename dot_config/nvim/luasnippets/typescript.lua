return {
  s("describe", {
    t { 'describe("' },
    i(1, "describe"),
    t { '", () => {', "" },
    t { "\t" },
    i(0),
    t { "", "});" },
  }),
  s("it", {
    t { 'it("' },
    i(1, "should what ?"),
    t { '", () => {', "" },
    t { "\t" },
    i(0),
    t { "", "});" },
  }),
  s("it", {
    t { 'it("' },
    i(1, "should what ?"),
    t { '", async () => {', "" },
    t { "\t" },
    i(0),
    t { "", "});" },
  }),
}
