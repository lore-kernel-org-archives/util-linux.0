Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754270AbdDDMyO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 4 Apr 2017 08:54:14 -0400
Date: Tue, 4 Apr 2017 14:54:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: pull: tailf: remove deprecated utility
Message-ID: <20170404125405.bupxnyqjr7ja6f2h@ws.net.home>
References: <20170402155810.3839-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170402155810.3839-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 02, 2017 at 04:58:10PM +0100, Sami Kerola wrote:
>  .gitignore                                         |   1 -
>  Documentation/deprecated.txt                       |   5 -
>  bash-completion/Makemodule.am                      |   3 -
>  bash-completion/tailf                              |  28 --
>  configure.ac                                       |   7 -
>  tests/commands.sh                                  |   1 -
>  tests/expected/build-sys/config-all                |   1 -
>  tests/expected/build-sys/config-all-devel          |   1 -
>  tests/expected/build-sys/config-all-non-nls        |   1 -
>  tests/expected/build-sys/config-audit              |   1 -
>  tests/expected/build-sys/config-chfnsh-libuser     |   1 -
>  tests/expected/build-sys/config-chfnsh-no-password |   1 -
>  tests/expected/build-sys/config-chfnsh-pam         |   1 -
>  tests/expected/build-sys/config-core               |   1 -
>  tests/expected/build-sys/config-devel              |   1 -
>  tests/expected/build-sys/config-devel-new-mount    |   1 -
>  tests/expected/build-sys/config-devel-non-docs     |   1 -
>  tests/expected/build-sys/config-non-libblkid       |   1 -
>  tests/expected/build-sys/config-non-libmount       |   1 -
>  tests/expected/build-sys/config-non-libs           |   1 -
>  tests/expected/build-sys/config-non-libsmartcols   |   1 -
>  tests/expected/build-sys/config-non-libuuid        |   1 -
>  tests/expected/build-sys/config-non-nls            |   1 -
>  tests/expected/build-sys/config-selinux            |   1 -
>  tests/expected/build-sys/config-slang              |   1 -
>  tests/expected/build-sys/config-static             |   1 -
>  tests/ts/tailf/simple                              |  40 ---
>  text-utils/Makemodule.am                           |   7 -
>  text-utils/tailf.1                                 |  73 -----
>  text-utils/tailf.c                                 | 295 ---------------------
>  30 files changed, 480 deletions(-)
>  delete mode 100644 bash-completion/tailf
>  delete mode 100755 tests/ts/tailf/simple
>  delete mode 100644 text-utils/tailf.1
>  delete mode 100644 text-utils/tailf.c

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
