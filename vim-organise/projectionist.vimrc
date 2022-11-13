" See Greg Hurrell vim screencast video on youtube
     let g:projectionist_heuristics = {
	   \"*": {
	     \"*.tsx": {
	       \"alternate": [
		 \"{}.test.tsx",
		 \],
		 \"type": "source"
		 \},
		 \"*.test.tsx": {
		   \  "alternate": [
		     \"{}.tsx"
		     \],
		     \  "type": "test"
		     \  },
		     \}
		     \}

