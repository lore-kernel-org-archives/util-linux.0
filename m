Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36433 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbKYWgS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Nov 2015 17:36:18 -0500
Received: by vkay187 with SMTP id y187so43489008vka.3
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 14:36:17 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAJ5Duc7znhFzXK7yoWNTd6-PjjAKjahD1LUhW71p+g8zhatj-g@mail.gmail.com>
References: <CAJ5Duc7znhFzXK7yoWNTd6-PjjAKjahD1LUhW71p+g8zhatj-g@mail.gmail.com>
Date: Wed, 25 Nov 2015 22:36:17 +0000
Message-ID: <CAG27Bk29MT7E_vJg86pKxeMHWx6cQM22wOsazAe5WLGdzJnHHg@mail.gmail.com>
Subject: Re: [Possible bug?] column command not ignoring escape sequences.
From: Sami Kerola <kerolasa@iki.fi>
To: Michael Heyns <mike.bean.heyns@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 25 November 2015 at 22:11, Michael Heyns <mike.bean.heyns@gmail.com> wrote:
> Greetings,
>
> I have a working script checking mimetypes i.e. `text/x-diff`;
> `image/svg+xml` etc.
>
> =================================
>   1   #!/bin/bash
>   2
>   3   _Bold="\e[1m"
>   4   _unBold="\e[22m"
>   5   _Blue="\e[34m"
>   6   _uC="\e[39m"
>   7
>   8   mimetype="$1"
>   9   output="${_Bold}Testing MimeType${_unBold}:\t${mimetype}\n\t-------------"
>  10
>  11   get_default()
>  12   {
>  13       xdg-mime query default "$1"
>  14   }
>  15
>  16   alias_of=`grep "^$mimetype " /usr/share/mime/aliases | cut -d' ' -f2`
>  17   if [ -n "$alias_of" ]; then
>  18       default=`get_default $alias_of`
>  19       output="$output\nWhich is an alias of:\t$alias_of\t->
> ${default:-"none"}"
>  20   else
>  21       output="$output\nWhich is not an alias."
>  22       alias_of=$mimetype
>  23   fi
>  24
>  25   while : ; do
>  26       subclass_of=`grep "^$alias_of " /usr/share/mime/subclasses |
> cut -d' ' -f2`
>  27       if [ -n "$subclass_of" ]; then
>  28         default=`get_default $subclass_of`
>  29         output="$output\nWhich is a subclass of:\t$subclass_of\t->
> ${default:-"none"}"
>  30
>  31         alias_of=$subclass_of
>  32       else
>  33         output="$output\nWhich is not a subclass"
>  34         break
>  35       fi
>  36   done
>  37
>  38   echo -e $output | column -t -s $'\t'
> =================================
>
> Output without bold (line 8) is as expected but with bold, the column
> is widened/broken.
>
> I have removed the rest of the formatting in my example, but with
> colors added it gets much worse.
>
> I think I have narrowed it down to the `column` somehow including the
> escape sequences in its spacing calculation? The same thing happens in
> xterm, gnome-terminal and urxvt.
>
> Is this expected behaviour? I'm learning a lot but sometimes I get a
> headscratcher like this one.

Hi Michael,

I think you are onto something. The issue feels like the same what is
skewing more output, and that I fixed in my upcoming pull request.

https://github.com/kerolasa/lelux-utiliteetit/commit/eeaa3eede07830c80540ab3b4e31ff348bbc1c65

But since the issue is with two utilities the fix really should be
wrote once. Trouble is that what I did with more is no where near
being an universal stream filter that is clearly needed.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
