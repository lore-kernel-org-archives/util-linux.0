Return-Path: eric.rannaud@gmail.com
MIME-Version: 1.0
In-Reply-To: <20140616140047.GL30975@x2.net.home>
References: <CA+zRj8Xs=A2sHp3DMD78u9Ak9v-xDSyZVtjB1JGJZ6Dx9t1z=w@mail.gmail.com>
	<20140616132816.GK30975@x2.net.home>
	<20140616140047.GL30975@x2.net.home>
Date: Mon, 16 Jun 2014 09:02:14 -0700
Message-ID: <CA+zRj8VZSxJ8dPYOY_wSS5zbxaue1Vy-gyCkYxfLVqA_3FjQfA@mail.gmail.com>
Subject: Re: Using findmnt in the presence of a stale NFS mount
From: Eric Rannaud <eric.rannaud@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Thanks for having a look.

I tried --types nonfs, and indeed it works. But that does mean
open-coding the don't-step-on-a-stale-nfs-mount logic a bit
everywhere.

Another solution would be to change canonicalize_path(): before
calling realpath(fs->target), it would first check if fs->target is
otherwise listed in mtab (using the comparison
strcmp(from_mtab_fs->target, fs->target), not recursively using
mnt_fs_target_match()). If found in mtab, canonicalize_path() knows
that fs->target is not a symlink and it does not need to call
realpath(fs->target), and it won't blow up.

There is no need for a command line option: canonicalize_path() can do
this all the time, it will not change its semantics. However, findmnt
would have to systematically read /proc/mounts or mtab in an
additional secondary structure, even if --fstab is specified. That
requires changing findmnt's logic quite a bit, however, as currently
it doesn't read mtab if --fstab is specified.

If you wish, I can have a crack at writing such a patch.

Thanks,
Eric


On Mon, Jun 16, 2014 at 7:00 AM, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Jun 16, 2014 at 03:28:16PM +0200, Karel Zak wrote:
>> > As it is, it is impossible to upgrade an Arch Linux install when there
>> > is a stale NFS mount anywhere on the system (and listed in fstab).
>>
>>  You can try to  exclude NFS at all by --types nonfs, but maybe we can
>>  add option --nocanonicalize. I'll try to play with that tomorrow.
>
> OK, tomorrow is now ;-) (the option added)
>
> The problem is that this is not commonly usable solution, because it
> very significantly affects the way how libmount search in fstab,
> mountinfo etc. The option disallow to reliable compare symlinks, tags etc.
>
> It would be better to have NFS specific solution, or in the
> update/install script use --types nonfs and when only if not found
> required directories try fallback solution with --nocanonicalize or
> so.
>
>     Karel
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
