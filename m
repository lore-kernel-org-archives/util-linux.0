Return-Path: <SRS0=VPyL=VO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7DAC76192
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38312077C
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 08:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfGQINj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQINj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jul 2019 04:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D88633082133;
        Wed, 17 Jul 2019 08:13:38 +0000 (UTC)
Received: from ws.net.home (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DA0FC6013B;
        Wed, 17 Jul 2019 08:13:37 +0000 (UTC)
Date:   Wed, 17 Jul 2019 10:13:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Istvan Gabor <suseuser04@gmail.hu>
Cc:     Util linux <util-linux@vger.kernel.org>
Subject: Re: fdisk does not allow overwrite default/suggested value
Message-ID: <20190717081334.32dlmsyrlp7issfh@ws.net.home>
References: <55e1e62f0a4c14c93245292c2a62d789@gmail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55e1e62f0a4c14c93245292c2a62d789@gmail.hu>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 17 Jul 2019 08:13:38 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 16, 2019 at 03:10:26PM +0200, Istvan Gabor wrote:
> Dear util-linux developers:
> 
> I'v been using cfdisk and fdisk for a long time.
> Currently I have util-linux 2.31.1 in openSUSE Leap 42.3.
> 
> Recently I've run into this issue:
> 
> I use USB hard drive docker and the system gets
> false optimal_io_size values for hard drives.
> 
> For a detailed description of the problem, see:
> 
> Linux SSD partition alignment – problems with external USB-to-SATA
> controllers – I
> 
> https://linux-blog.anracom.com/2018/12/03/linux-ssd-partition-alignment-problems-with-external-usb-to-sata-controllers-i/
> 
> I wanted to use fdisk for partitioning a 1 TB disk.
> fdisk wanted to start the first partition at sector
> 65535 (based on the wrong optimal_io_size value, I
> guess). I tried to overwrite the suggested value with
> 2048 but got "value out of range" error.

Since v2.27 we use this patch:
https://github.com/karelzak/util-linux/commit/acb7651f8897ae73d0f45dd75bc87630001c61b9

to ignore misaligned optimal I/O size, so the question is why your
fdisk follows 65535 (it would be nice to have output from 
"LIBFDISK_DEBUG=all fdisk -l <device>").

Anyway, you can move begin of the first partition in expert menu ('x')
by command 'b'.

It's also possible to use --sector-size, this option overrides logical
and physical sector size, and internally used io-size.

> My point is that fdisk insist to use its suggested
> value and don't let the user set other value.
> 
> In my opinion it is a bad policy, the program
> should allow to overwrite the suggested value
> and use it. If it is dangerous, then there should

It would be possible to add --set-io-{min,opt,...} command line
options, I'll think about it but it's Pandora's box...

> be a specific option to enable the behavior or
> double check if the user really wants to use the
> value entered. But it should be possible to use
> other values than the offered ones, especially if the
> offered value is wrong.

The problem is that the rest of the system (mkfs, LUKS, DM/lvm, ...)
still see wrong IO limits. The right way is to fix kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
