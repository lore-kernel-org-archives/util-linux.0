Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.103]:65352 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab3K0XUv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Nov 2013 18:20:51 -0500
Message-ID: <529679EA.70600@zoho.com>
Date: Thu, 28 Nov 2013 00:02:02 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>
CC: Curtis Gedak <gedakc@gmail.com>, Karel Zak <kzak@redhat.com>,
        Marc MERLIN <marc@merlins.org>, util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
References: <20131118102051.GA31813@merlins.org> <20131124135226.GH11389@merlins.org> <20131125103124.GQ5572@x2.net.home> <529605B7.3020903@ubuntu.com> <20131127145840.GB32483@x2.net.home> <52963910.60800@ubuntu.com> <52964ED3.8030504@gmail.com> <5296515A.1070505@ubuntu.com> <529654CF.1010904@gmail.com> <52965E84.4070101@ubuntu.com>
In-Reply-To: <52965E84.4070101@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27/11/13 22:05, Phillip Susi wrote:
> So it doesn't bother the iPod if you change the id?
>
> I'm thinking parted should throw an exception noting the broken
> partition and offer to fix it by changing the id, or deleting it.
> Changing the id would have the added benefit of keeping Windows from
> overwriting it.

Even if it worked and there were no known devices needing it at 0, it 
should be optional and allow to change it back. I have already faced a 
similar problem, having to jump through hoops, when restoring a 
partition layout and needing to set a "partition" to id 5 (extended).

