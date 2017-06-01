Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:55747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdFAHwq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Jun 2017 03:52:46 -0400
Received: from tenfore.site ([77.12.131.100]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBVwM-1d5un41T30-00ASUc for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 09:52:44 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] minor last minute fixes for v2.30
Date: Thu, 1 Jun 2017 09:52:43 +0200
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706010952.43726.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 June 2017, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> This is all non-critical, in doubt skip it.

I've fixed some typos via github pull request.
https://github.com/karelzak/util-linux/pull/450


> Linux User (1):
>   tests: use stdbuf when stderr and stdout is randomly ordered
>
> Ruediger Meier (5):
>   tests: grep's short option -A is more portable
>   tests: avoid diff of diffs
>   build-sys: fix library order when linking
>   tests: handle non glibc error message for fallocate
>   misc: fix some warnings
>
>  lib/Makemodule.am                      |  2 +-
>  lib/plymouth-ctrl.c                    |  3 ++-
>  libblkid/samples/Makemodule.am         |  8 ++++----
>  libfdisk/src/Makemodule.am             |  2 +-
>  libmount/src/Makemodule.am             |  2 +-
>  libsmartcols/samples/Makemodule.am     |  2 +-
>  libuuid/src/Makemodule.am              |  2 +-
>  login-utils/last.c                     |  2 +-
>  misc-utils/test_uuidd.c                | 10 +++++-----
>  sys-utils/hwclock.h                    |  1 +
>  sys-utils/prlimit.c                    |  4 ++--
>  tests/expected/misc/swaplabel          |  2 +-
>  tests/expected/rename/exit_codes       |  2 +-
>  tests/expected/utmp/utmpdump-subsecond |  7 +++----
>  tests/ts/ipcs/headers                  | 26
> +++++++++++++------------- tests/ts/misc/fallocate                | 
> 5 ++---
>  tests/ts/misc/swaplabel                |  3 ++-
>  tests/ts/rename/exit_codes             |  3 ++-
>  tests/ts/utmp/utmpdump-subsecond       |  4 +---
>  19 files changed, 45 insertions(+), 45 deletions(-)
