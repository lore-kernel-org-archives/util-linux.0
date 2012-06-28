Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:65114 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2F1GVd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 28 Jun 2012 02:21:33 -0400
Message-ID: <4FEBF7E4.5080606@bernhard-voelker.de>
Date: Thu, 28 Jun 2012 08:21:24 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com
CC: Sami Kerola <kerolasa@iki.fi>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [pull] /run directory and swapon
References: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com> <4FEBEF93.8000107@bernhard-voelker.de>
In-Reply-To: <4FEBEF93.8000107@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 06/28/2012 07:45 AM, Bernhard Voelker wrote:
> On 06/27/2012 11:33 PM, Sami Kerola wrote:
>> +		"     --inhuman          display swap size in bytes in --show output\n"
> 
> Isn't "--inhuman" a bit harsh? And wouldn't it be better to
> say what it does instead of what it does not?
> E.g. "--bytes"?

Ooh, my swap shrinked! ;-)

  $ ./lsblk /dev/sdb1
  NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
  sdb1   8:17   0   2G  0 disk [SWAP]

  $ ./swapon --show
  NAME      TYPE      SIZE  USED PRIO
  /dev/sdb1 partition   2M 11836    0

  $ ./swapon --show --inhuman
  NAME      TYPE         SIZE  USED PRIO
  /dev/sdb1 partition 2104476 11836    0

I think that's in 1k-blocks, isn't it?

  $ ./swapon --help | grep USED
        USED  bytes in use

Isn't USED not also in blocks?


Have a nice day,
Berny
