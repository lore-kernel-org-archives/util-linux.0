Return-Path: util-linux-owner@vger.kernel.org
Received: from tartarus.angband.pl ([89.206.35.136]:58920 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752215AbcL2Add (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 28 Dec 2016 19:33:33 -0500
Date: Thu, 29 Dec 2016 01:33:27 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Andreas Henriksson <andreas@fatal.se>
Subject: Re: [PATCH 1/1] setterm: add --resize option
Message-ID: <20161229003327.oeavblvtsem4e6ge@angband.pl>
References: <20161228220211.5634-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161228220211.5634-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 28, 2016 at 10:02:11PM +0000, Sami Kerola wrote:
> Reset terminal size by assessing maximum row and column.  This is useful
> when actual geometry and kernel terminal driver are not in sync.
> 
> Addresses: http://bugs.debian.org/835636
> Based-on-work-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

Awesome, thanks for taking a look at it!
Alas, at least the delay length makes your version not work for me.


> --- a/term-utils/setterm.1
> +++ b/term-utils/setterm.1
> @@ -228,6 +228,10 @@ Turns keyboard repeat on or off.
> +\fB\-\-resize\fP
> +Reset terminal size by assessing maximum row and column.  This is useful
> +when actual geometry and kernel terminal driver are not in sync.

Perhaps a remark about serial consoles as the principal use?  They don't
transfer ioctls, just a byte stream plus breaks.

> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index abcf8b291..691c3bc2f 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> +	tv.tv_sec = 0;
> +	tv.tv_usec = 100;
> +	return select(1, &set, NULL, NULL, &tv);

This delay is too short even on my amd64 in xfce4-terminal, much less on a
serial link.  Even at 115200 baud, 100usec = 1/10000sec is enough to ferry
less than a byte and a half, one way, without giving any time for the
terminal to respond.  As the query will be often preceded by a login screen
-- sometimes just a banner, sometimes a picture, sometimes a screenful of
ALL CAPS "authorized use only" legal blathering, even my original timeout of
3.0 seconds is quite short.

In a vast majority of cases the timeout won't be reached -- it's just a
safeguard against the terminal being disconnected or not implementing cursor
position queries.

> +	 * \e7        Save current state (cursor coordinates, attributes,
> +	 *                character sets pointed at by G0, G1).
> +	 * \e[r       Set scrolling region; parameters are top and bottom row.
> +	 * \e[99999E  Move cursor down 99999 rows.
> +	 * \e[99999C  Move cursor right 99999 columns.
> +	 */
> +	static const char *setup = "\e7\e[r\e[99999E\e[99999C";

I'm afraid some old terminals might use shorts there -- 9999 or 32766 (32767
might be a magic number) could be better.

> +	/* \e[6n      Report cursor position.  */
> +	static const char *getpos = "\e[6n";
> +	/* \e8        Restore state most recently saved by \e7. */
> +	static const char *restore = "\e8";

> +	if (write(STDIN_FILENO, setup, strlen(setup)) < 0 ||
> +	    write(STDIN_FILENO, getpos, strlen(getpos)) < 0) {
> +		warn(_("write failed"));

What about blasting all three strings to the terminal together?

The former two have no logical reason to be apart, writing the third one
unconditionally means the cursor won't go to an odd place if the read fails,
thus they can go in one write.


Meow!
-- 
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=zx-spectrum --build=pdp11
