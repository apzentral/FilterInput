# jQuery Filter Input plugin
# Limited keypress input

$ = jQuery

$.fn.extend
	jQFilterInput: (options) ->
		# Default settings (Class Name)
		settings =
			debug: true
			noSpace: 'no-space'
			numberClass: 'numeric'
			integerClass: 'integer'
			posNumberClass: 'positive'
			posIntegerClass: 'positive-integer'
			emailClass: 'email-input'

		# Merge default settings with options.
		settings = $.extend settings, options

		#=== Helper Methods ===#

		toLowerCase = ($el) ->
			$el.val($el.val().toLowerCase())

		#=== Bind event ===#

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
					if e.shiftKey
						e.preventDefault()     # Prevent character input
						return

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
					if e.shiftKey
						e.preventDefault()     # Prevent character input
						return

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
					if e.shiftKey
						e.preventDefault()     # Prevent character input
						return

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
					if e.shiftKey
						e.preventDefault()     # Prevent character input
						return

					if not (e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 48 && e.which <= 57) or (e.which >= 96 && e.which <= 105) )
						e.preventDefault()     # Prevent character input
			)

			#emailClass
			$el.on(
				"keydown"
				"input.#{settings.emailClass}"
				(e) ->
					if not ( e.which is 8 or e.which is 9 or e.which is 17 or e.which is 46 or (e.which >= 35 && e.which <= 40) or (e.which >= 47 and e.which <= 57) or (e.which >= 94 && e.which <= 126) or (e.which >= 65 and e.which <= 90) or e.which is 33 or e.which is 42 or e.which is 43 or e.which is 45 or e.which is 61 or e.which is 63 or e.which is 190 or e.which is 110 or e.which is 222 or e.which is 173 or e.which is 191 or e.which is 192 or e.which is 188 or e.which is 59 or (e.which >= 219 and e.which <= 221) )
						e.preventDefault()     # Prevent character input
					val = $(this).val();
					if( e.which is 50 && /[@]/g.test(val) )
						e.preventDefault()     # Prevent character input

			)
			$el.on(
				"keyup"
				"input.#{settings.emailClass}"
				(e) =>
					toLowerCase ($(e.currentTarget))
			)

		# Simple logger.
		log = (msg) ->
			console?.log msg if settings.debug

		# enumerate through the elements
		return @each ()->
			bindEvent $(this)
