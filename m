Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47648 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471Ab2B1Qsm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:48:42 -0500
Received: by vbbff1 with SMTP id ff1so2000205vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:48:42 -0800 (PST)
Date: Tue, 28 Feb 2012 11:48:40 -0500
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/13] Initial import of sulogin
Message-ID: <20120228164840.GH21406@rampage>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 28, 2012 at 11:45:08AM -0500, Dave Reisner wrote:
> This is an initial stab at importing sulogin from sysvinit and making it a bit
> more universal. I've removed the distro specific code and brought the rest of
> it more in line with the style of the remainder of the repo. I've also added
> internationalization and cleaned up the manpage.

Err, forgot... these patches live in a repo below on the 'sulogin'
branch:

  git://code.falconindy.com/util-linux.git

> Dave Reisner (13):
>   fstab.5: fix misspelling of deprecated
>   sulogin: initial import from sysvinit
>   sulogin.8: refactor manpage
>   sulogin: whitespace fixes
>   sulogin: replace older signal() with sigaction()
>   sulogin: remove CHECK_{DES,MD5} defines
>   sulogin: remove USE_ONELINE and SANE_TIO defines
>   sulogin: use size_t for iterator to avoid cast
>   sulogin: get rid of calls to /bin/sash
>   sulogin: use pathnames.h for file locations
>   sulogin: header/include cleanup
>   sulogin: use a more standard usage output
>   sulogin: add i18n strings
> 
>  login-utils/Makefile.am |    6 +-
>  login-utils/sulogin.8   |   60 +++++
>  login-utils/sulogin.c   |  556 +++++++++++++++++++++++++++++++++++++++++++++++
>  mount/fstab.5           |    2 +-
>  4 files changed, 622 insertions(+), 2 deletions(-)
>  create mode 100644 login-utils/sulogin.8
>  create mode 100644 login-utils/sulogin.c
> 
> -- 
> 1.7.9.2
> 
