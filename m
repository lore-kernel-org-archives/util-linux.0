Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64121 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaGZKka (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 06:40:30 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so7062763pdj.2
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 03:40:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com>
	<2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com>
Date: Sat, 26 Jul 2014 11:40:29 +0100
Message-ID: <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to, -r/--repair
From: Sami Kerola <kerolasa@iki.fi>
To: Jaromir Capik <jcapik@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25 July 2014 16:29, Jaromir Capik <jcapik@redhat.com> wrote:

Hi Jaromir,

> It also fixes a recently introduced bug that causes
> line breakage when printing the track number.

Do you mean commit 18b1fcb9cc62f4dd26eccd1c35f612ac6db1cd9b or some other
change?  It would be nice to know details of what exactly was wrong, and
how the fix is fixing it.  The change you sent is rather long, and at
least I cannot see where is the correction.  That said splitting the
change to smaller chunks would be nice.


> diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
> index c6183f5..995e085 100644
> --- a/disk-utils/Makemodule.am
> +++ b/disk-utils/Makemodule.am
> @@ -110,6 +110,7 @@ if BUILD_FDFORMAT
>  usrsbin_exec_PROGRAMS += fdformat
>  dist_man_MANS += disk-utils/fdformat.8
>  fdformat_SOURCES = disk-utils/fdformat.c
> +fdformat_LDADD = $(LDADD) libcommon.la
>  endif
>
>  if BUILD_BLOCKDEV
> diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
> index df4153f..797f50f 100644
> --- a/disk-utils/fdformat.8
> +++ b/disk-utils/fdformat.8
> @@ -1,6 +1,6 @@
>  .\" Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
>  .\" May be distributed under the GNU General Public License
> -.TH FDFORMAT 8 "July 2011" "util-linux" "System Administration"
> +.TH FDFORMAT 8 "July 2014" "util-linux" "System Administration"
>  .SH NAME
>  fdformat \- low-level format a floppy disk
>  .SH SYNOPSIS
> @@ -45,6 +45,15 @@ autodetected earlier.  In this case, use
>  to load the disk parameters.
>  .SH OPTIONS
>  .TP
> +\fB\-f\fR, \fB\-\-from\fR \fIN\fR
> +Start at the track \fIN\fR (default is 0).
> +.TP
> +\fB\-t\fR, \fB\-\-to\fR \fIN\fR
> +Stop at the track \fIN\fR (default is 0).
> +.TP
> +\fB\-r\fR, \fB\-\-repair\fR \fIN\fR
> +Try to repair tracks failed during the verification (max \fIN\fR retries).
> +.TP
>  \fB\-n\fR, \fB\-\-no-verify\fR
>  Skip the verification that is normally performed after the formatting.
>  .TP
> diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
> index e6ae8e4..c8b2a81 100644
> --- a/disk-utils/fdformat.c
> +++ b/disk-utils/fdformat.c
> @@ -12,6 +12,7 @@
>  #include <unistd.h>
>
>  #include "c.h"
> +#include "strutils.h"
>  #include "closestream.h"
>  #include "nls.h"
>  #include "xalloc.h"
> @@ -20,74 +21,119 @@ struct floppy_struct param;
>
>  #define SECTOR_SIZE 512
>
> -static void format_disk(int ctrl)
> +
> +static void format_begin(int ctrl)
> +{
> + if (ioctl(ctrl, FDFMTBEG, NULL) < 0)
> + err(EXIT_FAILURE, "ioctl: FDFMTBEG");
> +}
> +
> +static void format_end(int ctrl)
> +{
> + if (ioctl(ctrl, FDFMTEND, NULL) < 0)
> + err(EXIT_FAILURE, "ioctl: FDFMTEND");
> +}
> +

The format_begin() and format_end() are not doing much, are they really
needed?

> +static void format_track_head(int ctrl, unsigned int track, unsigned int head)
>  {
>   struct format_descr descr;
> - unsigned int track;
> +
> + descr.track = track;
> + descr.head = head;
> + if (ioctl(ctrl, FDFMTTRK, (long) &descr) < 0)
> + err(EXIT_FAILURE, "ioctl: FDFMTTRK");
> +}
> +
> +static void seek_track_head(int ctrl, unsigned int track, unsigned int head)
> +{
> + lseek(ctrl, (track * param.head + head) * param.sect * SECTOR_SIZE, SEEK_SET);
> +}
> +

Would it be possible to more  'struct floppy_struct param;' out of the
global scope?  That would make it a bit less mysterious where param.head
came from.

> +static void format_disk(int ctrl, unsigned int track_from, unsigned int track_to)
> +{
> + unsigned int track, head;

The track & head could be replaced with

struct format_descr descr;

When the two helper variables are gone the format_track_head() turns to a
single if (ioctl...  statement, and I'd claim it is unnecessary.

>   printf(_("Formatting ... "));
>   fflush(stdout);
> - if (ioctl(ctrl, FDFMTBEG, NULL) < 0)
> - err(EXIT_FAILURE, "ioctl: FDFMTBEG");
> - for (track = 0; track < param.track; track++) {
> - descr.track = track;
> - descr.head = 0;
> - if (ioctl(ctrl, FDFMTTRK, (long) &descr) < 0)
> - err(EXIT_FAILURE, "ioctl: FDFMTTRK");
> -
> - printf("%3ud\b\b\b", track);
> - fflush(stdout);
> - if (param.head == 2) {
> - descr.head = 1;
> - if (ioctl(ctrl, FDFMTTRK, (long)&descr) < 0)
> - err(EXIT_FAILURE, "ioctl: FDFMTTRK");
> +
> + format_begin(ctrl);
> +
> + for (track = track_from; track <= track_to; track++) {
> + for (head = 0; head < param.head; head++) {
> + printf("%3u/%u\b\b\b\b\b", track, head);
> + fflush(stdout);
> + format_track_head(ctrl, track, head);
>   }
>   }
> - if (ioctl(ctrl, FDFMTEND, NULL) < 0)
> - err(EXIT_FAILURE, "ioctl: FDFMTEND");
> +
> + format_end(ctrl);
> +
>   printf(_("done\n"));
>  }
>
> -static void verify_disk(char *name)
> +static void verify_disk(int ctrl, unsigned int track_from, unsigned int track_to, int repair)
>  {
>   unsigned char *data;
> - unsigned int cyl;
> - int fd, cyl_size, count;
> + unsigned int track, head;
> + int track_size, count, retries_left;
>
> - cyl_size = param.sect * param.head * 512;
> - data = xmalloc(cyl_size);
> + track_size = param.sect * SECTOR_SIZE;
> + data = xmalloc(track_size);
>   printf(_("Verifying ... "));
>   fflush(stdout);
> - if ((fd = open(name, O_RDONLY)) < 0)
> - err(EXIT_FAILURE, _("cannot open %s"), name);
> - for (cyl = 0; cyl < param.track; cyl++) {
> - int read_bytes;
> -
> - printf("%u3d\b\b\b", cyl);
> - fflush(stdout);
> - read_bytes = read(fd, data, cyl_size);
> - if (read_bytes != cyl_size) {
> - if (read_bytes < 0)
> - perror(_("Read: "));
> - fprintf(stderr,
> - _("Problem reading cylinder %d,"
> -  " expected %d, read %d\n"),
> - cyl, cyl_size, read_bytes);
> - free(data);
> - exit(EXIT_FAILURE);
> - }
> - for (count = 0; count < cyl_size; count++)
> - if (data[count] != FD_FILL_BYTE) {
> - printf(_("bad data in cyl %d\n"
> - "Continuing ... "), cyl);
> - fflush(stdout);
> +
> + seek_track_head (ctrl, track_from, 0);
> +
> + for (track = track_from; track <= track_to; track++) {
> + for (head = 0; head < param.head; head++) {
> + int read_bytes;
> +
> + printf("%3u\b\b\b", track);
> + fflush(stdout);
> +
> + retries_left = repair;
> + do {
> + read_bytes = read(ctrl, data, track_size);
> + if (read_bytes != track_size) {
> + if (retries_left) {
> + format_begin(ctrl);
> + format_track_head(ctrl, track, head);
> + format_end(ctrl);
> + seek_track_head (ctrl, track, head);
> + retries_left--;

Will the retries work if IO error happens?  There are calls to err() all
over, so am I thinking wrong the program will exit rather than re-attempt
until retries end.

> + if (retries_left) continue;

New line & indent step missing.

> + }
> + if (read_bytes < 0)
> + perror(_("Read: "));
> + fprintf(stderr,
> + _("Problem reading track/head %u/%u,"
> +  " expected %d, read %d\n"),
> + track, head, track_size, read_bytes);
> + free(data);
> + exit(EXIT_FAILURE);
> + }
> + for (count = 0; count < track_size; count++)
> + if (data[count] != FD_FILL_BYTE) {
> + if (retries_left) {
> + format_begin(ctrl);
> + format_track_head(ctrl, track, head);
> + format_end(ctrl);
> + seek_track_head (ctrl, track, head);
> + retries_left--;
> + if (retries_left) continue;

Same as previous two comments.

> + }
> + printf(_("bad data in track/head %u/%u\n"
> + "Continuing ... "), track, head);
> + fflush(stdout);
> + break;
> + }
>   break;
> - }
> + } while (retries_left);
> + }
>   }
> +
>   free(data);
>   printf(_("done\n"));
> - if (close(fd) < 0)
> - err(EXIT_FAILURE, "close");
>  }
>
>  static void __attribute__ ((__noreturn__)) usage(FILE * out)
> @@ -96,9 +142,13 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
>   program_invocation_short_name);
>
>   fprintf(out, _("\nOptions:\n"
> -       " -n, --no-verify  disable the verification after the format\n"
> -       " -V, --version    output version information and exit\n"
> -       " -h, --help       display this help and exit\n\n"));
> +       " -f, --from <N>    start at the track N (default 0)\n"
> +       " -t, --to <N>      stop at the track N\n"
> +       " -r, --repair <N>  try to repair tracks failed during\n"
> +       "                   the verification (max N retries)\n"
> +       " -n, --no-verify   disable the verification after the format\n"
> +       " -V, --version     output version information and exit\n"
> +       " -h, --help        display this help and exit\n\n"));
>
>   exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
>  }
> @@ -108,22 +158,45 @@ int main(int argc, char **argv)
>   int ch;
>   int ctrl;
>   int verify = 1;
> + int repair = 0;
> + int track_from = 0;
> + int track_to = -1;

In floppy_struct track is unsigned int.  It would be best to not mix
types unnecessarily.

> + unsigned long arg;
>   struct stat st;
>
>   static const struct option longopts[] = {
> + {"from", required_argument, NULL, 'f'},
> + {"to", required_argument, NULL, 't'},
> + {"repair", required_argument, NULL, 'r'},
>   {"no-verify", no_argument, NULL, 'n'},
>   {"version", no_argument, NULL, 'V'},
>   {"help", no_argument, NULL, 'h'},
>   {NULL, 0, NULL, 0}
>   };
>
> +
>   setlocale(LC_ALL, "");
>   bindtextdomain(PACKAGE, LOCALEDIR);
>   textdomain(PACKAGE);
>   atexit(close_stdout);
>
> - while ((ch = getopt_long(argc, argv, "nVh", longopts, NULL)) != -1)
> + while ((ch = getopt_long(argc, argv, "f:t:r:nVh", longopts, NULL)) != -1)
>   switch (ch) {
> + case 'f':
> + arg = strtoul_or_err(optarg, _("invalid argument - from"));
> + if (arg > INT_MAX) err(EXIT_FAILURE, _("invalid argument - from"));

Use strtou32_or_err() and remove INT_MAX check.

> + track_from = arg;
> + break;
> + case 't':
> + arg = strtoul_or_err(optarg, _("invalid argument - to"));
> + if (arg > INT_MAX) err(EXIT_FAILURE, _("invalid argument - to"));
> + track_to = arg;
> + break;
> + case 'r':
> + arg = strtoul_or_err(optarg, _("invalid argument - repair"));
> + if (arg > INT_MAX) err(EXIT_FAILURE, _("invalid argument - repair"));
> + repair = arg;
> + break;
>   case 'n':
>   verify = 0;
>   break;
> @@ -149,20 +222,33 @@ int main(int argc, char **argv)
>   if (access(argv[0], W_OK) < 0)
>   err(EXIT_FAILURE, _("cannot access file %s"), argv[0]);
>
> - ctrl = open(argv[0], O_WRONLY);
> + ctrl = open(argv[0], O_RDWR);
>   if (ctrl < 0)
>   err(EXIT_FAILURE, _("cannot open %s"), argv[0]);
>   if (ioctl(ctrl, FDGETPRM, (long)&param) < 0)
>   err(EXIT_FAILURE, _("Could not determine current format type"));
>
>   printf(_("%s-sided, %d tracks, %d sec/track. Total capacity %d kB.\n"),
> -       (param.head == 2) ? _("Double") : _("Single"),
> -       param.track, param.sect, param.size >> 1);
> - format_disk(ctrl);
> - if (close_fd(ctrl) != 0)
> - err(EXIT_FAILURE, _("write failed"));
> + (param.head == 2) ? _("Double") : _("Single"),
> + param.track, param.sect, param.size >> 1);
> +
> + if (track_to == -1)
> + track_to = param.track - 1;
> +

Adding a 'user_defined_tracks' variable seems better approach, than using
contents of the variable to figure out whether it was set or not.

> + if ((unsigned int)track_from > param.track - 1)
> + err(EXIT_FAILURE, _("'from' is out of allowed range\n"));
> + if ((unsigned int)track_to > param.track - 1)
> + err(EXIT_FAILURE, _("'to' is out of allowed range\n"));
> + if (track_from > track_to)
> + err(EXIT_FAILURE, _("'from' is higher than 'to'\n"));

The err() adds new line to print out, so the messages above will print
unexpected empty line.

<nitpick>
Writing the if cases in smaller greater order makes code quicker to  read.

if (smaller_value < greater_value)
err()
</nitpick>

> +
> + format_disk(ctrl, track_from, track_to);
>
>   if (verify)
> - verify_disk(argv[0]);
> + verify_disk(ctrl, track_from, track_to, repair);
> +
> + if (close_fd(ctrl) != 0)
> + err(EXIT_FAILURE, _("close failed"));
> +
>   return EXIT_SUCCESS;
>  }


-- 
Sami Kerola
http://www.iki.fi/kerolasa/
