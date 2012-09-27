Return-Path: lczerner@redhat.com
Date: Thu, 27 Sep 2012 11:21:18 -0400 (EDT)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Karel Zak <kzak@redhat.com>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: add new command
In-Reply-To: <20120927094256.GA18644@x2.net.home>
Message-ID: <alpine.LFD.2.00.1209271113040.31136@dhcp-187-45.bos.redhat.com>
References: <1347486555-24330-1-git-send-email-lczerner@redhat.com> <alpine.LFD.2.00.1209261546390.31136@dhcp-187-45.bos.redhat.com> <20120927094256.GA18644@x2.net.home>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810047-758399198-1348759280=:31136"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810047-758399198-1348759280=:31136
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Sep 2012, Karel Zak wrote:

> Date: Thu, 27 Sep 2012 11:42:56 +0200
> From: Karel Zak <kzak@redhat.com>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: util-linux@vger.kernel.org
> Subject: Re: [PATCH] blkdiscard: add new command
> 
> On Wed, Sep 26, 2012 at 03:47:06PM -0400, Lukáš Czerner wrote:
> > any progress here ?
> 
> ah, it seems that the bikeshed already looks like rainbow... :-)
> 
> Anyway, we already have fstrim(8). This command is the same like
> blkdiscard(8) but for filesystems. It also expects offset and length,
> it also calls an ioctl.
> 
> I think the best would be to merge both tools and maintain the same
> thing on only one place. The blkdiscard(8) command maybe only a
> symlink to fstrim(8).
> 
> It's also less invasive change:
>     4 files changed, 195 insertions(+), 36 deletions(-)
> (including man page)
> 
> See below.

Hi Karel,

TBH this is fugly :). Also what actually is the advantage of doing
this ? So we saved 50 lines of code for this ugliness and instead of
two separate binaries we have this one hybrid and symlink. I am not
sure it's worth it. Can't we just have two separate binaries ? What
is the problem with that ?

Nevertheless it you're willing to carry this weird thing I do not
really care very much as long as the blkdiscard is separate thing
and not multiplexed with some other unrelated stuff.

Also we probably need to add a warning and question. Something like.

This will destroy all data in specified range. Do you want to
proceed ?

and add --force/-f argument.

Thanks!
-Lukas


