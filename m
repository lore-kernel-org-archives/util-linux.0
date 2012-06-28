Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41565 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2F1IGh convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 28 Jun 2012 04:06:37 -0400
Received: by wibhm11 with SMTP id hm11so6183656wib.1
        for <util-linux@vger.kernel.org>; Thu, 28 Jun 2012 01:06:35 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <4FEBF7E4.5080606@bernhard-voelker.de>
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
	<4FEBEF93.8000107@bernhard-voelker.de>
	<4FEBF7E4.5080606@bernhard-voelker.de>
Date: Thu, 28 Jun 2012 10:06:35 +0200
Message-ID: <CAG27Bk3GYLLzpQry3+VrnOAxTZRqHtseTe0WQY3n9M0q6yAY7w@mail.gmail.com>
Subject: Re: [pull] /run directory and swapon
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 28, 2012 at 8:21 AM, Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
> On 06/28/2012 07:45 AM, Bernhard Voelker wrote:
>> On 06/27/2012 11:33 PM, Sami Kerola wrote:
>>> +            "     --inhuman          display swap size in bytes in --show output\n"
>>
>> Isn't "--inhuman" a bit harsh? And wouldn't it be better to
>> say what it does instead of what it does not?  E.g. "--bytes"?

Hi Berny,

You are right.  --inhuman does not sound at morning as good as
near midnight.  I s/inhuman/bytes/ change is done.

> Ooh, my swap shrinked! ;-)
>
>  $ ./lsblk /dev/sdb1
>  NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
>  sdb1   8:17   0   2G  0 disk [SWAP]
>
>  $ ./swapon --show
>  NAME      TYPE      SIZE  USED PRIO
>  /dev/sdb1 partition   2M 11836    0
>
>  $ ./swapon --show --inhuman
>  NAME      TYPE         SIZE  USED PRIO
>  /dev/sdb1 partition 2104476 11836    0
>
> I think that's in 1k-blocks, isn't it?

Good catch.  I made simple multiplier assignment but something is
still wrong.

sake@sake /home/src/util-linux ./swapon --show --bytes
NAME      TYPE            SIZE USED PRIO
/dev/dm-0 partition 7999582208    0   -1

sake@sake /home/src/util-linux ./lsblk -I 252 --bytes	# why I did not
get output?
sake@sake /home/src/util-linux ./lsblk --bytes | grep 252
| `-cryptswap1 (dm-0) 252:0    0   7999586304  0 crypt [SWAP]

Still differs?  But which one is right?

sake@sake /home/src/util-linux grep SwapTotal /proc/meminfo
SwapTotal:       7812092 kB
sake@sake /home/src/util-linux echo $((7812092 * 1024))
7999582208

Did we came across lsblk --include but && size determination bug.

>  $ ./swapon --help | grep USED
>        USED  bytes in use
>
> Isn't USED not also in blocks?

This one I realized about ten minutes after I sent the pull
request, and went to bed.  Yes, used column should be human
readable as well, which it is now.

p.s. Please notice that the updates to my branch are pushed with
force.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
