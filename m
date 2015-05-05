Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34975 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554AbbEEBvZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 May 2015 21:51:25 -0400
Received: by ieczm2 with SMTP id zm2so1495844iec.2
        for <util-linux@vger.kernel.org>; Mon, 04 May 2015 18:51:24 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 5 May 2015 11:51:24 +1000
Message-ID: <CAEMywzpvtywWytnvGeWyNG0GmTVeYWzLTgswRrRSOw1Gq9WDkw@mail.gmail.com>
Subject: [PATCH] NULL deref
From: Brad Forschinger <bnjf@bnjf.id.au>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

cmd_argv[2] will be initialised only if it's specificed with -c.  NULL
deref otherwise resulting in crash.

Signed-off-by: Brad Forschinger <bnjf@bnjf.id.au>

---
 sys-utils/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 84f1ec4..fda7bdc 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -319,7 +319,7 @@ int main(int argc, char *argv[])
                /* Clear any inherited settings */
                signal(SIGCHLD, SIG_DFL);
                if (verbose)
-                       printf(_("%s: executing %s\n"),
program_invocation_short_name, cmd_argv[2]);
+                       printf(_("%s: executing %s\n"),
program_invocation_short_name, cmd_argv[0]);
                f = fork();

                if (f < 0) {
--
2.3.2
