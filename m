Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:62081 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbaKLVIx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 12 Nov 2014 16:08:53 -0500
Message-ID: <5463CC58.9070609@bernhard-voelker.de>
Date: Wed, 12 Nov 2014 22:08:40 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>
CC: Boris Egorov <egorov@linux.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>	<5461B803.4050707@linux.com>	<CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>	<alpine.LNX.2.03.1411112236560.23899@iki.fi>	<20141112142500.GB5530@x2.net.home> <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
In-Reply-To: <CAG27Bk2-c4_AsqCsBd+uBkkcvX0CSJPW+Q2+JndyGts=ZE1rmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/12/2014 04:02 PM, Sami Kerola wrote:
> On 12 November 2014 14:25, Karel Zak <kzak@redhat.com> wrote:
>> On Tue, Nov 11, 2014 at 10:49:02PM +0000, Sami Kerola wrote:
>>>       printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
>>>               version, strsz, sz);
>>> +     free(strsz);
>>
>>  free-before-exit, you know what I think about it, right? :)
> 
> Normally I would agree, but this case is bizarre. The mkswap will
> return 1 when compiled with clang -fsanitize=address without any
> message what is wrong. That's probably clang bug, which is a different
> topic all together. Adding the free() calls seems to make the
> immediate tests failure issue to go away, that is needed to automate
> sanitize. In case travis && address sanitation is not needed at all
> then these changes does not make sense.

In coreutils, we're using a macro IF_LINT as condition for such
free() calls, and for tools like Coverity, we're turning it on.

Have a nice day,
Berny
