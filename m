Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43878 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755395AbeFRVws (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Jun 2018 17:52:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id y89-v6so16605817qtd.10
        for <util-linux@vger.kernel.org>; Mon, 18 Jun 2018 14:52:48 -0700 (PDT)
Received: from CWLP265MB0915.GBRP265.PROD.OUTLOOK.COM ([52.97.130.29])
        by smtp.gmail.com with ESMTPSA id o25-v6sm9707848qtp.72.2018.06.18.14.52.46
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 14:52:46 -0700 (PDT)
From: Harry Mallon <hjmallon@gmail.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: libblkid: Implementing basic Apple APFS support
Date: Mon, 18 Jun 2018 21:52:43 +0000
Message-ID: <CWLP265MB0915B2DAD26E41D917520FC4F2710@CWLP265MB0915.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,

I am sort of floating around recently, messing with Fedora on a MacBook Pro=
 and trying to improve issues I find. Apple APFS has been the default on Ma=
cs for a couple of years now. I think it would be useful for users to be ab=
le to see/recognise their MacBook system partition in the various disk mana=
gement tools that depend on libblkid.

My initial patch was just adding enough to recognise partitions and mark th=
em as such. Support for recognition is in the upstream file utility so the =
magic values are known.

https://github.com/file/file/blob/a642587a9c9e2dd7feacdf513c3643ce26ad3c22/=
magic/Magdir/apple#L435

However, APFS is not really a filesystem type, but includes a volume manage=
r too. Perhaps recognition of the partition type is not complete enough for=
 upstream? I am looking at making an implementation in the partitions folde=
r rather than the superblocks folder (inspired by code in the reverse engin=
eered apfs-fuse driver) to enumerate and fill in the volumes listed but thi=
s is an order of magnitude more code to work with.

https://github.com/sgan81/apfs-fuse

Would a pure recognition-only apfs module be of interest?
Does anyone have any tips on writing a partition table reader version?
Would upstream be interested in this change at all given open source readin=
g/writing to the file system is likely a long way off (apfs-fuse exists, as=
 does a closed source Paragon implementation, both read only)?
Is libblkid the right place for this code or is there some other layer I sh=
ould be looking at?

Best,
Harry

