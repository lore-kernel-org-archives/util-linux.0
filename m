Return-Path: <SRS0=Vf/c=Y6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A97C5DF62
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 09:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34A2166E
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 09:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfKFJpU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:45:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:45978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbfKFJpU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 6 Nov 2019 04:45:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2707FB40E;
        Wed,  6 Nov 2019 09:45:19 +0000 (UTC)
Date:   Wed, 6 Nov 2019 10:45:17 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191106094517.GW1384@kitsune.suse.cz>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
 <20191105171357.GV1384@kitsune.suse.cz>
 <20191106080256.GA19254@kitsune.suse.cz>
 <20191106084833.nx3agnj36brw7i42@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106084833.nx3agnj36brw7i42@10.255.255.10>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 06, 2019 at 09:48:33AM +0100, Karel Zak wrote:
> On Wed, Nov 06, 2019 at 09:02:56AM +0100, Michal Suchánek wrote:
> > > If some random program using libblkid closes the tray I don't care that
> > > much. However, many system scripts use blkid, probably to find a device
> 
> One of the random programs is udev:
> 
>    src/udev/udev-builtin-blkid.c:
> 
>        fd = open(devnode, O_RDONLY|O_CLOEXEC);

Yes, I have this on my radar. It does not seem to be used in the distro
build of systemd I use but should be addressed as well.

Thanks

Michal
