Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33258 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbaLDQ7o (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 4 Dec 2014 11:59:44 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so28610674wiv.14
        for <util-linux@vger.kernel.org>; Thu, 04 Dec 2014 08:59:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141204130044.GH1994@x2.net.home>
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>
	<20141204130044.GH1994@x2.net.home>
Date: Thu, 4 Dec 2014 08:59:42 -0800
Message-ID: <CAF+0mvm-fGvf3BOL6f8SsJgp75a3CP1xsVwkdD+_zP4hg06npQ@mail.gmail.com>
Subject: Re: fdisk units size
From: Matthew Eaton <m.eaton82@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>  Frankly, use 10 based calculation in IT is ugly thing, we are not
>  hard disk device marketing guys...

I work for a SSD manufacturer! :)

Actually, I agree with you.  But sometimes it's easier for me to see
240 GB in fdisk output and know that I have a 240 GB drive plugged in,
rather than see 223.5 GiB.

I like how with parted you can print whichever units you want, but
sadly doesn't work for my use case, since it just prints an error if
there is no disk label present. :(
