Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f179.google.com ([209.85.128.179]:48296 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbdJ3P3K (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Oct 2017 11:29:10 -0400
Date: Mon, 30 Oct 2017 16:29:07 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Andreas Bombe <aeb@debian.org>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>
Subject: Re: Linux & FAT32 label
Message-ID: <20171030152907.ushsldq7kgvu4xzo@pali>
References: <20171004153332.GA6696@pali>
 <20171011212435.znmtdnsxcd5ectub@pali>
 <20171011214426.wa5endlb3kb4yhbv@pali>
 <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <20171016072845.ksdtda5zdnb66mbe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171016072845.ksdtda5zdnb66mbe@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 16 October 2017 09:28:45 Pali Rohár wrote:
> On Monday 16 October 2017 03:12:43 Andreas Bombe wrote:
> > The other thing is completely ignoring the boot sector label, which I
> > could have as a mode enabled by command line switch or environmental
> > variable, or just outright make it the default. I'm not decided yet.
> > 
> > Another problem is whether to also ignore boot sector on setting label.
> > Otherwise the sequence:
> >   "set label on Linux" (both root and boot)
> >   "change label on Windows" (root label is changed)
> >   "remove label on Windows" (root label is deleted)
> >   "view label on Linux" (no root label, use boot label)
> > resurrects an old label.
> 
> There is also mlabel tool which is heavily used (e.g. by gparted GUI
> application) and when setting new label it stores it to both location.
> 
> And because gparted is used on Linux, such situation as described above
> can still happen.

Another option is to completely ignore label from the boot sector when
reading label.

And maybe it can be a good idea to synchronize labels in boot sector and
root directory in fsck.fat. When differs in interactive mode it can ask
user if label from root directory should be copied to boot sector or
from boot sector to root directory.

-- 
Pali Rohár
pali.rohar@gmail.com
