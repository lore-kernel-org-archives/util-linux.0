Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f45.google.com ([74.125.83.45]:35529 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab3BCTvS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Feb 2013 14:51:18 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so3036756eek.32
        for <util-linux@vger.kernel.org>; Sun, 03 Feb 2013 11:51:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmU3y86HMBubpz1iu9E4iGMxLXE-u6em3CwO5iEjgmN4eA@mail.gmail.com>
References: <CAOMFOmWOvh2TAp5a61esH=2Kzgt_YkQ5dHvQOz=_k53zzx20Xg@mail.gmail.com>
	<20130203152809.GA17182@x2.net.home>
	<CAOMFOmU3y86HMBubpz1iu9E4iGMxLXE-u6em3CwO5iEjgmN4eA@mail.gmail.com>
Date: Sun, 3 Feb 2013 11:51:16 -0800
Message-ID: <CAOMFOmUs0ra0JNyy_RPHu4L+j4_3-+ZmUGeYM=O8=s5TTAOXrw@mail.gmail.com>
Subject: Re: Why "--fake" and "--no-canonicalize" started requiring root in 2.22?
From: Anatol Pomozov <anatol.pomozov@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

On Sun, Feb 3, 2013 at 9:06 AM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> Hi,
>
> Hm.. I am puzzled then. I clearly see that "mount --fake" works on
> ubuntu precise with linux-util package version 2.20.1. I checked
> ubuntu-specific changes http://packages.ubuntu.com/precise/util-linux
> and I do not see anything related to the flags handling. But your
> change be9adec40ffc8 is merged to project in v2.17....
>
>
> The only diff between 2.20 vs 2.22 is expression for "restricted":
>
> v2.20
>                 /* if we're really root and aren't running setuid */
>                 if (((uid_t)0 == ruid) && (ruid == euid)) {
>                         restricted = 0;
>                 }
>
> v2.22
> cxt->restricted = (uid_t) 0 == ruid && ruid == euid ? 0 : 1;
>
> My first though was that something wrong with operators precedence in
> v2.22, but no - expressions evaluated the same way as in v2.20
>
>
> I keep trying to understand the behavior change between Ubuntu
> (v2.20.1) and Arch (v2.22)

It seems that the difference is how "mount" processes keys (such as
"--fake") when directory parameter is absent.

When I run "mount --fake 1" both v2.20 and v2.22 fail with "only root
can do that" error.

But when I run "mount --fake" only v2.22 fails. I run both programs
with strace and see that pair of call "getuid(), geteuid()" is called
on v2.22 only. It looks like in v2.20 "--fake" flag is processed (and
filtered out) only when directory is present, and in v2.22 processes
before checking directory parameter.

If this is the only difference then it is better to fix libfuse code.
libfuse build system calls "mount --fake --no-canonicalize" to check
if "mount" version is recent enough. But imho better way is to call
"mount --version" and compare versions explicitly.

It is related discussion in fuse-devel maillist
http://sourceforge.net/mailarchive/forum.php?thread_name=CAOMFOmUcpG2Z8puzPuRhfykF48tjb43BKt07%2BP-4JaY8-knHXg%40mail.gmail.com&forum_name=fuse-devel


>
> On Sun, Feb 3, 2013 at 7:28 AM, Karel Zak <kzak@redhat.com> wrote:
>> On Sun, Feb 03, 2013 at 01:39:50AM -0800, Anatol Pomozov wrote:
>>> I am trying to compile and use libfuse. Libfuse utilises 'mount' and
>>> 'umount' tools. One of few things it uses are "--fake" and
>>> "--no-canonicalize" command options run as regular user. It worked
>>> fine with previous versions of util-linux (2.20 from Ubuntu Precise).
>>> But in the latest version (2.22 from Arch) it fails to run as a
>>> regular user:
>>
>> The original (now deprecated) mount code:
>>
>> # git blame --date=short -L 2572,+11 mount-deprecated/mount.c
>>
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2572)              if (restricted &&
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2573)                  (types || options || readwrite || nomtab || mount_all ||
>> be9adec4 mount/mount.c (Karel Zak 2009-12-17 2574)                   nocanonicalize || fake || mounttype ||
>> be9adec4 mount/mount.c (Karel Zak 2009-12-17 2575)                   (argc + specseen) != 1)) {
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2576)
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2577)                      if (ruid == 0 && euid != 0)
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2578)                              /* user is root, but setuid to non-root */
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2579)                              die (EX_USAGE, _("mount: only root can do that "
>> b7481d6f mount/mount.c (Karel Zak 2010-06-14 2580)                                      "(effective UID is %u)"), euid);
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2581)
>> 3d1b35b6 mount/mount.c (Karel Zak 2009-09-30 2582)                      die (EX_USAGE, _("mount: only root can do that"));
>>
>> for example:
>>
>> commit be9adec40ffc81b28cbb051d0aa1f46f596f7b81
>> Author: Karel Zak <kzak@redhat.com>
>> Date:   Thu Dec 17 12:27:16 2009 +0100
>>
>>     mount: disable --no-canonicalize for non-root users
>>
>>     Signed-off-by: Karel Zak <kzak@redhat.com>
>>
>>
>>> $  mount --version
>>> mount from util-linux 2.22.2 (libmount 2.22.0: debug)
>>> $  mount --fake
>>> mount: only root can use "--fake" option
>>
>> fake was always disable for non root users
>>
>>> $  mount --no-canonicalize
>>> mount: only root can use "--no-canonicalize" option
>>>
>>> Should it be removed from the list of "restricted" options like it
>>> happened with other options recently? This would restore the same
>>> behavior that "mount" had before.
>>
>> I don't see a change...
>>
>>     Karel
>>
>> --
>>  Karel Zak  <kzak@redhat.com>
>>  http://karelzak.blogspot.com
