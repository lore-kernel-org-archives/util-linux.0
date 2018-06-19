Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965599AbeFSPXK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Jun 2018 11:23:10 -0400
Date: Tue, 19 Jun 2018 17:23:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Harry Mallon <hjmallon@gmail.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: libblkid: Implementing basic Apple APFS support
Message-ID: <20180619152306.4spilxh2ihcxtt3o@ws.net.home>
References: <CWLP265MB0915B2DAD26E41D917520FC4F2710@CWLP265MB0915.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CWLP265MB0915B2DAD26E41D917520FC4F2710@CWLP265MB0915.GBRP265.PROD.OUTLOOK.COM>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 18, 2018 at 09:52:43PM +0000, Harry Mallon wrote:
> However, APFS is not really a filesystem type, but includes a volume
> manager too. Perhaps recognition of the partition type is not
> complete enough for upstream?

Arbitrary Apple APFS detection will be improvement. So, detect magic
string and nothing else is good start.

> I am looking at making an
> implementation in the partitions folder rather than the superblocks
> folder (inspired by code in the reverse engineered apfs-fuse driver)
> to enumerate and fill in the volumes listed but this is an order of
> magnitude more code to work with.

I prefer libblkid/src/superblocks folder if we're not able to read
"slices" (partitions, root, etc) from the device. The same situation
is for example ZFS or BTRFS.

> Would a pure recognition-only apfs module be of interest?

Sure.

> Does anyone have any tips on writing a partition table reader version?

I have doubts about it as nothing about the internal logic is public
and it's crazy to provide write access or map internal APFS stuff to 
real Linux block devices if we're not sure how... sounds to dangerous.

> Is libblkid the right place for this code or is there some other layer I should be looking at?

libblkid is the right place for detection

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
