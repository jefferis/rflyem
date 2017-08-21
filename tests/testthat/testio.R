context("read_synapse")

test_that("read_synapse works", {
  f=system.file('testdata/testsynapse.json', package = 'rflyem')
  expect_is(s <- read_synapse(f), 'list')
  expect_equal(names(s), c("tbars", "partners"))
  expect_true(all(s$partners$tbarid %in% seq_len(nrow(s$tbars))))
})

