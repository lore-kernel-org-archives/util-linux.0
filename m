Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52488 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbbH0JW4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Aug 2015 05:22:56 -0400
Date: Thu, 27 Aug 2015 11:22:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: add very long mount line to libmount mtab
Message-ID: <20150827092254.GE2410@ws.net.home>
References: <20150826220141.GA8579@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150826220141.GA8579@www.outflux.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Kees,

On Wed, Aug 26, 2015 at 03:01:41PM -0700, Kees Cook wrote:
>  tests/expected/libmount/tabfiles-parse-mtab    | 7 +++++++
>  tests/expected/libmount/tabfiles-py-parse-mtab | 7 +++++++
>  tests/ts/libmount/files/mtab                   | 1 +
>  3 files changed, 15 insertions(+)

I have problem to apply the patch

$ git am -i ...

Applying: tests: add very long mount line to libmount mtab
fatal: corrupt patch at line 28
Patch failed at 0001 tests: add very long mount line to libmount mtab
The copy of the patch that failed is found in:
   /home/projects/util-linux/util-linux/.git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

...

# patch -p1 < /home/projects/util-linux/util-linux/.git/rebase-apply/patch
patching file tests/expected/libmount/tabfiles-parse-mtab
patch: **** malformed patch at line 18


... etc.

It would be probably better to publish the patch on github or send it
as gzip.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
