Return-Path: <SRS0=DPLT=WP=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4190C3A5A0
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 12:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9478E20843
	for <util-linux@archiver.kernel.org>; Mon, 19 Aug 2019 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfHSMc6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:32:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSMc6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Aug 2019 08:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CA4D1057944;
        Mon, 19 Aug 2019 12:32:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E2F18944;
        Mon, 19 Aug 2019 12:32:56 +0000 (UTC)
Date:   Mon, 19 Aug 2019 14:32:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     util-linux <util-linux@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: Testsuite failures on Linux/sparc64
Message-ID: <20190819123253.ruuazfyr7sgwqjkl@ws.net.home>
References: <59067dd2-e0c5-c320-041c-07b0d7090e34@physik.fu-berlin.de>
 <b32d25f6-ac5a-94e4-11fd-49ad71dd8a13@physik.fu-berlin.de>
 <CADxRZqyga7QKSD16NcGaSx9oGGor0SRORuE7fMStOhcD4Ck5EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqyga7QKSD16NcGaSx9oGGor0SRORuE7fMStOhcD4Ck5EQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Mon, 19 Aug 2019 12:32:57 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Aug 18, 2019 at 03:17:31PM +0300, Anatoly Pugachev wrote:
> On Sun, Jul 28, 2019 at 11:02 PM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > On 7/28/19 9:59 PM, John Paul Adrian Glaubitz wrote:
> > > The util-linux testsuite from git currently fails on Linux/sparc64 with:
> > >
> > >         fdisk: MBR - non-dos mode: [11] 1nd-primary-delete   ... FAILED (fdisk/mbr-nondos-mode-1nd-primary-delete)
> > >         blkid: superblocks probing: [31] fat32_mkdosfs_none_dosfslabel_label1_xp_label2 ... OK
> > >         minix: mkfs fsck                                     ... OK
> > >         fdisk: MBR - dos mode                                ... OK
> > >         blkid: superblocks probing: [32] fat32_mkdosfs_none_xp_label1 ... OK
> > >         blkid: superblocks probing: [33] fat32_mkdosfs_none_xp_label1_dosfslabel_label2 ... OK
> > >         fdisk: MBR - non-dos mode: [12] extended-delete      ... FAILED (fdisk/mbr-nondos-mode-extended-delete)
> > >         blkid: superblocks probing: [34] fat32_xp_label1     ... OK
> > > Value out of range.
> > >         fdisk: MBR - non-dos mode: [13] first-sector-at-end  ... FAILED (fdisk/mbr-nondos-mode-first-sector-at-end)
> 
> fdisk non-dos mode tests are not suited (written) for sparc, since
> default fdisk partition table/mode on sparc is 'sun'.
> So disable this test on sparc. Patch attached. Tested locally and on gcc202.

I have applied a little bit different version. It seems we can remove
all the non-MBR stuff from the test. Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
