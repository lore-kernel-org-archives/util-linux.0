Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31199 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbaFYMF7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Jun 2014 08:05:59 -0400
Date: Wed, 25 Jun 2014 14:05:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: rename fixes
Message-ID: <20140625120547.GB30418@x2.net.home>
References: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403433117-32652-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 22, 2014 at 11:31:51AM +0100, Sami Kerola wrote:
>  misc-utils/rename.c               | 124 ++++++++++++++++++++------------------
>  tests/commands.sh                 |   1 +
>  tests/expected/rename/basic       |   4 ++
>  tests/expected/rename/subdir      |  20 ++++++
>  tests/expected/rename/symlink     |   3 +
>  tests/functions.sh                |  14 +++++
>  tests/ts/build-sys/config         |   6 +-
>  tests/ts/column/fillrow           |   2 +-
>  tests/ts/column/invalid-multibyte |   2 +-
>  tests/ts/column/multi-file        |   2 +-
>  tests/ts/column/separator_table   |   2 +-
>  tests/ts/cramfs/mkfs              |   8 +--
>  tests/ts/namei/logic              |   2 +-
>  tests/ts/rename/basic             |  41 +++++++++++++
>  tests/ts/rename/subdir            |  42 +++++++++++++
>  tests/ts/rename/symlink           |  41 +++++++++++++
>  16 files changed, 245 insertions(+), 69 deletions(-)
>  create mode 100644 tests/expected/rename/basic
>  create mode 100644 tests/expected/rename/subdir
>  create mode 100644 tests/expected/rename/symlink
>  create mode 100755 tests/ts/rename/basic
>  create mode 100755 tests/ts/rename/subdir
>  create mode 100755 tests/ts/rename/symlink

 Note that I'm going to merge it after v2.25 release. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
