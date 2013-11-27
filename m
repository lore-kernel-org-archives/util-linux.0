Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34299 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab3K0VHe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Nov 2013 16:07:34 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so12844065ieb.36
        for <util-linux@vger.kernel.org>; Wed, 27 Nov 2013 13:07:33 -0800 (PST)
Message-ID: <52965F13.4050003@gmail.com>
Date: Wed, 27 Nov 2013 14:07:31 -0700
From: Curtis Gedak <gedakc@gmail.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>, Karel Zak <kzak@redhat.com>
CC: Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <52964ED3.8030504@gmail.com> <5296515A.1070505@ubuntu.com> <529654CF.1010904@gmail.com> <52965E84.4070101@ubuntu.com>
In-Reply-To: <52965E84.4070101@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 13-11-27 02:05 PM, Phillip Susi wrote:
> So it doesn't bother the iPod if you change the id?
>
> I'm thinking parted should throw an exception noting the broken
> partition and offer to fix it by changing the id, or deleting it.
> Changing the id would have the added benefit of keeping Windows from
> overwriting it.

I believe that you have to change the ID back to zero for the iPod to 
function properly.  At least that is what all of the instructions I've 
seen on the Internet indicate.



