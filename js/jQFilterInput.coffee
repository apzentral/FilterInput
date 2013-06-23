# jQuery Filter Input plugin
# Limited keypress input

$ = jQuery

$.fn.extend
	jQFilterInput: (options) ->
		# Default settings (Class Name)
		settings =
			noSpace: 'no-space'
			numberClass: 'numeric'
			integerClass: 'integer'
			posNumberClass: 'positive'
			posIntegerClass: 'positive-integer'
			debug: true

		# Merge default settings with options.
		settings = $.extend settings, options

		# Bind event
		bindEvent = ($el) ->
			# noSpace
			$el.on(
				"keydown"
				"input.#{settings.noSpace}"
				(e) ->
					if e.which is 32
						e.preventDefault()     # Prevent character input
			)

			#numberClass
			$el.on(
				"keydown"
				"input.#{settings.numberClass}"
				(e) ->
					if not (e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 48 && e.which <= 57) or (e.which >= 96 && e.which <= 105) or (e.which is 190) or (e.which is 110) or (e.which is 173))
						e.preventDefault()     # Prevent character input

					val = $(this).val();
					if ( (e.which == 190 || e.which == 110) && ( ! val || /[\.]/g.test(val) ))
						e.preventDefault()     # Prevent character input
					else if ( e.which is 173 && val.length > 0 )
						e.preventDefault()     # Prevent - input
			)

			#integerClass
			$el.on(
				"keydown"
				"input.#{settings.integerClass}"
				(e) ->
					if not (e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 48 && e.which <= 57) or (e.which >= 96 && e.which <= 105) or (e.which is 173))
						e.preventDefault()     # Prevent character input

					val = $(this).val();
					if ( e.which is 173 && val.length > 0 )
						e.preventDefault()     # Prevent - input
			)

			#posNumberClass
			$el.on(
				"keydown"
				"input.#{settings.posNumberClass}"
				(e) ->
					if not (e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 48 && e.which <= 57) or (e.which >= 96 && e.which <= 105) or (e.which is 190) or (e.which is 110))
						e.preventDefault()     # Prevent character input

					val = $(this).val();
					if ( (e.which == 190 || e.which == 110) && ( ! val || /[\.]/g.test(val) ))
						e.preventDefault()     # Prevent character input
			)

			#posIntegerClass
			$el.on(
				"keydown"
				"input.#{settings.posIntegerClass}"
				(e) ->
					if not (e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 48 && e.which <= 57) or (e.which >= 96 && e.which <= 105) )
						e.preventDefault()     # Prevent character input
			)

		# Simple logger.
		log = (msg) ->
			console?.log msg if settings.debug

		# enumerate through the elements
		return @each ()->
			bindEvent $(this)
