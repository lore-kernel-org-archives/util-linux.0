Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdGQKEO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jul 2017 06:04:14 -0400
Date: Mon, 17 Jul 2017 12:04:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] pull: five mutually unrelated changes
Message-ID: <20170717100406.nv7ur6j2a3gbq4k6@ws.net.home>
References: <20170715212046.1655-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170715212046.1655-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 15, 2017 at 10:20:41PM +0100, Sami Kerola wrote:
>  Documentation/boilerplate.c   | 17 ++++++++--------
>  Documentation/deprecated.txt  |  5 -----
>  bash-completion/Makemodule.am |  3 +++
>  bash-completion/blkid         |  2 +-
>  bash-completion/fdisk         |  2 +-
>  bash-completion/fincore       |  2 +-
>  bash-completion/findmnt       |  2 +-
>  bash-completion/losetup       |  2 +-
>  bash-completion/lsipc         |  2 +-
>  bash-completion/lslocks       |  2 +-
>  bash-completion/lsmem         |  2 +-
>  bash-completion/partx         |  2 +-
>  bash-completion/prlimit       |  2 +-
>  bash-completion/sfdisk        |  2 +-
>  bash-completion/swapon        |  2 +-
>  bash-completion/uuidparse     | 37 +++++++++++++++++++++++++++++++++++
>  bash-completion/wdctl         |  2 +-
>  bash-completion/zramctl       |  2 +-
>  configure.ac                  |  9 +--------
>  sys-utils/ldattach.c          | 10 +++++++---
>  term-utils/Makemodule.am      |  6 ------
>  term-utils/reset              | 19 ------------------
>  term-utils/reset.1            | 45 -------------------------------------------
>  23 files changed, 71 insertions(+), 108 deletions(-)
>  create mode 100644 bash-completion/uuidparse
>  delete mode 100755 term-utils/reset
>  delete mode 100644 term-utils/reset.1

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
