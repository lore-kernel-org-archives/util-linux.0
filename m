Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f175.google.com ([209.85.128.175]:46461 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbdKIJBs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Nov 2017 04:01:48 -0500
Date: Thu, 9 Nov 2017 10:01:45 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, pavel@ucw.cz
Subject: Re: Linux & FAT32 label
Message-ID: <20171109090145.lffuluwm3sxanfzu@pali>
References: <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <20171105203542.jgupce2usbtjhbg2@thunk.org>
 <20171105211249.xrg6m6ijjewrpqp2@pali>
 <20171107172841.twyu7ieekrs6b2da@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171107172841.twyu7ieekrs6b2da@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 07 November 2017 12:28:41 Theodore Ts'o wrote:
> On Sun, Nov 05, 2017 at 10:12:49PM +0100, Pali Rohár wrote:
> > Easy way how to achieve this situation:
> > 
> > 1. use mkdosfs to format hard disk to FAT32 with label LABEL42
> > 
> > 2. boot Windows 10 (or XP) and set label of that FAT32 partition to
> > empty (via Explorer GUI)
> > 
> > 3. profit
> > 
> > You would have stored LABEL42 in boot sector and no label in root
> > directory. Windows handle this situation as there is no label.
> 
> But why should we *care*?

FAT is Microsoft's filesystem and the only usage of it on Linux is due
to interoperability with different non-Linux systems. So here we should
implement FAT in the similar/same way as other systems. It does not make
sense to implement it differently and specially in non-compatible way.
Because it lost reason what is primary usage of the FAT on Linux.

-- 
Pali Rohár
pali.rohar@gmail.com
