Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab2EWIN2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 May 2012 04:13:28 -0400
Date: Wed, 23 May 2012 10:13:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] last: use min() from c.h
Message-ID: <20120523081302.GJ14560@x2.net.home>
References: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337240469-24539-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 17, 2012 at 09:41:06AM +0200, Petr Uzel wrote:
>  login-utils/last.c |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 34558bb..62fc55c 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -72,15 +72,11 @@ static struct utmp	utmpbuf;
>  #define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
>  #define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
>  
> -#ifndef MIN
> -#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
> -#endif
> -
>  /* maximum sizes used for printing */
>  /* probably we want a two-pass version that computes the right length */
> -int hmax = MIN(HMAX, 16);
> -int lmax = MIN(LMAX, 8);
> -int nmax = MIN(NMAX, 16);
> +int hmax = min(HMAX, 16);
> +int lmax = min(LMAX, 8);
> +int nmax = min(NMAX, 16);

 Please, test your patches... you cannot use min() (as defined in c.h)
 outside functions.

 It seems that {h,l,n}max are not modified in the code so we can use
 macros there. Applied the patch below.

    Karel



>From 69c9e8387b90025d1f75356f5e2369d0262ee603 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 23 May 2012 10:07:57 +0200
Subject: [PATCH] last: use min() from c.h

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/last.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 34558bb..1b1bee1 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -72,15 +72,11 @@ static struct utmp	utmpbuf;
 #define	LMAX	(int)sizeof(utmpbuf.ut_line)	/* size of utmp tty field */
 #define	NMAX	(int)sizeof(utmpbuf.ut_name)	/* size of utmp name field */
 
-#ifndef MIN
-#define MIN(a,b)	(((a) < (b)) ? (a) : (b))
-#endif
-
 /* maximum sizes used for printing */
 /* probably we want a two-pass version that computes the right length */
-int hmax = MIN(HMAX, 16);
-int lmax = MIN(LMAX, 8);
-int nmax = MIN(NMAX, 16);
+#define P_HMAX	min(HMAX, 16)
+#define P_LMAX	min(LMAX, 8)
+#define P_NMAX	min(NMAX, 16)
 
 typedef struct arg {
 	char	*name;				/* argument */
@@ -187,19 +183,19 @@ print_partial_line(struct utmp *bp) {
     char *ct;
 
     ct = utmp_ctime(bp);
-    printf("%-*.*s  %-*.*s ", nmax, nmax, bp->ut_name, 
-	   lmax, lmax, bp->ut_line);
+    printf("%-*.*s  %-*.*s ", P_NMAX, P_NMAX, bp->ut_name,
+	   P_LMAX, P_LMAX, bp->ut_line);
 
     if (dolong) {
 	if (bp->ut_addr) {
 	    struct in_addr foo;
 	    foo.s_addr = bp->ut_addr;
-	    printf("%-*.*s ", hmax, hmax, inet_ntoa(foo));
+	    printf("%-*.*s ", P_HMAX, P_HMAX, inet_ntoa(foo));
 	} else {
-	    printf("%-*.*s ", hmax, hmax, "");
+	    printf("%-*.*s ", P_HMAX, P_HMAX, "");
 	}
     } else {
-	printf("%-*.*s ", hmax, hmax, bp->ut_host);
+	printf("%-*.*s ", P_HMAX, P_HMAX, bp->ut_host);
     }
 
     if (doyear) {
-- 
1.7.7.6

