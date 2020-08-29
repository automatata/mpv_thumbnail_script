all: mpv_thumbnail_script

mpv_thumbnail_script: mpv_thumbnail_script_server mpv_thumbnail_script_client \
		mpv_thumbnail_script_thumbnail_cleaner

mpv_thumbnail_script_server:
	./concat_files.py -r cat_server.json

mpv_thumbnail_script_client:
	./concat_files.py -r cat_osc.json

mpv_thumbnail_script_thumbnail_cleaner:
	cp src/thumbnailer_cleaner.lua mpv_thumbnail_script_cleaner.lua

clean:
	rm mpv_thumbnail_script_server.lua mpv_thumbnail_script_client_osc.lua \
		mpv_thumbnail_script_cleaner.lua
