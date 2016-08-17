Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34354 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932167AbcHQMvI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2016 08:51:08 -0400
Date: Wed, 17 Aug 2016 14:51:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 8/8] tests: Add losetup-loop test suite
Message-ID: <20160817125106.mpyx5fmj6h4pqtxy@ws.net.home>
References: <18234339-b95c-4f96-fd13-45feaea1cf04@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18234339-b95c-4f96-fd13-45feaea1cf04@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2016 at 08:00:46PM +0200, Stanislav Brabec wrote:
>  tests/expected/losetup/losetup-loop                |   1 +
>  tests/expected/losetup/losetup-loop-find-conflict  |   3 +
>  .../losetup-loop-find-conflict-no-sizelimit        |   3 +
>  .../losetup/losetup-loop-find-conflict-readonly    |   3 +
>  tests/expected/losetup/losetup-loop-find-no-re-use |   2 +
>  .../losetup/losetup-loop-find-ok-no-sizelimit      |   2 +
>  .../losetup/losetup-loop-find-race-condition       |   2 +
>  tests/expected/losetup/losetup-loop-find-re-use    |   2 +
>  tests/expected/losetup/losetup-loop-plain-conflict |   2 +
>  tests/expected/losetup/losetup-loop-plain-re-use   |   2 +
>  tests/expected/losetup/losetup-loop-plain-readonly |   2 +
>  tests/ts/losetup/losetup-loop                      | 228 +++++++++++++++++++++
>  12 files changed, 252 insertions(+)
>  create mode 100644 tests/expected/losetup/losetup-loop
>  create mode 100644 tests/expected/losetup/losetup-loop-find-conflict
>  create mode 100644 tests/expected/losetup/losetup-loop-find-conflict-no-sizelimit
>  create mode 100644 tests/expected/losetup/losetup-loop-find-conflict-readonly
>  create mode 100644 tests/expected/losetup/losetup-loop-find-no-re-use
>  create mode 100644 tests/expected/losetup/losetup-loop-find-ok-no-sizelimit
>  create mode 100644 tests/expected/losetup/losetup-loop-find-race-condition
>  create mode 100644 tests/expected/losetup/losetup-loop-find-re-use
>  create mode 100644 tests/expected/losetup/losetup-loop-plain-conflict
>  create mode 100644 tests/expected/losetup/losetup-loop-plain-re-use
>  create mode 100644 tests/expected/losetup/losetup-loop-plain-readonly
>  create mode 100755 tests/ts/losetup/losetup-loop

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
