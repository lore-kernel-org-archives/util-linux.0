Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbdFSJW7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 05:22:59 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidparse: add new command
Date: Mon, 19 Jun 2017 11:22:48 +0200
Cc: util-linux@vger.kernel.org
References: <20170618172536.21544-1-kerolasa@iki.fi>
In-Reply-To: <20170618172536.21544-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706191122.48481.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 18 June 2017, Sami Kerola wrote:
> This command will analyze and print information about UUID's.  The
> command is based on libuuid/src/uuid_time.c but modified to use
> libsmartcol.
>
> Reference: http://marc.info/?l=util-linux-ng&m=149735980715600&w=2
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  .gitignore                    |   1 +
>  configure.ac                  |   5 +
>  misc-utils/Makemodule.am      |   8 +
>  misc-utils/uuidparse.1        |  69 +++++++
>  misc-utils/uuidparse.c        | 441
> ++++++++++++++++++++++++++++++++++++++++++ tests/commands.sh         
>    |   1 +
>  tests/expected/uuid/uuidparse |  33 ++++
>  tests/ts/uuid/uuidparse       |  63 ++++++
>  8 files changed, 621 insertions(+)
>  create mode 100644 misc-utils/uuidparse.1
>  create mode 100644 misc-utils/uuidparse.c
>  create mode 100644 tests/expected/uuid/uuidparse
>  create mode 100755 tests/ts/uuid/uuidparse
>
> diff --git a/.gitignore b/.gitignore
> index 38afedbab..7a6c4afc2 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -165,6 +165,7 @@ ylwrap
>  /utmpdump
>  /uuidd
>  /uuidgen
> +/uuidparse
>  /vipw
>  /wall
>  /wdctl
> diff --git a/configure.ac b/configure.ac
> index 53d25b8ab..34980ab40 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1146,6 +1146,11 @@ UL_BUILD_INIT([uuidgen], [check])
>  UL_REQUIRES_BUILD([uuidgen], [libuuid])
>  AM_CONDITIONAL([BUILD_UUIDGEN], [test "x$build_uuidgen" = xyes])
>
> +UL_BUILD_INIT([uuidparse], [check])
> +UL_REQUIRES_BUILD([uuidparse], [libuuid])
> +UL_REQUIRES_BUILD([uuidparse], [libsmartcols])
> +AM_CONDITIONAL([BUILD_UUIDPARSE], [test "x$build_uuidparse" = xyes])
> +
>  UL_BUILD_INIT([blkid], [check])
>  UL_REQUIRES_BUILD([blkid], [libblkid])
>  AM_CONDITIONAL([BUILD_BLKID], [test "x$build_blkid" = xyes])
> diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
> index f28261c8b..87ea9ff2a 100644
> --- a/misc-utils/Makemodule.am
> +++ b/misc-utils/Makemodule.am
> @@ -88,6 +88,14 @@ uuidgen_LDADD = $(LDADD) libuuid.la
>  uuidgen_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
>  endif
>
> +if BUILD_UUIDPARSE
> +usrbin_exec_PROGRAMS += uuidparse
> +dist_man_MANS += misc-utils/uuidparse.1
> +uuidparse_SOURCES = misc-utils/uuidparse.c
> +uuidparse_LDADD = $(LDADD) libcommon.la libuuid.la libsmartcols.la
> +uuidparse_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
> -I$(ul_libsmartcols_incdir) +endif
> +
>  if BUILD_UUIDD
>  usrsbin_exec_PROGRAMS += uuidd
>  dist_man_MANS += misc-utils/uuidd.8
> diff --git a/misc-utils/uuidparse.1 b/misc-utils/uuidparse.1
> new file mode 100644
> index 000000000..56c108473
> --- /dev/null
> +++ b/misc-utils/uuidparse.1
> @@ -0,0 +1,69 @@
> +.\" Copyright (c) 2017 Sami Kerola
> +.\" The 3-Clause BSD License
> +.TH UUIDPARSE "1" "2017-06-18" "util-linux" "User Commands"
> +.SH NAME
> +uuidparse \- an utility to parse unique identifiers
> +.SH SYNOPSIS
> +.B uuidparse
> +[options]
> +.I uuid
> +.SH DESCRIPTION
> +This command will parse unique identifier inputs from either command
> line +arguments or standard input.  The inputs are white-space
> separated. +.SH OUTPUT
> +.SS Variants
> +.TS
> +tab(:);
> +left l l.
> +NCS:Network Computing System identifier.  These were the original
> UUIDs. +DCE:The Open Software Foundation's (OSF) Distributed
> Computing Environment UUIDs. +Microsoft:Microsoft Windows platform
> globally unique identifier (GUID). +other:Unknown variant.  Usually
> invalid input data.
> +.TE
> +.SS Types
> +.TS
> +tab(:);
> +left l l.
> +nil:Special type for zero in type file.
> +time based:The DCE time based.
> +DCE:The DCE time and MAC Address.
> +name-based:RFC 4122 md5sum hash.
> +random:RFC 4122 random.
> +sha1-based:RFC 4122 sha-1 hash.
> +unknown:Unknown type.  Usually invalid input data.
> +.TE
> +.SH OPTIONS
> +.TP
> +\fB\-J\fR, \fB\-\-json\fR
> +Use JSON output format.
> +.TP
> +\fB\-n\fR, \fB\-\-noheadings\fR
> +Do not print a header line.
> +.TP
> +\fB\-o\fR, \fB\-\-output\fR
> +Specify which output columns to print.  Use \-\-help to get a list
> of all +supported columns.
> +.TP
> +\fB\-r\fR, \fB\-\-raw\fR
> +Use the raw output format.
> +.TP
> +\fB\-V\fR, \fB\-\-version\fR
> +Display version information and exit.
> +.TP
> +\fB\-h\fR, \fB\-\-help\fR
> +Display help text and exit.
> +.SH AUTHORS
> +.MT kerolasa@iki.fi
> +Sami Kerola
> +.ME
> +.SH "SEE ALSO"
> +.BR uuidgen (1),
> +.BR libuuid (3),
> +.UR https://\:tools.ietf.org\:/html\:/rfc4122
> +RFC 4122
> +.UE
> +.SH AVAILABILITY
> +The example command is part of the util-linux package and is
> available from +.UR
> https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/ +Linux
> Kernel Archive
> +.UE .
> diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
> new file mode 100644
> index 000000000..58fd5f208
> --- /dev/null
> +++ b/misc-utils/uuidparse.c
> @@ -0,0 +1,441 @@
> +/*
> + * uuidparse.c --- Interpret uuid encoded information.  This program
> + * 	violates the UUID abstraction barrier by reaching into the
> + * 	guts of a UUID.
> + *
> + * Based on libuuid/src/uuid_time.c
> + * Copyright (C) 1998, 1999 Theodore Ts'o.
> + *
> + * All alterations (C) 2017 Sami Kerola
> + * The 3-Clause BSD License
> + *
> + * Redistribution and use in source and binary forms, with or
> without + * modification, are permitted provided that the following
> conditions + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, and the entire permission notice in its entirety,
> + *    including the disclaimer of warranties.
> + * 2. Redistributions in binary form must reproduce the above
> copyright + *    notice, this list of conditions and the following
> disclaimer in the + *    documentation and/or other materials
> provided with the distribution. + * 3. The name of the author may not
> be used to endorse or promote + *    products derived from this
> software without specific prior + *    written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> + * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
> OR + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
> PROCUREMENT + * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
> OR PROFITS; OR + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> THEORY OF + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> OF THE + * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE
> POSSIBILITY OF SUCH + * DAMAGE.
> + */
> +
> +#include <assert.h>
> +#include <getopt.h>
> +#include <libsmartcols.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#include "c.h"
> +#include "closestream.h"
> +#include "nls.h"
> +#include "optutils.h"
> +#include "strutils.h"
> +#include "timeutils.h"
> +#include "uuid.h"
> +#include "xalloc.h"
> +
> +#define UUID_STR_LEN 37
> +
> +/* Internal uuid struct, this is not part of libuuid api. */
> +struct uuid {
> +	uint32_t time_low;
> +	uint16_t time_mid;
> +	uint16_t time_hi_and_version;
> +	uint16_t clock_seq;
> +	uint8_t node[6];
> +};
> +
> +/* column IDs */
> +enum {
> +	COL_UUID = 0,
> +	COL_VARIANT,
> +	COL_TYPE,
> +	COL_TIME
> +};
> +
> +/* column names */
> +struct colinfo {
> +	const char *name;	/* header */
> +	double whint;		/* width hint (N < 1 is in percent of termwidth) */
> +	int flags;		/* SCOLS_FL_* */
> +	const char *help;
> +};
> +
> +/* columns descriptions */
> +static const struct colinfo infos[] = {
> +	[COL_UUID]    = {"UUID",    UUID_STR_LEN, 0, N_("unique
> identifier")}, +	[COL_VARIANT] = {"VARIANT", 9,  0, N_("variant
> name")},
> +	[COL_TYPE]    = {"TYPE",    10, 0, N_("type name")},
> +	[COL_TIME]    = {"TIME",    31, 0, N_("timestamp")}
> +};
> +
> +static int columns[ARRAY_SIZE(infos) * 2];
> +static size_t ncolumns;
> +
> +struct control {
> +	unsigned int
> +		json:1,
> +		no_headings:1,
> +		raw:1;
> +};
> +
> +static void __attribute__((__noreturn__)) usage(FILE *out)

Do we really need this FILE argument? You are using only stdout in 
uuidparse and that's good and should never change ;) I can't imagine 
any good reason why usage should ever go to stderr and exit(1).

BTW currently I'm going through the whole project to correct all 
commands where we spam the whole usage in case of errors.

> +{
> +	size_t i;
> +
> +	fputs(USAGE_HEADER, out);
> +	fprintf(out, _(" %s [options] <uuid ...>\n"),
> program_invocation_short_name); +	fputs(USAGE_OPTIONS, out);
> +	fputs(_(" -J, --json             use JSON output format\n"), out);
> +	fputs(_(" -n, --noheadings       don't print headings\n"), out);
> +	fputs(_(" -o, --output <list>    define which output columns to
> use\n"), out); +	fputs(_(" -r, --raw              use the raw output
> format\n"), out); +	fputs(USAGE_SEPARATOR, out);
> +	fputs(USAGE_HELP, out);
> +	fputs(USAGE_VERSION, out);
> +	fputs(USAGE_SEPARATOR, out);
> +	fputs(_("Available columns:\n"), out);
> +	for (i = 0; i < ARRAY_SIZE(infos); i++)
> +		fprintf(out, " %8s  %s\n", infos[i].name, _(infos[i].help));
> +	fprintf(out, USAGE_MAN_TAIL("uuidparse(1)"));
> +	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
> +}

We could simply use puts, printf and always EXIT_SUCCESS.


> +
> +static int column_name_to_id(const char *name, size_t namesz)
> +{
> +	size_t i;
> +
> +	assert(name);
> +
> +	for (i = 0; i < ARRAY_SIZE(infos); i++) {
> +		const char *cn = infos[i].name;
> +
> +		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
> +			return i;
> +	}
> +	warnx(_("unknown column: %s"), name);
> +	return -1;
> +}
> +
> +static int get_column_id(size_t num)
> +{
> +	assert(num < ncolumns);
> +	assert(columns[num] < (int)ARRAY_SIZE(infos));
> +	return columns[num];
> +}
> +
> +static const struct colinfo *get_column_info(int num)
> +{
> +	return &infos[get_column_id(num)];
> +}
> +
> +static void uuid_unpack(const uuid_t in, struct uuid *uu)
> +{
> +	const uint8_t *ptr = in;
> +	uint32_t tmp;
> +
> +	tmp = *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	uu->time_low = tmp;
> +
> +	tmp = *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	uu->time_mid = tmp;
> +
> +	tmp = *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	uu->time_hi_and_version = tmp;
> +
> +	tmp = *ptr++;
> +	tmp = (tmp << 8) | *ptr++;
> +	uu->clock_seq = tmp;
> +
> +	memcpy(uu->node, ptr, 6);
> +}
> +
> +time_t uuid_time(const uuid_t uu, struct timeval *ret_tv)
> +{
> +	struct timeval tv;
> +	struct uuid uuid;
> +	uint32_t high;
> +	uint64_t clock_reg;
> +
> +	uuid_unpack(uu, &uuid);
> +
> +	high = uuid.time_mid | ((uuid.time_hi_and_version & 0xFFF) << 16);
> +	clock_reg = uuid.time_low | ((uint64_t) high << 32);
> +
> +	clock_reg -= (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
> +	tv.tv_sec = clock_reg / 10000000;
> +	tv.tv_usec = (clock_reg % 10000000) / 10;
> +
> +	if (ret_tv)
> +		*ret_tv = tv;
> +
> +	return tv.tv_sec;
> +}
> +
> +int uuid_type(const uuid_t uu)
> +{
> +	struct uuid uuid;
> +
> +	uuid_unpack(uu, &uuid);
> +	return ((uuid.time_hi_and_version >> 12) & 0xF);
> +}
> +
> +int uuid_variant(const uuid_t uu)
> +{
> +	struct uuid uuid;
> +	int var;
> +
> +	uuid_unpack(uu, &uuid);
> +	var = uuid.clock_seq;
> +
> +	if ((var & 0x8000) == 0)
> +		return UUID_VARIANT_NCS;
> +	if ((var & 0x4000) == 0)
> +		return UUID_VARIANT_DCE;
> +	if ((var & 0x2000) == 0)
> +		return UUID_VARIANT_MICROSOFT;
> +	return UUID_VARIANT_OTHER;
> +}
> +
> +static void fill_table_row(struct libscols_table *tb, char const
> *const uuid) +{
> +	static struct libscols_line *ln;
> +	size_t i;
> +	uuid_t buf;
> +	int invalid = 0;
> +	int variant, type;
> +
> +	assert(tb);
> +	assert(uuid);
> +
> +	ln = scols_table_new_line(tb, NULL);
> +	if (!ln) {
> +		errno = ENOMEM;
> +		errx(EXIT_FAILURE, _("failed to allocate output line"));
> +	}
> +
> +	if (uuid_parse(uuid, buf))
> +		invalid = 1;
> +	else {
> +		variant = uuid_variant(buf);
> +		type = uuid_type(buf);
> +	}
> +
> +	for (i = 0; i < (size_t)ncolumns; i++) {
> +		char *str = NULL;
> +
> +		switch (get_column_id(i)) {
> +		case COL_UUID:
> +			str = xstrdup(uuid);
> +			break;
> +		case COL_VARIANT:
> +			if (invalid) {
> +				str = xstrdup(_("invalid"));
> +				break;
> +			}
> +			switch (variant) {
> +			case UUID_VARIANT_NCS:
> +				str = xstrdup("NCS");
> +				break;
> +			case UUID_VARIANT_DCE:
> +				str = xstrdup("DCE");
> +				break;
> +			case UUID_VARIANT_MICROSOFT:
> +				str = xstrdup("Microsoft");
> +				break;
> +			default:
> +				str = xstrdup(_("other"));
> +			}
> +			break;
> +		case COL_TYPE:
> +			if (invalid) {
> +				str = xstrdup(_("invalid"));
> +				break;
> +			}
> +			switch (type) {
> +			case 0:
> +				str = xstrdup(_("nil"));
> +				break;
> +			case 1:
> +				str = xstrdup(_("time based"));
> +				break;
> +			case 2:
> +				str = xstrdup("DCE");
> +				break;
> +			case 3:
> +				str = xstrdup(_("name-based"));
> +				break;
> +			case 4:
> +				str = xstrdup(_("random"));
> +				break;
> +			case 5:
> +				str = xstrdup(_("sha1-based"));
> +				break;
> +			default:
> +				str = xstrdup(_("unknown"));
> +			}
> +			break;
> +		case COL_TIME:
> +			if (invalid) {
> +				str = xstrdup(_("invalid"));
> +				break;
> +			}
> +			if (variant == UUID_VARIANT_DCE && type == 1) {
> +				struct timeval tv;
> +				char date_buf[ISO_8601_BUFSIZ + 4];
> +
> +				uuid_time(buf, &tv);
> +				strtimeval_iso(&tv,
> +					       ISO_8601_DATE |
> +						 ISO_8601_TIME |
> +						 ISO_8601_COMMAUSEC |
> +						 ISO_8601_TIMEZONE |
> +						 ISO_8601_SPACE,
> +					       date_buf,
> +					       sizeof(date_buf));
> +				str = xstrdup(date_buf);
> +			} else
> +				str = xstrdup(_(""));
> +			break;
> +		default:
> +			abort();
> +		}
> +		if (str && scols_line_refer_data(ln, i, str))
> +			errx(EXIT_FAILURE, _("failed to add output data"));
> +	}
> +}
> +
> +static void print_output(struct control const *const ctrl, const int
> argc, +			 char **argv)
> +{
> +	struct libscols_table *tb;
> +
> +	scols_init_debug(0);
> +	tb = scols_new_table();
> +	if (!tb)
> +		err(EXIT_FAILURE, _("failed to allocate output table"));
> +
> +	scols_table_enable_json(tb, ctrl->json);
> +	scols_table_enable_noheadings(tb, ctrl->no_headings);
> +	scols_table_enable_raw(tb, ctrl->raw);
> +	{
> +		size_t i;
> +
> +		for (i = 0; i < (size_t)ncolumns; i++) {
> +			const struct colinfo *col = get_column_info(i);
> +
> +			if (!scols_table_new_column(tb, col->name, col->whint,
> +						    col->flags))
> +				err(EXIT_FAILURE,
> +				    _("failed to initialize output column"));
> +		}
> +	}
> +	{
> +		int i;
> +
> +		for (i = 0; i < argc; i++)
> +			fill_table_row(tb, argv[i]);
> +		if (i == 0) {
> +			char uuid[UUID_STR_LEN];
> +
> +			while (scanf(" %" stringify_value(UUID_STR_LEN)
> +				     "[^ \t\n]%*c", uuid) && !feof(stdin))
> +				fill_table_row(tb, uuid);
> +		}
> +	}
> +	scols_print_table(tb);
> +	scols_unref_table(tb);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct control ctrl = { 0 };
> +	int c;
> +	char *outarg = NULL;
> +
> +	static const struct option longopts[] = {
> +		{"json",       no_argument,       NULL, 'J'},
> +		{"noheadings", no_argument,       NULL, 'n'},
> +		{"output",     required_argument, NULL, 'o'},
> +		{"raw",        no_argument,       NULL, 'r'},
> +		{"version",    no_argument,       NULL, 'V'},
> +		{"help",       no_argument,       NULL, 'h'},
> +	};
> +	static const ul_excl_t excl[] = {
> +		{'J', 'r'},
> +		{0}
> +	};
> +	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
> +
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +	atexit(close_stdout);
> +
> +	while ((c = getopt_long(argc, argv, "Jno:rVh", longopts, NULL)) !=
> -1) { +		err_exclusive_options(c, longopts, excl, excl_st);
> +		switch (c) {
> +		case 'J':
> +			ctrl.json = 1;
> +			break;
> +		case 'n':
> +			ctrl.no_headings = 1;
> +			break;
> +		case 'o':
> +			outarg = optarg;
> +			break;
> +		case 'r':
> +			ctrl.raw = 1;
> +			break;
> +		case 'V':
> +			printf(UTIL_LINUX_VERSION);
> +			return EXIT_SUCCESS;
> +		case 'h':
> +			usage(stdout);
> +		default:
> +			errtryhelp(EXIT_FAILURE);
> +		}
> +	}
> +	argc -= optind;
> +	argv += optind;
> +
> +	columns[ncolumns++] = COL_UUID;
> +	columns[ncolumns++] = COL_VARIANT;
> +	columns[ncolumns++] = COL_TYPE;
> +	columns[ncolumns++] = COL_TIME;
> +
> +	if (outarg
> +	    && string_add_to_idarray(outarg, columns, ARRAY_SIZE(columns),
> +				     &ncolumns, column_name_to_id) < 0)
> +		return EXIT_FAILURE;
> +
> +	print_output(&ctrl, argc, argv);
> +
> +	return 0;
> +}
> diff --git a/tests/commands.sh b/tests/commands.sh
> index f655a6829..2d9e3b8ea 100644
> --- a/tests/commands.sh
> +++ b/tests/commands.sh
> @@ -93,6 +93,7 @@
> TS_CMD_UMOUNT=${TS_CMD_UMOUNT:-"$top_builddir/umount"}
> TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
> TS_CMD_UUIDD=${TS_CMD_UUIDD-"$top_builddir/uuidd"}
>  TS_CMD_UUIDGEN=${TS_CMD_UUIDGEN-"$top_builddir/uuidgen"}
> +TS_CMD_UUIDPARSE=${TS_CMD_UUIDPARSE-"$top_builddir/uuidparse"}
>  TS_CMD_WHEREIS=${TS_CMD_WHEREIS-"$top_builddir/whereis"}
>  TS_CMD_WIPEFS=${TS_CMD_WIPEFS-"$top_builddir/wipefs"}
>  TS_CMD_CHRT=${TS_CMD_CHRT-"$top_builddir/chrt"}
> diff --git a/tests/expected/uuid/uuidparse
> b/tests/expected/uuid/uuidparse new file mode 100644
> index 000000000..07347be91
> --- /dev/null
> +++ b/tests/expected/uuid/uuidparse
> @@ -0,0 +1,33 @@
> +UUID                                  VARIANT   TYPE       TIME
> +00000000-0000-0000-0000-000000000000  NCS       nil
> +00000000-0000-1000-0000-000000000000  NCS       time based
> +00000000-0000-2000-0000-000000000000  NCS       DCE
> +00000000-0000-3000-0000-000000000000  NCS       name-based
> +00000000-0000-4000-0000-000000000000  NCS       random
> +00000000-0000-5000-0000-000000000000  NCS       sha1-based
> +00000000-0000-6000-0000-000000000000  NCS       unknown
> +00000000-0000-0000-8000-000000000000  DCE       nil
> +00000000-0000-1000-8000-000000000000  DCE       time based
> 60038-03-11 05:36:10,955161+0000
> +00000000-0000-2000-8000-000000000000  DCE       DCE
> +00000000-0000-3000-8000-000000000000  DCE       name-based
> +00000000-0000-4000-8000-000000000000  DCE       random
> +00000000-0000-5000-8000-000000000000  DCE       sha1-based
> +00000000-0000-6000-8000-000000000000  DCE       unknown
> +00000000-0000-0000-d000-000000000000  Microsoft nil
> +00000000-0000-1000-d000-000000000000  Microsoft time based
> +00000000-0000-2000-d000-000000000000  Microsoft DCE
> +00000000-0000-3000-d000-000000000000  Microsoft name-based
> +00000000-0000-4000-d000-000000000000  Microsoft random
> +00000000-0000-5000-d000-000000000000  Microsoft sha1-based
> +00000000-0000-6000-d000-000000000000  Microsoft unknown
> +00000000-0000-0000-f000-000000000000  other     nil
> +00000000-0000-1000-f000-000000000000  other     time based
> +00000000-0000-2000-f000-000000000000  other     DCE
> +00000000-0000-3000-f000-000000000000  other     name-based
> +00000000-0000-4000-f000-000000000000  other     random
> +00000000-0000-5000-f000-000000000000  other     sha1-based
> +00000000-0000-6000-f000-000000000000  other     unknown
> +9b274c46-544a-11e7-a972-00037f500001  DCE       time based
> 2017-06-18 17:21:46,544647+0000 +ffffffff-ffff-1fff-8fff-ffffffffffff
>  DCE       time based 5236-03-31 21:21:00,684697+0000 +invalid-input 
>                        invalid   invalid    invalid +return value: 0
> diff --git a/tests/ts/uuid/uuidparse b/tests/ts/uuid/uuidparse
> new file mode 100755
> index 000000000..229994f6f
> --- /dev/null
> +++ b/tests/ts/uuid/uuidparse
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +
> +# This file is part of util-linux.
> +#
> +# This file is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published
> by +# the Free Software Foundation; either version 2 of the License,
> or +# (at your option) any later version.
> +#
> +# This file is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +
> +TS_TOPDIR="${0%/*}/../.."
> +TS_DESC="uuidparse"
> +export TZ=GMT
> +
> +. $TS_TOPDIR/functions.sh
> +ts_init "$*"
> +
> +ts_check_test_command "$TS_CMD_UUIDPARSE"
> +
> +echo '00000000-0000-0000-0000-000000000000
> +
> +00000000-0000-1000-0000-000000000000
> +00000000-0000-2000-0000-000000000000
> +00000000-0000-3000-0000-000000000000
> +00000000-0000-4000-0000-000000000000
> +00000000-0000-5000-0000-000000000000
> +00000000-0000-6000-0000-000000000000
> +
> +00000000-0000-0000-8000-000000000000
> +00000000-0000-1000-8000-000000000000
> +00000000-0000-2000-8000-000000000000
> +00000000-0000-3000-8000-000000000000
> +00000000-0000-4000-8000-000000000000
> +00000000-0000-5000-8000-000000000000
> +00000000-0000-6000-8000-000000000000
> +
> +00000000-0000-0000-d000-000000000000
> +00000000-0000-1000-d000-000000000000
> +00000000-0000-2000-d000-000000000000
> +00000000-0000-3000-d000-000000000000
> +00000000-0000-4000-d000-000000000000
> +00000000-0000-5000-d000-000000000000
> +00000000-0000-6000-d000-000000000000
> +
> +00000000-0000-0000-f000-000000000000
> +00000000-0000-1000-f000-000000000000
> +00000000-0000-2000-f000-000000000000
> +00000000-0000-3000-f000-000000000000
> +00000000-0000-4000-f000-000000000000
> +00000000-0000-5000-f000-000000000000
> +00000000-0000-6000-f000-000000000000
> +
> +9b274c46-544a-11e7-a972-00037f500001
> +ffffffff-ffff-1fff-8fff-ffffffffffff
> +
> +invalid-input' | $TS_CMD_UUIDPARSE 1>$TS_OUTPUT 2>&1
> +echo "return value: $?" >> $TS_OUTPUT
> +
> +ts_finalize
