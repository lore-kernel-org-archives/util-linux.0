Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34825 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbcL2K6q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 29 Dec 2016 05:58:46 -0500
Received: by mail-qt0-f193.google.com with SMTP id 3so22744166qtr.2
        for <util-linux@vger.kernel.org>; Thu, 29 Dec 2016 02:58:46 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20161229003327.oeavblvtsem4e6ge@angband.pl>
References: <20161228220211.5634-1-kerolasa@iki.fi> <20161229003327.oeavblvtsem4e6ge@angband.pl>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 29 Dec 2016 10:58:45 +0000
Message-ID: <CAG27Bk32Qb0V2g6HFXdPRakrRhjG9fhZbPSFtA8cTjDKpLWu4w@mail.gmail.com>
Subject: Re: [PATCH 1/1] setterm: add --resize option
To: Adam Borowski <kilobyte@angband.pl>
Cc: util-linux <util-linux@vger.kernel.org>,
        Andreas Henriksson <andreas@fatal.se>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 December 2016 at 00:33, Adam Borowski <kilobyte@angband.pl> wrote:
> On Wed, Dec 28, 2016 at 10:02:11PM +0000, Sami Kerola wrote:
>> Reset terminal size by assessing maximum row and column.  This is useful
>> when actual geometry and kernel terminal driver are not in sync.
>>
>> Addresses: http://bugs.debian.org/835636
>> Based-on-work-by: Adam Borowski <kilobyte@angband.pl>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>
> Awesome, thanks for taking a look at it!
> Alas, at least the delay length makes your version not work for me.

Fair enough, updates are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git setterm

https://github.com/kerolasa/lelux-utiliteetit/commit/9e0d5c6b0f8294ceabf38212f6ec14f148e5e642

>> --- a/term-utils/setterm.1
>> +++ b/term-utils/setterm.1
>> @@ -228,6 +228,10 @@ Turns keyboard repeat on or off.
>> +\fB\-\-resize\fP
>> +Reset terminal size by assessing maximum row and column.  This is useful
>> +when actual geometry and kernel terminal driver are not in sync.
>
> Perhaps a remark about serial consoles as the principal use?  They don't
> transfer ioctls, just a byte stream plus breaks.

Added. Could you consider sending an update to manual that clarifies why
setterm --resize works when stty(1) and resize(1) fail.

Ref: http://docstore.mik.ua/orelly/unix/upt/ch42_05.htm

>> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
>> index abcf8b291..691c3bc2f 100644
>> --- a/term-utils/setterm.c
>> +++ b/term-utils/setterm.c
>> +     tv.tv_sec = 0;
>> +     tv.tv_usec = 100;
>> +     return select(1, &set, NULL, NULL, &tv);
>
> This delay is too short even on my amd64 in xfce4-terminal, much less on a
> serial link.  Even at 115200 baud, 100usec = 1/10000sec is enough to ferry
> less than a byte and a half, one way, without giving any time for the
> terminal to respond.  As the query will be often preceded by a login screen
> -- sometimes just a banner, sometimes a picture, sometimes a screenful of
> ALL CAPS "authorized use only" legal blathering, even my original timeout of
> 3.0 seconds is quite short.
>
> In a vast majority of cases the timeout won't be reached -- it's just a
> safeguard against the terminal being disconnected or not implementing cursor
> position queries.

Fair enough. Timeout is set to be 10 seconds.

>> +      * \e7        Save current state (cursor coordinates, attributes,
>> +      *                character sets pointed at by G0, G1).
>> +      * \e[r       Set scrolling region; parameters are top and bottom row.
>> +      * \e[99999E  Move cursor down 99999 rows.
>> +      * \e[99999C  Move cursor right 99999 columns.
>> +      */
>> +     static const char *setup = "\e7\e[r\e[99999E\e[99999C";
>
> I'm afraid some old terminals might use shorts there -- 9999 or 32766 (32767
> might be a magic number) could be better.

Finding max value from termcap would be nice, but I don't know how to do
that. Meanwhole INT16_MAX - 1 is reasonable compromise.

>> +     /* \e[6n      Report cursor position.  */
>> +     static const char *getpos = "\e[6n";
>> +     /* \e8        Restore state most recently saved by \e7. */
>> +     static const char *restore = "\e8";
>
>> +     if (write(STDIN_FILENO, setup, strlen(setup)) < 0 ||
>> +         write(STDIN_FILENO, getpos, strlen(getpos)) < 0) {
>> +             warn(_("write failed"));
>
> What about blasting all three strings to the terminal together?
>
> The former two have no logical reason to be apart, writing the third one
> unconditionally means the cursor won't go to an odd place if the read fails,
> thus they can go in one write.

Striongs are merged, and I changed write() to write_all() to be more robust.
There is also some signal safety now, primarily EINTR is checked at when
select(2) and read(2) return.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