> 
>     Karel
> 
> From d091935f5d269fc789d5ac1ce86b1bb062d1f2ce Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Thu, 27 Sep 2012 11:21:35 +0200
> Subject: [PATCH] blkdiscard: new command
> 
> Add to fstrim(8) code to support new discard BLKDISCARD and
> BLKSECDISCARD ioctls for block devices.  The new command is only
> symlink to fstrim(8) as the both utils share some code and the basic
> ideas.
> 
> Based on patch from Lukas Czerner <lczerner@redhat.com>.
> 
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>  .gitignore              |    1 +
>  sys-utils/Makemodule.am |   10 +++-
>  sys-utils/blkdiscard.8  |   66 ++++++++++++++++++++
>  sys-utils/fstrim.c      |  154 ++++++++++++++++++++++++++++++++++++-----------
>  4 files changed, 195 insertions(+), 36 deletions(-)
>  create mode 100644 sys-utils/blkdiscard.8
> 
> diff --git a/.gitignore b/.gitignore
> index 5be008f..5ef1c68 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -65,6 +65,7 @@ tests/run.sh.trs
>  /addpart
>  /agetty
>  /arch
> +/blkdiscard
>  /blkid
>  /blockdev
>  /cal
> diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
> index d376f04..08226cf 100644
> --- a/sys-utils/Makemodule.am
> +++ b/sys-utils/Makemodule.am
> @@ -51,9 +51,17 @@ fsfreeze_SOURCES = sys-utils/fsfreeze.c
>  
>  sbin_PROGRAMS += fstrim
>  dist_man_MANS += sys-utils/fstrim.8
> -fstrim_SOURCES = sys-utils/fstrim.c
> +fstrim_SOURCES = sys-utils/fstrim.c lib/blkdev.c
>  fstrim_LDADD = $(LDADD) libcommon.la
>  
> +install-exec-hook-blkdiscard:
> +	cd $(DESTDIR)$(sbindir) && ln -sf fstrim blkdiscard
> +uninstall-hook-blkdiscard:
> +	rm -f $(DESTDIR)$(sbindir)/blkdiscard
> +
> +INSTALL_EXEC_HOOKS += install-exec-hook-blkdiscard
> +UNINSTALL_HOOKS += uninstall-hook-blkdiscard
> +
>  usrbin_exec_PROGRAMS += cytune
>  dist_man_MANS += sys-utils/cytune.8
>  cytune_SOURCES = sys-utils/cytune.c sys-utils/cyclades.h
> diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
> new file mode 100644
> index 0000000..fcc38f6
> --- /dev/null
> +++ b/sys-utils/blkdiscard.8
> @@ -0,0 +1,66 @@
> +.\" -*- nroff -*-
> +.TH BLKDISCARD 8 "September 2012" "util-linux" "System Administration"
> +.SH NAME
> +blkdiscard \- discard sectors on a device
> +.SH SYNOPSIS
> +.B blkdiscard
> +.RB [ \-o
> +.IR offset ]
> +.RB [ \-l
> +.IR length ]
> +.RB [ \-s ]
> +.RB [ \-v ]
> +.I device
> +
> +.SH DESCRIPTION
> +.B blkdiscard
> +is used to discard device sectors. This is useful for solid-state
> +drivers (SSDs) and thinly-provisioned storage. Unlike
> +.BR fstrim (8)
> +this command is used directly on the block device.
> +.PP
> +By default,
> +.B blkdiscard
> +will discard all blocks on the device. Options may be used to
> +modify this behavior based on range or size, as explained below.
> +.PP
> +The
> +.I device
> +argument is the pathname of the block device.
> +
> +.B WARNING: All data in the discarded region on the device will be lost!
> +
> +.SH OPTIONS
> +The \fIoffset\fR and \fIlength\fR arguments may be
> +followed by the multiplicative suffixes KiB=1024, MiB=1024*1024, and so on for
> +GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g. "K" has the same
> +meaning as "KiB") or the suffixes KB=1000, MB=1000*1000, and so on for GB, PB,
> +EB, ZB and YB.
> +.IP "\fB\-h, \-\-help\fP"
> +Print help and exit.
> +.IP "\fB\-o, \-\-offset\fP \fIoffset\fP"
> +Byte offset in the device from which to discard. Provided value will be
> +aligned to the device sector size. Default value is zero.
> +.IP "\fB\-l, \-\-length\fP \fIlength\fP"
> +Number of bytes after starting point to discard. Provided value will be
> +aligned to the device sector size. If the specified value extends past the
> +end of the device,
> +.B blkdiscard
> +will stop at the device size boundary. Default value extends to the end
> +of the device.
> +.IP "\fB\-s, \-\-secure\fP"
> +Perform secure discard. Secure discard is the same as regular discard except
> +all copies of the discarded blocks possibly created by garbage collection must
> +also be erased. It has to be supported by the device.
> +.IP "\fB\-v, \-\-verbose\fP"
> +Print aligned \fIoffset\fR and \fIlength\fR arguments.
> +
> +.SH AUTHOR
> +.nf
> +Lukas Czerner <lczerner@redhat.com>
> +.fi
> +.SH SEE ALSO
> +.BR fstrim (8)
> +.SH AVAILABILITY
> +The blkdiscard command is part of the util-linux package and is available
> +from ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
> diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
> index 332601d..cfe2770 100644
> --- a/sys-utils/fstrim.c
> +++ b/sys-utils/fstrim.c
> @@ -1,7 +1,7 @@
>  /*
>   * fstrim.c -- discard the part (or whole) of mounted filesystem.
>   *
> - * Copyright (C) 2010 Red Hat, Inc. All rights reserved.
> + * Copyright (C) 2010,2012 Red Hat, Inc. All rights reserved.
>   * Written by Lukas Czerner <lczerner@redhat.com>
>   *            Karel Zak <kzak@redhat.com>
>   *
> @@ -23,7 +23,6 @@
>   * online (mounted). You can specify range (start and length) to be
>   * discarded, or simply discard whole filesystem.
>   */
> -
>  #include <string.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -41,6 +40,7 @@
>  #include "strutils.h"
>  #include "c.h"
>  #include "closestream.h"
> +#include "blkdev.h"
>  
>  #ifndef FITRIM
>  struct fstrim_range {
> @@ -48,34 +48,107 @@ struct fstrim_range {
>  	uint64_t len;
>  	uint64_t minlen;
>  };
> -#define FITRIM		_IOWR('X', 121, struct fstrim_range)
> +# define FITRIM		_IOWR('X', 121, struct fstrim_range)
> +#endif
> +
> +#ifndef BLKDISCARD
> +# define BLKDISCARD	_IO(0x12,119)
> +#endif
> +#ifndef BLKSECDISCARD
> +# define BLKSECDISCARD	_IO(0x12,125)
>  #endif
>  
> +static int is_blk = 0;
> +
>  static void __attribute__((__noreturn__)) usage(FILE *out)
>  {
>  	fputs(USAGE_HEADER, out);
> -	fprintf(out,
> -	      _(" %s [options] <mount point>\n"), program_invocation_short_name);
> -	fputs(USAGE_OPTIONS, out);
> +
> +	if (is_blk) {
> +		fprintf(out, _(" %s [options] <device>\n"), program_invocation_short_name);
> +		fputs(USAGE_OPTIONS, out);
> +		fputs(_(" -s, --secure        perform secure discard\n"), out);
> +	} else {
> +		fprintf(out, _(" %s [options] <mountpoint>\n"), program_invocation_short_name);
> +		fputs(USAGE_OPTIONS, out);
> +		fputs(_(" -m, --minimum <num> minimum extent length to discard\n"), out);
> +	}
>  	fputs(_(" -o, --offset <num>  offset in bytes to discard from\n"
>  		" -l, --length <num>  length of bytes to discard from the offset\n"
> -		" -m, --minimum <num> minimum extent length to discard\n"
>  		" -v, --verbose       print number of discarded bytes\n"), out);
>  	fputs(USAGE_SEPARATOR, out);
>  	fputs(USAGE_HELP, out);
>  	fputs(USAGE_VERSION, out);
> -	fprintf(out, USAGE_MAN_TAIL("fstrim(8)"));
> +	fprintf(out, USAGE_MAN_TAIL(is_blk ? "blkdiscard(8)" : "fstrim(8)"));
>  	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
>  }
>  
> -int main(int argc, char **argv)
> +static void do_fstrim(const char *path, uint64_t off, uint64_t len, uint64_t minlen)
>  {
> -	char *path;
> -	int c, fd, verbose = 0;
> +	int fd;
> +	struct stat sb;
>  	struct fstrim_range range;
> +
> +	range.start = off;
> +	range.len = len;
> +	range.minlen = minlen;
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		err(EXIT_FAILURE, _("cannot open %s"), path);
> +	if (fstat(fd, &sb) == -1)
> +		err(EXIT_FAILURE, _("stat failed %s"), path);
> +	if (!S_ISDIR(sb.st_mode))
> +		errx(EXIT_FAILURE, _("%s: not a directory"), path);
> +	if (ioctl(fd, FITRIM, &range))
> +		err(EXIT_FAILURE, _("%s: FITRIM ioctl failed"), path);
> +	close(fd);
> +}
> +
> +static void do_blkdiscard(const char *path, uint64_t off, uint64_t len, int sec)
> +{
> +	int fd, secsize;
>  	struct stat sb;
> +	uint64_t blksize, range[2], end;
>  
> -	static const struct option longopts[] = {
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0)
> +		err(EXIT_FAILURE, _("cannot open %s"), path);
> +	if (fstat(fd, &sb) == -1)
> +		err(EXIT_FAILURE, _("stat failed %s"), path);
> +	if (!S_ISBLK(sb.st_mode))
> +		errx(EXIT_FAILURE, _("%s: not a block device"), path);
> +	if (blkdev_get_size(fd, (unsigned long long *) &blksize) != 0)
> +		err(EXIT_FAILURE, _("%s: failed to get device size"), path);
> +	if (blkdev_get_sector_size(fd, &secsize) != 0)
> +		err(EXIT_FAILURE, _("%s: failed to get sector size"), path);
> +
> +	/* align range to the sector size */
> +	range[0] = (off + secsize - 1) & ~(secsize - 1);
> +	range[1] = len & ~(secsize - 1);
> +
> +	/* is the range end behind the end of the device ?*/
> +	end = range[0] + range[1];
> +	if (end < range[0] || end > blksize)
> +		range[1] = blksize - range[0];
> +
> +	if (sec) {
> +		if (ioctl(fd, BLKSECDISCARD, &range))
> +			err(EXIT_FAILURE, _("%s: BLKSECDISCARD ioctl failed"), path);
> +	} else {
> +		if (ioctl(fd, BLKDISCARD, &range))
> +			err(EXIT_FAILURE, _("%s: BLKDISCARD ioctl failed"), path);
> +	}
> +	close(fd);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	char *path;
> +	int c, verbose = 0, secure = 0;
> +	uint64_t len = UINT64_MAX, off = 0, minlen = 0;
> +
> +	static const struct option fs_longopts[] = {
>  	    { "help",      0, 0, 'h' },
>  	    { "version",   0, 0, 'V' },
>  	    { "offset",    1, 0, 'o' },
> @@ -84,16 +157,32 @@ int main(int argc, char **argv)
>  	    { "verbose",   0, 0, 'v' },
>  	    { NULL,        0, 0, 0 }
>  	};
> +	static const struct option blk_longopts[] = {
> +	    { "help",      0, 0, 'h' },
> +	    { "version",   0, 0, 'V' },
> +	    { "offset",    1, 0, 'o' },
> +	    { "length",    1, 0, 'l' },
> +	    { "secure",    0, 0, 's' },
> +	    { "verbose",   0, 0, 'v' },
> +	    { NULL,        0, 0, 0 }
> +	};
>  
>  	setlocale(LC_ALL, "");
>  	bindtextdomain(PACKAGE, LOCALEDIR);
>  	textdomain(PACKAGE);
>  	atexit(close_stdout);
>  
> -	memset(&range, 0, sizeof(range));
> -	range.len = ULLONG_MAX;
> +	if (strcmp(program_invocation_short_name, "blkdiscard") == 0)
> +		is_blk = 1;
> +
> +	do {
> +		if (is_blk)
> +			c = getopt_long(argc, argv, "hVo:l:sv", blk_longopts, NULL);
> +		else
> +			c = getopt_long(argc, argv, "hVo:l:m:v", fs_longopts, NULL);
> +		if (c == -1)
> +			break;
>  
> -	while ((c = getopt_long(argc, argv, "hVo:l:m:v", longopts, NULL)) != -1) {
>  		switch(c) {
>  		case 'h':
>  			usage(stdout);
> @@ -102,17 +191,20 @@ int main(int argc, char **argv)
>  			printf(UTIL_LINUX_VERSION);
>  			return EXIT_SUCCESS;
>  		case 'l':
> -			range.len = strtosize_or_err(optarg,
> +			len = strtosize_or_err(optarg,
>  					_("failed to parse length"));
>  			break;
>  		case 'o':
> -			range.start = strtosize_or_err(optarg,
> +			off = strtosize_or_err(optarg,
>  					_("failed to parse offset"));
>  			break;
>  		case 'm':
> -			range.minlen = strtosize_or_err(optarg,
> +			minlen = strtosize_or_err(optarg,
>  					_("failed to parse minimum extent length"));
>  			break;
> +		case 's':
> +			secure = 1;
> +			break;
>  		case 'v':
>  			verbose = 1;
>  			break;
> @@ -120,11 +212,11 @@ int main(int argc, char **argv)
>  			usage(stderr);
>  			break;
>  		}
> -	}
> +	} while (1);
>  
>  	if (optind == argc)
> -		errx(EXIT_FAILURE, _("no mountpoint specified."));
> -
> +		errx(EXIT_FAILURE, is_blk ? _("no device specified.") :
> +					    _("no mountpoint specified"));
>  	path = argv[optind++];
>  
>  	if (optind != argc) {
> @@ -132,22 +224,14 @@ int main(int argc, char **argv)
>  		usage(stderr);
>  	}
>  
> -	if (stat(path, &sb) == -1)
> -		err(EXIT_FAILURE, _("stat failed %s"), path);
> -	if (!S_ISDIR(sb.st_mode))
> -		errx(EXIT_FAILURE, _("%s: not a directory"), path);
> -
> -	fd = open(path, O_RDONLY);
> -	if (fd < 0)
> -		err(EXIT_FAILURE, _("cannot open %s"), path);
> -
> -	if (ioctl(fd, FITRIM, &range))
> -		err(EXIT_FAILURE, _("%s: FITRIM ioctl failed"), path);
> +	if (is_blk)
> +		do_blkdiscard(path, off, len, secure);
> +	else
> +		do_fstrim(path, off, len, minlen);
>  
>  	if (verbose)
>  		/* TRANSLATORS: The standard value here is a very large number. */
> -		printf(_("%s: %" PRIu64 " bytes were trimmed\n"),
> -						path, (uint64_t) range.len);
> -	close(fd);
> +		printf(_("%s: %" PRIu64 " bytes were trimmed\n"), path, len);
> +
>  	return EXIT_SUCCESS;
>  }
> 
---1463810047-758399198-1348759280=:31136--
