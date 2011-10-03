Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab1JCNpa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Oct 2011 09:45:30 -0400
Date: Mon, 3 Oct 2011 15:45:26 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] more sys-utils improvements
Message-ID: <20111003134526.GG1982@nb.net.home>
References: <CAG27Bk1tpBCE4+15YnKFR6vkOsxj_mUm0v4b9gV8nFsKEM2S1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1tpBCE4+15YnKFR6vkOsxj_mUm0v4b9gV8nFsKEM2S1w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 29, 2011 at 11:00:50PM +0200, Sami Kerola wrote:
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit sys-utils-again
> 
> Sami Kerola (18):
>       docs: align fallocate.1 with howto-man-page.txt
>       flock: fix coding style
>       flock: move long_options struct to function scope
>       flock: use libc error printing facilities
>       flock: align with howto-usage-function.txt
>       flock: use function attributes
>       flock: use sysexit.h for all exit values
>       flock: use strutils.h to check numeric user input
>       lib: [strutils] add strtod_or_err() function
>       flock: simplify strtotimeval()
>       docs: restructure flock.1 manual page
>       cytune: add long options and usage()
>       cytune: check numeric user inputs
>       cytune: use libc error printing facilities
>       cytune: refactor main(), new function query_tty_stats()
>       cytune: coding style fixes
>       docs: mention long options in cytune.8
>       cytune: fix printf type warning
> 
>  include/strutils.h    |    1 +
>  lib/strutils.c        |   24 ++
>  sys-utils/Makefile.am |    3 +-
>  sys-utils/cytune.8    |  111 ++++----
>  sys-utils/cytune.c    |  733 +++++++++++++++++++++++++------------------------
>  sys-utils/fallocate.1 |   26 +-
>  sys-utils/flock.1     |  124 ++++++---
>  sys-utils/flock.c     |  538 +++++++++++++++++-------------------
>  8 files changed, 807 insertions(+), 753 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
