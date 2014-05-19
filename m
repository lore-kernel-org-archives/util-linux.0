Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f175.google.com ([209.85.220.175]:58188 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaESVvy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 May 2014 17:51:54 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu19so10185844vcb.6
        for <util-linux@vger.kernel.org>; Mon, 19 May 2014 14:51:53 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Date: Mon, 19 May 2014 22:51:53 +0100
Message-ID: <CAG27Bk2qzzF2BNp=ec+x4zn8WOc40CNn8qKyG9_H5+mdWHb5ew@mail.gmail.com>
Subject: Re: [PATCH 00/17] pull: almost complete setterm refactoring
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 May 2014 15:05, Sami Kerola <kerolasa@iki.fi> wrote:
> Sami Kerola (17):
>   setterm: clean up includes
>   setterm: use getopt_long_only() for option parsing
>   setterm: use string utils to numeric parsing
>   setterm: move show_tabs() and screendump() functions
>   setterm: remove usage comment segment
>   setterm: add option control structure
>   setterm: add init_terminal() to make main() shorter
>   setterm: clean up screendump()
>   setterm: remove devfs and /dev/vcsa0 support
>   setterm: make -msglevel 0 to work as is did earlier
>   setterm: correct usage() bright color argument
>   setterm: improve perform_sequence() coding style
>   setterm: tell user when options does not effect
>   setterm: improve error messages
>   setterm: various visual terminal effects are not console specific
>   setterm: mark some options to be exclusive with each other
>   setterm: add set_blanking() action

Hi Karel & thank you for feedback, here are my collected improvements.

0002 setterm-use-getopt_long_only-for-option-parsing
> +             errx(EXIT_FAILURE, "duplicate use of an option");
> NLS.. _("duplicate use of an option")

Fixed.


0003 setterm-use-string-utils-to-numeric-parsing
> Why not strtos32_or_err() from lib/strutils.c ?

Because I did not think.  Fixed.


0006 setterm-add-option-control-structure
> +     memset(&ctl, 0, sizeof (ctl));
>
> The memset() call is unnecessary. It's enough to set any struct member
> to zeroize whole struct, etc:
>
>   struct setterm_control ctl = { .opt_te_terminal_name = NULL };

I did not know, and then I went to find out more.  Universal zero
initializer seem to be an option many recommend, so I'll switch to this
format.

  struct setterm_control ctl = { 0 };

This is what the standard tells, just in case someone finds util-linux
mail archive and needs a reference.

http://c0x.coding-guidelines.com/6.7.8.html


0009 setterm-remove-devfs-and-dev-vcsa0-support
>  Sooo.. do we really need read_error()? ;-)

Yup, not needed.


0011 setterm-correct-usage-bright-color-argument
> too many duplicate information, it would be better to use
>
>     _(" -foreground <default>|<color>\n")
>     ...
>     _(" -hbcolor <bright> <color>\n")
>
> and describe below in usage():
>
>    _(" <color> means black, blue, ...")

Fixed. The fix has tiny usage() error. It gives impression grey might
work as --foreground color, but it does send an error. Oh well, users
will need to read friendly manual if they are confused.


0013 setterm-tell-user-when-options-does-not-effect
> Please use complete long options in error messages ("--repeat" rather
> than "-repeat").

Fixed.  And if the the errors are expected too have double dash long
options so should the usage().  That is done in commit below.

https://github.com/kerolasa/lelux-utiliteetit/commit/fb27f91cac9702ad1858d782dd840d5868547423

Here are the updated pull details.  I assume the release v2.25 is done
before merge, and if so I will keep on rebasing the changes until the
merge.

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk19

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
