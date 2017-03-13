Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751095AbdCMMKW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 Mar 2017 08:10:22 -0400
Date: Mon, 13 Mar 2017 13:10:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] last: Always terminate domain with '\0'
Message-ID: <20170313121019.bnikafvfqtsckbpk@ws.net.home>
References: <20170312165059.GC28165@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170312165059.GC28165@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 12, 2017 at 05:51:00PM +0100, Tobias Stoeckmann wrote:
>  login-utils/last.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 340705757..ddbdd84a3 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -507,8 +507,8 @@ static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_t
>  	if (r < 0) {
>  		len = sizeof(p->ut_host);
>  		if (len >= (int)sizeof(domain)) len = sizeof(domain) - 1;
> -		domain[0] = 0;
> -		strncat(domain, p->ut_host, len);
> +		strncpy(domain, p->ut_host, len);
> +		domain[len] = 0;

 I have applied a little bit different solution, we have xstrcpy()
 where is set \0 on len-1, so let's use it.

    Karel

diff --git a/login-utils/last.c b/login-utils/last.c
index 3407057..679ea6c 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -505,10 +505,12 @@ static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_t
        if (ctl->usedns || ctl->useip)
                r = dns_lookup(domain, sizeof(domain), ctl->useip, p->ut_addr_v6);
        if (r < 0) {
-               len = sizeof(p->ut_host);
-               if (len >= (int)sizeof(domain)) len = sizeof(domain) - 1;
-               domain[0] = 0;
-               strncat(domain, p->ut_host, len);
+               size_t sz = sizeof(p->ut_host);
+
+               if (sz > sizeof(domain))
+                       sz = sizeof(domain);
+
+               xstrncpy(domain, p->ut_host, sz);
        }
