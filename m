Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35440 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbLFMk1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 Dec 2015 07:40:27 -0500
Received: by qkek142 with SMTP id k142so21698609qke.2
        for <util-linux@vger.kernel.org>; Sun, 06 Dec 2015 04:40:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk1=y8+Dfyd19L1thfiaXBy6pvRxMV10EY=GeY_W+aqZXQ@mail.gmail.com>
References: <20151206042923.GA6570@k3> <CAG27Bk1=y8+Dfyd19L1thfiaXBy6pvRxMV10EY=GeY_W+aqZXQ@mail.gmail.com>
From: David Wilson <dw@botanicus.net>
Date: Sun, 6 Dec 2015 12:39:47 +0000
Message-ID: <CABzuZRMr8ys9ikhnn0M3ChWythxcGNdEXY0TTktyN3PPggJspA@mail.gmail.com>
Subject: Re: [PATCH] Add mount -P to hide pseudo filesystems
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 December 2015 at 10:22, Sami Kerola <kerolasa@iki.fi> wrote:
> On 6 December 2015 at 04:29, David Wilson <dw@botanicus.net> wrote:
>> This is just shorthand for an increasingly necessary yet cumbersome and
>> error-prone "grep -v" pipe. The alternative was to extend -t to accept
>> "nopseudofs", but that is tougher on the fingers.
>> ---
>>  sys-utils/mount.8 |  4 ++++
>>  sys-utils/mount.c | 17 +++++++++++++----
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
>> index 004a513..311b514 100644
>> --- a/sys-utils/mount.8
>> +++ b/sys-utils/mount.8
>> @@ -663,6 +663,10 @@ sections.
>>  .RE
>>
>>  .TP
>> +.BR \-P , " \-\-no\-pseudofs"
>> +Inhibit listing of pseudo filesystem mounts. Only mounts backed by a network
>> +location or block device are displayed.
>> +.TP
>>  .BR \-R , " \-\-rbind"
>>  Remount a subtree and all possible submounts somewhere else (so that its
>>  contents are available in both places).  See above.
>> diff --git a/sys-utils/mount.c b/sys-utils/mount.c
>> index 73f9d0b..17dba9e 100644
>> --- a/sys-utils/mount.c
>> +++ b/sys-utils/mount.c
>> @@ -120,7 +120,8 @@ static void safe_fputs(const char *data)
>>         }
>>  }
>>
>> -static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
>> +static void print_all(struct libmnt_context *cxt, char *pattern,
>> +                     int show_label, int no_pseudofs)
>>  {
>>         struct libmnt_table *tb;
>>         struct libmnt_iter *itr = NULL;
>> @@ -147,6 +148,9 @@ static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
>>
>>                 if (!mnt_fs_is_pseudofs(fs))
>>                         xsrc = mnt_pretty_path(src, cache);
>> +               else if (no_pseudofs)
>> +                       continue;
>> +
>>                 printf ("%s on ", xsrc ? xsrc : src);
>>                 safe_fputs(mnt_fs_get_target(fs));
>>
>> @@ -740,6 +744,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>>         fprintf(out, _(
>>         " -o, --options <list>    comma-separated list of mount options\n"
>>         " -O, --test-opts <list>  limit the set of filesystems (use with -a)\n"
>> +       " -P, --no-pseudofs       inhibit listing of pseudo filesystems\n"
>>         " -r, --read-only         mount the filesystem read-only (same as -o ro)\n"
>>         " -t, --types <list>      limit the set of filesystem types\n"));
>>         fprintf(out, _(
>> @@ -792,6 +797,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>>  int main(int argc, char **argv)
>>  {
>>         int c, rc = MOUNT_EX_SUCCESS, all = 0, show_labels = 0;
>> +       int no_pseudofs = 0;
>>         struct libmnt_context *cxt;
>>         struct libmnt_table *fstab = NULL;
>>         char *srcbuf = NULL;
>> @@ -842,6 +848,7 @@ int main(int argc, char **argv)
>>                 { "make-rprivate", 0, 0, MOUNT_OPT_RPRIVATE },
>>                 { "make-runbindable", 0, 0, MOUNT_OPT_RUNBINDABLE },
>>                 { "no-canonicalize", 0, 0, 'c' },
>> +               { "no-pseudofs", 0, 0, 'P' },
>
> Hi David,
>
> I doubt this is common enough case to assign short option.  How about
> long-only option, see MOUNT_OPT_RUNBINDABLE for an example how to make
> that work.

I agree, although I see little value in a patch if it becomes hard to
type. At that point copying around a wrapper script named 'mountp' is
probably easier. :)

How about some shorter spelling for --no-pseudofs, say, --real or
--plain, or maybe it just becomes neater to extend -t. How about
spellings of -t like:

"-t [no]pseudo" -> anon_inodefs,bdev,cgroup,..,tmpfs
"-t [no]net" -> cifs,smbfs,...,9p
"-t [no]plain" -> nopseudo,nonet


David

>
>
>>                 { "internal-only", 0, 0, 'i' },
>>                 { "show-labels", 0, 0, 'l' },
>>                 { "target", 1, 0, MOUNT_OPT_TARGET },
>> @@ -869,12 +876,12 @@ int main(int argc, char **argv)
>>
>>         mnt_context_set_tables_errcb(cxt, table_parser_errcb);
>>
>> -       while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:rRsU:vVwt:T:",
>> +       while ((c = getopt_long(argc, argv, "aBcfFhilL:Mno:O:PrRsU:vVwt:T:",
>>                                         longopts, NULL)) != -1) {
>>
>>                 /* only few options are allowed for non-root users */
>>                 if (mnt_context_is_restricted(cxt) &&
>> -                   !strchr("hlLUVvrist", c) &&
>> +                   !strchr("hlLUVvPrist", c) &&
>>                     c != MOUNT_OPT_TARGET &&
>>                     c != MOUNT_OPT_SOURCE)
>>                         exit_non_root(option_to_longopt(c, longopts));
>> @@ -939,6 +946,8 @@ int main(int argc, char **argv)
>>                 case 'l':
>>                         show_labels = 1;
>>                         break;
>> +               case 'P':
>> +                       no_pseudofs = 1;
>>                 case 't':
>>                         types = optarg;
>>                         break;
>> @@ -1021,7 +1030,7 @@ int main(int argc, char **argv)
>>             !all) {
>>                 if (oper || mnt_context_get_options(cxt))
>>                         usage(stderr);
>> -               print_all(cxt, types, show_labels);
>> +               print_all(cxt, types, show_labels, no_pseudofs);
>>                 goto done;
>>         }
>>
>> --
>> 2.1.4
>> --
>> To unsubscribe from this list: send the line "unsubscribe util-linux" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/
