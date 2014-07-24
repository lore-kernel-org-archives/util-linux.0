Return-Path: bensberg@justemail.net
Message-Id: <1406197416.24745.145139845.3169FCE4@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Timofey Titovets <nefelim4ag@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>, Karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <53CFF0CC.4000608@gmail.com>
References: <53CAAAB6.6020607@gmail.com> <53CFF0CC.4000608@gmail.com>
Subject: Re: [RFC] [Patch] Created zramctl
Date: Thu, 24 Jul 2014 12:23:36 +0200
List-ID: <util-linux.vger.kernel.org>


On Wed, Jul 23, 2014, at 19:28, Timofey Titovets wrote:
> +.B zramctl
> +.RB { \-f\ [ \-d\ \fIzramdev\fP] }

Hm.  Elsewhere it says that -f and -d cannot be combined,
so you probably forgot the OR operator here:

.RB [ \-f " | " \-d\ \fIzramdev\fP ]

> +.B zramctl
> +is used to fast setup zram devices parametrs, to reset zram devices and to
> +query the status of a used zram devices.

Better:
"is used to quickly set up zram device parameters, to reset zram devices,
and to query the status of used zram devices."

> +.IP "\fB\-s, \-\-size\fP \fIsize\fP
> +force zram driver to reread size of the file associated with the 
> specified zram device

Start a sentence with a capital, end with a period.

> ++The \fIsize\fR arguments may be followed by the multiplicative
> ++suffixes 128K 512M, 1G.

This doesn't make sense.  Also the extra plusses shouldn't be there.
Probably you mean something like:

  The \fIsize\fR argument may be followed by one of the multiplicative
  suffixes K, M, G...  For example: 512M.

> +.IP "\fB\-h, \-\-help\fP"
> +print help

The --version option is missing from the man page.  Copy both of
them verbatim from another recent man page.

> +.SH EXAMPLE
> +The following commands can be used as an example of using the zram device.

The heading already says that it is an example.  Better describe roughly
what the commands do: set up a zram device of one gigabyte , use it as
swap, and reset it after use.  Something like that.


> + * Copyright (c) 20nn  Example Commercial, Inc
> + * Written by Timofey Titovets <Nefelim4ag@gmail.com>

This should probably just say:

 * Copyright (c) 2014 Timofey Titovets <nefelim4ag@gmail.com>


> +	file = fopen(p, "w");
> +	if (file == NULL) {
> +		fprintf(stderr,_("can't write to %s\n"), path);

That should say: "cannot open %s".

> +		return -1;
> +	}
> +	fwrite(data, strlen(data), 1, file);

You don't want to check that the write succeeded?

> +	return 0;
> +	goto fail;
> +fail:

Ehm... return 0 and then goto right here?

> +	printf("Zram module not loaded");
> +	return -1;

Also here you would want to use err() or errx():
errx("the zram module is not loaded");


> +	fputs(USAGE_HEADER, out);
> +	fprintf(out, _(" %s [-d zramX|-f] -s 64M -a lz4 -t 16\n"), "zramctl");

It should describe all possible commands, not give an example:

_(" %s [-d zram<N>|-f] -s <size> -a lz4|lzo -t <number>\n")

> +	fputs(USAGE_OPTIONS, out);
> +	fputs(_(" <no args>             return status of used devices\n"), out);

This is unusual.  After the "Options:" header only options should
follow.  Other descriptions should come before it, or at the end.

It is not yet usual, but it would be nice to have a "docstring" after
the above synopsis, a sentence that very concisely describes the
command.  In this case something like: "Set up a zram device.
Without arguments it reports the status of all used devices."

> +	fputs(_(" -f, --find            find free device\n"), out);
> +	fputs(_(" -d, --device [name]   specify device: zramX\n"), out);
> +	fputs(_(" -r, --reset  [name]   reset specified device\n"), out);

s/[name]/<name>/

> +	fputs(_(" -s, --size [size]     device size: 131072, 1024M...\n"), out);

s/[size]/<size>/   And don't mix examples into the decription.

> +	fputs(_(" -a, --alg [lzo|lz4]   compress algorithm\n"), out);

s/[lzo|lz4]/lzo|lz4/

> +	fputs(_(" -t, --threads [0<num] number of compress streams\n"), out);

s/[0<num]/<number>/

> +			if (dev != NULL) {
> +				fprintf(stderr,_("-f || -d <name>\n"));

Better use an error message in everyday language, not in programmer
speak: "only one of -options d and -f can be used".

> +		case 'a':
> +			if (!strcmp(optarg,"lzo") || !strcmp(optarg,"lz4"))
> +				alg = optarg;
> +			else {
> +				fprintf(stderr,_("%s != lzo|lz4\n"),alg );

In the last line s/alg/optarg/.  Or leave it out altogether.
Also use a human-readable message:
"the algorithm should be either lzo or lz4"

> +	if (!strcmp(dev, "USED")) {
> +		fprintf(stderr,_("all device already used\n") );

"all available devices are in use"

> +	if (dev != NULL && f > 0)
> +		fprintf(stdout,_("%s\n"), dev);

There's no point in gettextizing a string that contains nothing
translatable, so leave out the _() here.

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service
