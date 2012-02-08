Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50054 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab2BHNnB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 8 Feb 2012 08:43:01 -0500
Date: Wed, 8 Feb 2012 14:42:58 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] various cppcheck fixes
Message-ID: <20120208134258.GD18733@x2.net.home>
References: <CAG27Bk0XYmmk4YVaJb53gBX9U7fj2y0FKVsf0zTDEX9=7HmLOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0XYmmk4YVaJb53gBX9U7fj2y0FKVsf0zTDEX9=7HmLOA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 07, 2012 at 11:35:47PM +0100, Sami Kerola wrote:
> Hello,
> 
> I suspect this pull request will not be merged before release 2.21
> which is totally fine. While waiting please review, and comment if
> something seems to be wrong or unnecessary. I suspect couple fixes
> could fall in previous category.
> 
> The following changes since commit 0892d88d1a3c155b2791a5137182ab98a22a7bac:
> 
>   tools: use gpg-aggent in ko-release-gen (2012-02-07 11:30:56 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/kerolasa/lelux-utiliteetit.git cppcheck
> 
> for you to fetch changes up to f7df0458b48078f157dadbae370d6ef431a3418c:
> 
>   lib/loopdev: remove loopdev_find_by_backing_file() [cppcheck]
> (2012-02-07 23:19:55 +0100)
> 
> ----------------------------------------------------------------
> Sami Kerola (19):
>       fsck.cramfs: close open file after usage [cppcheck]

 false positive, read the code

>       mkfs.cramfs: close open file after usage [cppcheck]
>       mkfs.cramfs: check blocksize user input [cppcheck]

 applied

>       mkswap: clean up preprocessor branching [cppcheck]

 ??? ... I don't see a problem here

>       raw: remove unnecessary return [cppcheck]

 applied

>       fdisk: enhance heads and sectors argument checking [cppcheck]

 I'll apply this after release, maybe we can add strtou32_or_err() for
 uint32_t to avoid so many x < 0 || x > UINT_MAX checks. This could be
 implemented as inline function in strutils.h based on strtoll_or_err()
 or/and we can add

    strtoll_range_or_err(str, err, min, max, default)

 or so... We use strtoxx_or_err() very often in getopt() blocks, it
 would be nice to have functions that minimize number of additional
 check.

>       fdisk: remove redundant declaration [cppcheck]

 applied

>       sfdisk: free variable which got the allocation [cppcheck]

 applied with a small change

>       hwclock: clarify operation order [cppcheck]

 not sure if this is really error

>       libblkid: clarify operation order [cppcheck]

 applied, good catch

>       libblkid: allow return value to indicate error [cppcheck]

 applied

>       libblkid: verify arroy bound before reference [cppcheck]

 applied, but it's cosmetic change as the array index is from strlen(array)

>       mount: close file descriptors before exiting [cppcheck]

 why we need to close 0, 1, 2 descriptors?

>       taskset: use appropriate variable type [cppcheck]
>       chcpu: use appropriate variable type [cppcheck]

 applied

>       lscpu: clarify calculation precedence [cppcheck]

 the current code seems correct

>       switch_root: close open file after usage [cppcheck]

 applied

>       tunelp: free allocation before exit [cppcheck]

 we don't care about free-before-exit, it usually only waste of time
 (exception are test programs for share libs and daemons).

 anyway applied with a small change, there was another bug

>       lib/loopdev: remove loopdev_find_by_backing_file() [cppcheck]

 not applied, I'd like to use the function in libmount/src/tab.c in 
 mnt_table_is_fs_mounted().

 Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
