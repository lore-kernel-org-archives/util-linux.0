Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdIZKLb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Sep 2017 06:11:31 -0400
Date: Tue, 26 Sep 2017 12:11:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] login: fix signal race
Message-ID: <20170926101125.vbsyvphtndcnozjr@ws.net.home>
References: <20170925195411.GA25565@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925195411.GA25565@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 25, 2017 at 09:54:11PM +0200, Tobias Stoeckmann wrote:
> The functions warnx(3) and gettext(3) are not safe to use within signal
> handlers and should be avoided. Preparing the message beforehand and
> calling write(2) as well as calling _exit(2) solves the problem.

Applied with small changes:

>  po/ca.po            |  6 +++---
>  po/cs.po            |  6 +++---
>  po/da.po            |  6 +++---
>  po/de.po            |  6 +++---
>  po/es.po            |  6 +++---
>  po/et.po            |  6 +++---
>  po/eu.po            |  4 ++--
>  po/fi.po            |  6 +++---
>  po/fr.po            |  6 +++---
>  po/gl.po            |  4 ++--
>  po/hr.po            |  4 ++--
>  po/hu.po            |  6 +++---
>  po/id.po            |  6 +++---
>  po/it.po            |  6 +++---
>  po/ja.po            |  6 +++---
>  po/nl.po            |  6 +++---
>  po/pl.po            |  6 +++---
>  po/pt_BR.po         |  6 +++---
>  po/ru.po            |  6 +++---
>  po/sl.po            |  6 +++---
>  po/sv.po            |  6 +++---
>  po/tr.po            |  6 +++---
>  po/uk.po            |  6 +++---
>  po/util-linux.pot   |  4 ++--
>  po/vi.po            |  6 +++---
>  po/zh_CN.po         |  6 +++---
>  po/zh_TW.po         |  6 +++---

Please, don't send patches with po/ stuff ("git checkout -f po/" is fine), it's
updated before release by maintainer.

>  static void timedout(int sig __attribute__ ((__unused__)))
>  {
>  	signal(SIGALRM, timedout2);
>  	alarm(10);
> -	/* TRANSLATORS: The standard value for %u is 60. */
> -	warnx(_("timed out after %u seconds"), timeout);
> +	write(STDERR_FILENO, timeout_msg, strlen(timeout_msg));

It seems we need our ignore_result() here to keep compiler happy, because
write() is marked as warn_unused_result in glibc header files...

>  	signal(SIGALRM, SIG_IGN);
>  	alarm(0);
>  	timedout2(0);
> @@ -1134,6 +1134,13 @@ int main(int argc, char **argv)
>  
>  	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
>  
> +	setlocale(LC_ALL, "");
> +	bindtextdomain(PACKAGE, LOCALEDIR);
> +	textdomain(PACKAGE);
> +
> +	/* TRANSLATORS: The standard value for %u is 60. */
> +	snprintf(timeout_msg, sizeof(timeout_msg),
> +	    _("%s: timed out after %u seconds"), argv[0], timeout);

I've replaced argv[0] with program_invocation_short_name.

Thanks, good catch!

	Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
