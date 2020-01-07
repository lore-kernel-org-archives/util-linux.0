Return-Path: <SRS0=/iJD=24=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3452BC33C8C
	for <util-linux@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC462073D
	for <util-linux@archiver.kernel.org>; Tue,  7 Jan 2020 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGQTV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:19:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:56350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgAGQTV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 7 Jan 2020 11:19:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1986ADFE;
        Tue,  7 Jan 2020 16:19:19 +0000 (UTC)
Date:   Tue, 7 Jan 2020 17:19:18 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20200107161918.GX4113@kitsune.suse.cz>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20200107160443.y72na25i5fk72zqt@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107160443.y72na25i5fk72zqt@10.255.255.10>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 07, 2020 at 05:04:43PM +0100, Karel Zak wrote:
> On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> > When autoclose is set (kernel default but many distributions reverse the
> > setting) opening a CD-rom device causes the tray to close.
> 
> I found unwanted side effect, open() with O_NONBLOCK also successes
> when there is no medium. Unfortunately, we ignore I/O errors for
> CDROMs to support some crazy hybrid media -- so overall result is many
> I/O warnings in system logs.
> 
> I have added CDROM_DRIVE_STATUS to the logic to stop probing when
> there is no medium. Let's hope it will be enough:
> 
> https://github.com/karelzak/util-linux/commit/dc30fd4383e57a0440cdb0e16ba5c4336a43b290

It it probably safer to do
switch (ioctl(fd, CDROM_DRIVE_STATUS, CDSL_CURRENT)) {
to support some crazy CD changers.

Thanks

Michal
