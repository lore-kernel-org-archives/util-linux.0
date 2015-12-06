Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33362 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbbLFKWR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 Dec 2015 05:22:17 -0500
Received: by vkca188 with SMTP id a188so88775615vkc.0
        for <util-linux@vger.kernel.org>; Sun, 06 Dec 2015 02:22:16 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20151206042923.GA6570@k3>
References: <20151206042923.GA6570@k3>
Date: Sun, 6 Dec 2015 10:22:16 +0000
Message-ID: <CAG27Bk1=y8+Dfyd19L1thfiaXBy6pvRxMV10EY=GeY_W+aqZXQ@mail.gmail.com>
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
From: Sami Kerola <kerolasa@iki.fi>
To: David Wilson <dw@botanicus.net>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 December 2015 at 04:29, David Wilson <dw@botanicus.net> wrote:
> This is just shorthand for an increasingly necessary yet cumbersome and
> error-prone "grep -v" pipe. The alternative was to extend -t to accept
> "nopseudofs", but that is tougher on the fingers.
> ---
>  sys-utils/mount.8 |  4 ++++
>  sys-utils/mount.c | 17 +++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
> index 004a513..311b514 100644
> --- a/sys-utils/mount.8
> +++ b/sys-utils/mount.8
> @@ -663,6 +663,10 @@ sections.
>  .RE
>
>  .TP
> +.BR \-P , " \-\-no\-pseudofs"
> +Inhibit listing of pseudo filesystem mounts. Only mounts backed by a network
> +location or block device are displayed.
> +.TP
>  .BR \-R , " \-\-rbind"
>  Remount a subtree and all possible submounts somewhere else (so that its
>  contents are available in both places).  See above.
> diff --git a/sys-utils/mount.c b/sys-utils/mount.c
> index 73f9d0b..17dba9e 100644
> --- a/sys-utils/mount.c
> +++ b/sys-utils/mount.c
> @@ -120,7 +120,8 @@ static void safe_fputs(const char *data)
>         }
>  }
>
> -static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
> +static void print_all(struct libmnt_context *cxt, char *pattern,
> +                     int show_label, int no_pseudofs)
>  {
>         struct libmnt_table *tb;
>         struct libmnt_iter *itr = NULL;
> @@ -147,6 +148,9 @@ static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
>
>                 if (!mnt_fs_is_pseudofs(fs))
>                         xsrc = mnt_pretty_path(src, cache);
> +               else if (no_pseudofs)
> +                       continue;
> +
>                 printf ("%s on ", xsrc ? xsrc : src);
>                 safe_fputs(mnt_fs_get_target(fs));
>
> @@ -740,6 +744,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>         fprintf(out, _(
>         " -o, --options <list>    comma-separated list of mount options\n"
>         " -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"
> +       " -P, --no-pseudofs       inhibit listing of pseudo filesystems\n"
>         " -r, --read-only         mount the filesystem read-only (same as -o ro)\n"
>         " -t, --types <list>      limit the set of filesystem types\n"));
>         fprintf(out, _(
> @@ -792,6 +797,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>  int main(int argc, char **argv)
>  {
>         int c, rc = MOUNT_EX_SUCCESS, all = 0, show_labels = 0;
> +       int no_pseudofs = 0;
>         struct libmnt_context *cxt;
>         struct libmnt_table *fstab = NULL;
>         char *srcbuf = NULL;
> @@ -842,6 +848,7 @@ int main(int argc, char **argv)
>                 { "make-rprivate", 0, 0, MOUNT_OPT_RPRIVATE },
>                 { "make-runbindable", 0, 0, MOUNT_OPT_RUNBINDABLE },
>                 { "no-canonicalize", 0, 0, 'c' },
> +               { "no-pseudofs", 0, 0, 'P' },

Hi David,

I doubt this is common enough case to assign short option.  How about
long-only option, see MOUNT_OPT_RUNBINDABLE for an example how to make
that work.


>                 { "internal-only", 0, 0, 'i' },
>                 { "show-labels", 0, 0, 'l' },
>                 { "target", 1, 0, MOUNT_OPT_TARGET },
> @@ -869,12 +876,12 @@ int main(int argc, char **argv)
>
>         mnt_context_set_tables_errcb(cxt, table_parser_errcb);
>
> -       while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:rRsU:vVwt:T:",
> +       while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:PrRsU:vVwt:T:",
>                                         longopts, NULL)) != -1) {
>
>                 /* only few options are allowed for non-root users */
>                 if (mnt_context_is_restricted(cxt) &&
> -                   !strchr("hlLUVvrist", c) &&
> +                   !strchr("hlLUVvPrist", c) &&
>                     c != MOUNT_OPT_TARGET &&
>                     c != MOUNT_OPT_SOURCE)
>                         exit_non_root(option_to_longopt(c, longopts));
> @@ -939,6 +946,8 @@ int main(int argc, char **argv)
>                 case 'l':
>                         show_labels = 1;
>                         break;
> +               case 'P':
> +                       no_pseudofs = 1;
>                 case 't':
>                         types = optarg;
>                         break;
> @@ -1021,7 +1030,7 @@ int main(int argc, char **argv)
>             !all) {
>                 if (oper || mnt_context_get_options(cxt))
>                         usage(stderr);
> -               print_all(cxt, types, show_labels);
> +               print_all(cxt, types, show_labels, no_pseudofs);
>                 goto done;
>         }
>
> --
> 2.1.4
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Sami Kerola
http://www.iki.fi/kerolasa/
