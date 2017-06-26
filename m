Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdFZNEd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 09:04:33 -0400
Received: from [10.0.0.104] ([146.52.24.88]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhQxO-1d47371hB4-00MaZW for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 15:04:31 +0200
Subject: Re: [PATCH 00/13] usage cleanup part 1
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Message-ID: <86e4396d-ee18-c049-a660-b03f6db951a5@gmx.de>
Date: Mon, 26 Jun 2017 15:04:30 +0200
MIME-Version: 1.0
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/22/2017 04:37 AM, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
> 
> This is pull request #467 on github
> https://github.com/karelzak/util-linux/pull/467

> The major goal is to avoid printing usage/help messages on stderr.
> 
> This is the preparing first part of a bigger patch-set. There are
> some minor bug fixes and finally we add --help options to all our
> commands (just 5 commands were missing it).
> 
> The next completing patch-set (part 2) will be more invasive but
> even more trivial.

Thanks for merging.

FYI I've PR'ed the second part on github only because it's almost
trivial but invasive.
    https://github.com/karelzak/util-linux/pull/471

> Ruediger Meier (13):
>    uuidd: remove unused define
>    misc: remove superfluous null pointer checks for optarg
>    misc: fix some broken exit codes
>    blkid: use errtryhelp instead of errtryh
>    dmesg: do not accept any non-option arguments
>    setarch: print usage error if no argument given
>    setarch: use errtryhelp()
>    fsck: add --help and --version
>    login: add --help and --version
>    whereis: add --help and --version
>    more: add --help and --version
>    mkfs.cramfs: add --help and --version
>    misc: no more errtryh()
> 
>   disk-utils/fsck.8        |  6 ++++++
>   disk-utils/fsck.c        | 29 +++++++++++++++++++++--------
>   disk-utils/fsck.cramfs.c |  2 +-
>   disk-utils/mkfs.cramfs.8 |  8 ++++----
>   disk-utils/mkfs.cramfs.c | 35 ++++++++++++++++++++++++-----------
>   include/c.h              |  6 ------
>   login-utils/chsh.c       |  2 --
>   login-utils/login.1      |  5 ++++-
>   login-utils/login.c      | 28 ++++++++++++++++++++++------
>   login-utils/lslogins.c   | 15 ++++++---------
>   misc-utils/blkid.c       |  8 ++++----
>   misc-utils/findfs.c      |  4 ++--
>   misc-utils/test_uuidd.c  | 25 ++++++++++++++-----------
>   misc-utils/uuidd.c       |  6 ------
>   misc-utils/whereis.1     |  6 ++++++
>   misc-utils/whereis.c     | 48 +++++++++++++++++++++++++++++++++++-------------
>   sys-utils/dmesg.c        |  4 +---
>   sys-utils/setarch.c      | 22 ++++++----------------
>   text-utils/hexdump.c     |  2 +-
>   text-utils/more.1        |  6 ++++++
>   text-utils/more.c        | 29 ++++++++++++++++++++++-------
>   21 files changed, 185 insertions(+), 111 deletions(-)
> 
