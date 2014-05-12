Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbaELMH7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:07:59 -0400
Date: Mon, 12 May 2014 14:07:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/12] setterm: use string constant rather than #define
Message-ID: <20140512120749.GG8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
 <1399836409-7769-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399836409-7769-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 08:26:47PM +0100, Sami Kerola wrote:
> -/* Control sequences. */
> -#define ESC "\033"
> -
>  /* Static variables. */
>  
>  /* Option flags.  Set if the option is to be invoked. */
> @@ -796,6 +793,8 @@ static char *ti_entry(const char *name) {
>  
>  static void
>  perform_sequence(int vcterm) {
> +	static const char *ESC = "\033";

Sorry, but this is really premature optimization, \033 is just one char.

>  	/* vcterm: Set if terminal is a virtual console. */
>  
>  	int result;
> @@ -822,25 +821,25 @@ perform_sequence(int vcterm) {
>  	/* -linewrap [on|off]. Vc only (vt102) */
>  	if (opt_linewrap && vcterm) {
>  		if (opt_li_on)
> -			printf("\033[?7h");
> +			printf("%s[?7h", ESC);

  fputs("\033[?7h", stdout);

is the right, simple and fast way.

Fixed and merged.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
