Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51110 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdEaUEC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 16:04:02 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Assaf Gordon <assafgordon@gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.30-rc2
Date: Wed, 31 May 2017 22:03:53 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20170523105038.hm3ryvwvghgife4j@ws.net.home> <20170531091648.3eql47zhfo6sy6sd@ws.net.home> <20170531174139.GA30064@gmail.com>
In-Reply-To: <20170531174139.GA30064@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201705312203.53697.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 31 May 2017, Assaf Gordon wrote:

> rename: exit codes                     ... FAILED (rename/exit_codes)

This is because stdout and stderr are mixed:

musl seems to behave like the patch below, while glibc always prints 
the "wrong" order.

--------------
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 502e888..edfc4e0 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -103,10 +103,13 @@ static int do_file(char *from, char *to, char *s, 
int verbose, int noact)
                return 0;
        else if (!noact && rename(s, newname) != 0) {
                warn(_("%s: rename to %s failed"), s, newname);
+               fflush(stderr);
                ret = 2;
        }
-       if (verbose && (noact || ret == 1))
+       if (verbose && (noact || ret == 1)) {
                printf("`%s' -> `%s'\n", s, newname);
+               fflush(stdout);
+       }
        free(newname);
        return ret;
 }
-------------

Not sure whether we should really use fflush() to define the order of 
error and non-error messages. We could also simply "fix" the the test 
script by not using "--verbose". or by using "stdbuf -o0 -e0 
rename ..."


cu,
Rudi
