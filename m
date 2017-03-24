Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754211AbdCXLJp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Mar 2017 07:09:45 -0400
Date: Fri, 24 Mar 2017 12:09:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] pull: tests fixes and couple blkid changes
Message-ID: <20170324110940.hvr6xkwv453o6oey@ws.net.home>
References: <20170319101045.3018-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 19, 2017 at 10:10:40AM +0000, Sami Kerola wrote:
>  lib/colors.c                    |  10 +--
>  lib/cpuset.c                    |   8 +-
>  libfdisk/samples/mkpart.c       |   8 +-
>  libmount/src/context.c          |   2 +-
>  libmount/src/lock.c             |   2 +-
>  libsmartcols/samples/fromfile.c |  34 ++++----
>  libsmartcols/samples/title.c    |   6 +-
>  libsmartcols/samples/tree.c     |  20 ++---
>  misc-utils/blkid.c              | 181 ++++++++++++++++++++--------------------
>  misc-utils/test_uuidd.c         |  10 +--
>  tests/helpers/test_byteswap.c   |   6 +-
>  tests/helpers/test_pathnames.c  |   2 +-
>  12 files changed, 144 insertions(+), 145 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
