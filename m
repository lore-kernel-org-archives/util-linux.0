Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yh0-f46.google.com ([209.85.213.46]:48668 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab2JRSMj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Oct 2012 14:12:39 -0400
Received: by mail-yh0-f46.google.com with SMTP id m54so2444714yhm.19
        for <util-linux@vger.kernel.org>; Thu, 18 Oct 2012 11:12:38 -0700 (PDT)
Message-ID: <50804693.80009@ayan.net>
Date: Thu, 18 Oct 2012 14:12:35 -0400
From: Ayan George <ayan@ayan.net>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use C99 idioms in kill.c
References: <508025be.e81S03iobeo1edmy%ayan@ayan.net> <20121018173242.GB16193@x2.net.home>
In-Reply-To: <20121018173242.GB16193@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/18/2012 01:32 PM, Karel Zak wrote:
> On Thu, Oct 18, 2012 at 03:52:30PM +0000, Ayan George wrote:
>> * Moved some declarations closer to where the vairable is used.
>
>   No problem if the declaration is at the begin of any block, like
>
>    if (x) {
>        int y;
>        ...
>    }
>
>   everything other is MESS.
>
>      Karel
>
>

A mess?  Why bother declaring a variable within a block with c99?

It always seemed to make sense to declare a variable closest to where it 
is initialized and used.

Either way -- sorry if it is unacceptable.  I'll retreat to my hole. :^)

-ayan
