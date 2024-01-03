web:
	Rscript -e 'boonstra::render_all(list.files("./docs", "*.Rmd", full.names = TRUE))'