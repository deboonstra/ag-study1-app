web:
	Rscript -e 'boonstra::render_all(list.files("./docs", "*.Rmd", full.names = TRUE), output_dir = "app/docs")'