Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663Ab1IFBVx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Sep 2011 21:21:53 -0400
Date: Tue, 6 Sep 2011 03:21:49 +0200
From: Karel Zak <kzak@redhat.com>
To: xinglp <xinglp@gmail.com>
Cc: util-linux@vger.kernel.org,
        LFS Developers Mailinglist <lfs-dev@linuxfromscratch.org>
Subject: Re: The "write" of util-linux-2.20 not work.
Message-ID: <20110906012149.GE4117@nb.redhat.com>
References: <CAHQM782=kH3G9=H91ONnc1EmX6-eU0fWAAGMh8+cfjvpZ+uQbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHQM782=kH3G9=H91ONnc1EmX6-eU0fWAAGMh8+cfjvpZ+uQbA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 06, 2011 at 08:59:01AM +0800, xinglp wrote:
> it just prints
> write: : No such file or directory
> 
> util-linux-2.19.1 works well


Hmm.. I found this stupid change:

-       (void)sprintf(path, "/dev/%s", tty);
+       printf(path, "/dev/%s", tty);

in the commit 5f51b8b25de1c6c688d5172ed04008a94b241e05. Fixed below.

    Karel


>From b89fdd9c05a6e5f12ab56441389e5ee9d1d7f30f Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 6 Sep 2011 03:18:46 +0200
Subject: [PATCH] write: fix path for freopen()

Reported-by: xinglp <xinglp@gmail.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 term-utils/write.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index a825f62..a70eb7b 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -322,7 +322,7 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 
 	if (strlen(tty) + 6 > sizeof(path))
 		errx(EXIT_FAILURE, _("tty path %s too long"), tty);
-	printf(path, "/dev/%s", tty);
+	snprintf(path, sizeof(path), "/dev/%s", tty);
 	if ((freopen(path, "w", stdout)) == NULL)
 		err(EXIT_FAILURE, "%s", path);
 
-- 
1.7.6



