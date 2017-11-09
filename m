Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbdKILDA (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 9 Nov 2017 06:03:00 -0500
Date: Thu, 9 Nov 2017 12:02:54 +0100
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Bombe <aeb@debian.org>, util-linux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrius =?utf-8?B?xaB0aWtvbmFz?= <andrius@stikonas.eu>,
        Curtis Gedak <gedakc@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux & FAT32 label
Message-ID: <20171109110254.to37iuydtbpqypjy@ws.net.home>
References: <20171012204931.tfd2bhmwu5b6rbpz@pali>
 <20171016011243.zurh5jhb2y6mczx7@amos.fritz.box>
 <CAHp75VdWXHtCHiRxnbAidr9inehVC=av6gp7-jtJqN6WPYh4fg@mail.gmail.com>
 <20171105133929.7cscboxymmpkw634@pali>
 <CAHp75VfwLh9eH992nB1TiOVYOpEV6OSTGkbLau=eQRPeczeFyA@mail.gmail.com>
 <20171105140745.ze4ttkazeczrqsy7@pali>
 <CAHp75VfeNj16k_nMmLxVJTWLr=gwFUMXiga6FYmbLb3pvWJxaw@mail.gmail.com>
 <20171105143411.aynz5tr3igobuh6e@pali>
 <20171106101444.m5kxevutsdxx34kl@ws.net.home>
 <20171109085909.b6b5m35qeul3orrx@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171109085909.b6b5m35qeul3orrx@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 09, 2017 at 09:59:09AM +0100, Pali Rohár wrote:
> What about exporting e.g. BOOT_LABEL field from libblkid for vfat disks?
> LABEL (which is shown to user, e.g. in GUI) would be that one from root
> directory (same which is used by label on MS-DOS and Windows) and
> BOOT_LABEL would be from boot sector. If somebody really needs to know
> current label stored in boot sector he would be able to do it via blkid.
> Also it would be possible then via blkid to read exact label stored in
> root directory and also read what is stored in boot sector. Because
> currently it is not possible to know from which location LABEL comes
> from.

This is good idea, there is no problem to export additional
information about filesystems. We already use it for another
filesystems too. Note, these details are visible for low-level
probing (blkid -p) and udev only. The high-level API follows
LABEL only.

Maybe it would be better to use LABEL_BOOT= or LABEL_FATBOOT= as name.

The important thing is the default behavior of the LABEL, this is what
use mount(8) and another tools.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
