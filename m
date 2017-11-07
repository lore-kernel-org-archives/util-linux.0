Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:47534 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753519AbdKGR2t (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 7 Nov 2017 12:28:49 -0500
Date: Tue, 7 Nov 2017 12:28:41 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, pavel@ucw.cz
Subject: Re: Linux & FAT32 label
Message-ID: <20171107172841.twyu7ieekrs6b2da@thunk.org>
References: <20171012092113.2bsb3pzv6un4xahr@pali>
 <20171012101311.zfvg6edfvszlujom@ws.net.home>
 <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <20171105203542.jgupce2usbtjhbg2@thunk.org>
 <20171105211249.xrg6m6ijjewrpqp2@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171105211249.xrg6m6ijjewrpqp2@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 05, 2017 at 10:12:49PM +0100, Pali Rohár wrote:
> Easy way how to achieve this situation:
> 
> 1. use mkdosfs to format hard disk to FAT32 with label LABEL42
> 
> 2. boot Windows 10 (or XP) and set label of that FAT32 partition to
> empty (via Explorer GUI)
> 
> 3. profit
> 
> You would have stored LABEL42 in boot sector and no label in root
> directory. Windows handle this situation as there is no label.

But why should we *care*?

Puzzled,

					- Ted
