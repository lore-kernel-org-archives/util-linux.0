Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbdHBIh4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 2 Aug 2017 04:37:56 -0400
Date: Wed, 2 Aug 2017 10:37:48 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: broken calculation of blkid_probe size for ubiN_M
Message-ID: <20170802083748.ui36mn4lvpdbgrt2@ws.net.home>
References: <CACna6rwn+Kf+DCqRS_TQTdv5WakGCNaEqQgc3QwibuyV3KM5=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACna6rwn+Kf+DCqRS_TQTdv5WakGCNaEqQgc3QwibuyV3KM5=A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 01, 2017 at 03:25:40PM +0200, Rafał Miłecki wrote:
> Hi,
> 
> Today I discovered libblkid can't recognize my UBI volume with ubifs
> filesystem. The code in libblkid/src/superblocks/ubifs.c seems
> alright, but it's never used because of:
> # LIBBLKID_DEBUG=lowprobe,buffer blkid /dev/ubi0_0
> (...)
> 4166: libblkid: LOWPROBE: [59] ubifs:
> 4166: libblkid:   BUFFER:         ignore: request out of probing area
> 
> Above error comes from blkid_probe_get_buffer and its
> pr->off + pr->size < real_off + len
> condition. In my case its evaulated as:
> 0 + 1 < 0 + 4
> (pr->size is 1 which looks wrong obviously).

Version? Is it the current git master branch?

I fixed something like this two weeks ago:

        commit 4360f56cf6e40b10ab6ace4cf74073de2381c192
        Author: Karel Zak <kzak@redhat.com>
        Date:   Tue Jul 11 12:17:40 2017 +0200

            libblkid: don't check for size on UBI (char dev)

            Signed-off-by: Karel Zak <kzak@redhat.com>

 and now the condition is not used for char devices:

    if (len == 0 || (!S_ISCHR(pr->mode) && pr->off + pr->size < real_off + len))

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
