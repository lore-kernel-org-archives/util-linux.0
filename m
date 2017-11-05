Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f54.google.com ([74.125.82.54]:47677 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdKEVMw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Nov 2017 16:12:52 -0500
Date: Sun, 5 Nov 2017 22:12:49 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, pavel@ucw.cz
Subject: Re: Linux & FAT32 label
Message-ID: <20171105211249.xrg6m6ijjewrpqp2@pali>
References: <20171012085658.iwrusvy4ay4s7hbb@ws.net.home>
 <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <20171105203542.jgupce2usbtjhbg2@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171105203542.jgupce2usbtjhbg2@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sunday 05 November 2017 15:35:42 Theodore Ts'o wrote:
> On Sun, Nov 05, 2017 at 03:07:45PM +0100, Pali Rohár wrote:
> > 
> > Current behavior of the last blkid and fatlabel tools is: Try to read
> > label from the root directory. If it does not exist, then fallback to
> > label stored in boot sector. And when fatlabel is changing label it
> > updates both locations.
> > 
> > So tools which already uses fatlabel for get & set operations should not
> > be affected as setting new label makes boot and root in sync.
> > 
> > New proposed behavior is: Try to read label from the root directory. If
> > not exist, then treat disk as without label.
> 
> Why is it important to ignore the label from the boot sector?  What is
> the situation where if there is not a label in the root directory, and
> there is a label in the boot sector, it is the Wrong Thing to return it?
> 
> For that matter, aside for a diskette from DOS 3.x (where using the
> label from the boot sector *is* the right thing), why/when would we
> ever have a label in the boot sector and not in the root director?

Easy way how to achieve this situation:

1. use mkdosfs to format hard disk to FAT32 with label LABEL42

2. boot Windows 10 (or XP) and set label of that FAT32 partition to
empty (via Explorer GUI)

3. profit

You would have stored LABEL42 in boot sector and no label in root
directory. Windows handle this situation as there is no label.

-- 
Pali Rohár
pali.rohar@gmail.com
