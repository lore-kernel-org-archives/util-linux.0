Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:56980 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752827AbdKIQVe (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Nov 2017 11:21:34 -0500
Date: Thu, 9 Nov 2017 11:21:25 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, Karel Zak <kzak@redhat.com>,
        util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, pavel@ucw.cz
Subject: Re: Linux & FAT32 label
Message-ID: <20171109162125.ixpymbeiovpsj7mc@thunk.org>
References: <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <20171105203542.jgupce2usbtjhbg2@thunk.org>
 <20171105211249.xrg6m6ijjewrpqp2@pali>
 <20171107172841.twyu7ieekrs6b2da@thunk.org>
 <20171109090145.lffuluwm3sxanfzu@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171109090145.lffuluwm3sxanfzu@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 09, 2017 at 10:01:45AM +0100, Pali Rohár wrote:
> > > You would have stored LABEL42 in boot sector and no label in root
> > > directory. Windows handle this situation as there is no label.
> > 
> > But why should we *care*?
> 
> FAT is Microsoft's filesystem and the only usage of it on Linux is due
> to interoperability with different non-Linux systems. So here we should
> implement FAT in the similar/same way as other systems. It does not make
> sense to implement it differently and specially in non-compatible way.
> Because it lost reason what is primary usage of the FAT on Linux.

The primary usage of FAT on Linux is for data interchange, primarily
with USB sticks.  I'm still failing to see how it might "spoil some
vast eternal plan"[1] if a USB stick which Windows would show as
having no label, blkid/udev showed as having the label "LABEL42"?

[1] to quote the song "If I were a rich man"

I'm just trying to understand why this specific detail of bit-for-bit
compatibility is so important.

						- Ted
