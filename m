Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44850 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754723AbdL2MCq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 Dec 2017 07:02:46 -0500
Date: Fri, 29 Dec 2017 13:02:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <rain@vojtechvladyka.cz>
Subject: Re: fsck command line API
Message-ID: <20171229120242.lnp7dsp5wuyqrasr@ws.net.home>
References: <20171227101429.bisgfv5wumxcqiqp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171227101429.bisgfv5wumxcqiqp@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 27, 2017 at 11:14:29AM +0100, Pali Rohár wrote:
> Vojtěch Vladyka is working on a new fsck tool udffsck for UDF filesystem
> [1] and I would like to know if there is a some standardized command line
> API for fsck tools, so s new udffsck would be compatible.
> 
> In util-linux repository there is some generic wrapper fsck which starts
> correct filesystem fsck tool... And probably systemd has own wrapper
> which do similar thing.

The systemd calls fsck wrapper from util-linux:
https://github.com/systemd/systemd/blob/master/src/fsck/fsck.c#L446

> Are there already defined some set of command line arguments which are
> expected for fsck tools? Or exit status values from those tools?

We have no API. The solution is to call fsck wrapper with proper
command line.

    fsck [options] [--] [fs-specific-options]

The exit code returned when multiple filesystems are checked is the
bit-wise OR of the exit codes for each filesystem that is checked. The
man page contains some return codes. It's probably good idea to use
the same codes in the fs specific fsck tools.

See man fsck:

    FILESYSTEM SPECIFIC OPTIONS

       Options which are not understood by fsck are passed to the
       filesystem-specific checker!

       These options must not take arguments, as there is no way for
       fsck to be able to properly guess which options take arguments
       and which don't.

       Options and arguments which follow the -- are treated as
       filesystem-specific options to be passed to the
       filesystem-specific checker.

       Please  note  that  fsck  is not designed to pass arbitrarily
       complicated options to filesystem-specific checkers.  If you're
       doing something complicated, please just execute the
       filesystem-specific checker directly.  If you pass fsck some
       horribly complicated options and arguments, and it doesn't do
       what you expect, don't bother reporting it  as  a  bug.  You're
       almost certainly doing something that you shouldn't be doing
       with fsck.  Options to different filesystem-specific fsck's are
       not standardized.



The fsck wrapper has been originally designed by Ted as well as
fsck.extN tools. So, my suggestion is to follow fsck.extN to keep
things compatible as much as possible :-)

> Also, lot of filesystems store information if last usage/mount was
> correctly synchronized and unmounted. E.g. FAT has dirty bit, ext4 has
> journal clean state, UDF has integrity field... and in most cases when
> fsck is started at boot time it make sense to skip fsck data check
> routine if filesystem state is clean (last time properly unmounted). Is
> there some command line API to tell fsck tool if it should do full disk
> check (including data) or do it conditionally if filesystem is in dirty
> state?

The fsck wrapper does not care. It's fsck.<type> responsibility to do
good things by default and if the default setting is not possible
(safe, etc.) then ask for manual execution without the wrapper:

    fsck.foo: failed to fix foo; use "fsck.foo --something"

I think many fsck.<type> tools use options like -a (or -p), -y, -f and
-C. The -f (force) and -C (progress bar) is supported by systemd too.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
