Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34363 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbbJPBNF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Oct 2015 21:13:05 -0400
Received: by payp3 with SMTP id p3so55474359pay.1
        for <util-linux@vger.kernel.org>; Thu, 15 Oct 2015 18:13:03 -0700 (PDT)
Date: Thu, 15 Oct 2015 18:12:59 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Andreas Schwab <schwab@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: don't assume time_t is compatible with long
Message-ID: <20151016011258.GA3711@newbook>
References: <mvm37xcs2mb.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
In-Reply-To: <mvm37xcs2mb.fsf@hawking.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2015 at 03:06:04PM +0200, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  term-utils/script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/term-utils/script.c b/term-utils/script.c
> index eb4ddc3..ad252a3 100644
> --- a/term-utils/script.c
> +++ b/term-utils/script.c
> @@ -141,7 +141,7 @@ static void script_init_debug(void)
>  static inline time_t script_time(time_t *t)
>  {
>  	const char *str = getenv("SCRIPT_TEST_SECOND_SINCE_EPOCH");
> -	time_t sec;
> +	long sec;
>  
>  	if (str && sscanf(str, "%ld", &sec) == 1)
>  		return sec;

I don't think this does what the commit message says.
Rather, it moves the assumption.
If you're trying to actually *fix* it so it works with 64-bit time_t on
x86 (some kernel developers have discussed a path forwards on that, and
OpenBSD has already implemented it), this will not do the job.

And I note that the old code here is already technically wrong, since this
is supposed to a replacement for time(). It should have included something
equivalent to:
  if (t)
    *t = (time_t)sec;


I'm guessing that the attached patch would be the most corrrect approach;
any comments?

Thanks,
Isaac Dunham

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-script-don-t-assume-that-time_t-is-compatible-with-l.patch"

>From 4fc3751060ab5d4fb84aa814520c7ca1afe32a28 Mon Sep 17 00:00:00 2001
From: Isaac Dunham <ibid.ag@gmail.com>
Date: Thu, 15 Oct 2015 18:03:28 -0700
Subject: [PATCH] script: don't assume that time_t is compatible with long

time_t may change to 64-bit on 32-bit Linux kernels at some point;
at that point, it may be desireable to test for issues with dates
past 2038.
---
 term-utils/script.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index eb4ddc3..f0e997e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -141,11 +141,13 @@ static void script_init_debug(void)
 static inline time_t script_time(time_t *t)
 {
 	const char *str = getenv("SCRIPT_TEST_SECOND_SINCE_EPOCH");
-	time_t sec;
+	int64_t sec;
 
-	if (str && sscanf(str, "%ld", &sec) == 1)
-		return sec;
-	return time(t);
+	if (!str || sscanf(str, "%lld", &sec) != 1)
+		return time(t);
+	if (t)
+		*t = (time_t)sec;
+	return (time_t)sec;
 }
 #else	/* !TEST_SCRIPT */
 # define script_time(x) time(x)
-- 
2.6.1


--0OAP2g/MAC+5xKAE--
