Return-Path: <SRS0=IkIy=TH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D298C004C9
	for <util-linux@archiver.kernel.org>; Tue,  7 May 2019 10:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6BA206A3
	for <util-linux@archiver.kernel.org>; Tue,  7 May 2019 10:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEGKa7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 May 2019 06:30:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfEGKa7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 7 May 2019 06:30:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36514C02490F;
        Tue,  7 May 2019 10:30:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 758661FC;
        Tue,  7 May 2019 10:30:58 +0000 (UTC)
Date:   Tue, 7 May 2019 12:30:55 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Carlos A. M. dos Santos" <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Building util-linux libraries and utilities as separated
 operations
Message-ID: <20190507103055.lqamhi3qbbp4er7l@ws.net.home>
References: <CAJ4jsae=RUFEX2+2+8YG_tspTzqghMgupMfT_adYnG9b_xUVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsae=RUFEX2+2+8YG_tspTzqghMgupMfT_adYnG9b_xUVxg@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 07 May 2019 10:30:59 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 06, 2019 at 10:22:51AM -0300, Carlos A. M. dos Santos wrote:
> Would it be possible to build/install the libraries first and the
> utilities later, using the previously installed libraries? That would
> help to solve a chicken-egg problem between lsblk, and libudev, as
> described in
> 
>     https://bugs.busybox.net/show_bug.cgi?id=11811

 It always uses in-tree libs to compile in-tree utilities. 

 Anyway, all external dependencies are optional. For example you can
 compile lsblk without udev. It's also possible to specify wanted stuff, 
 for example:

     ./configure --disable-all-programs --enable-libmount \
                 --enable-libblkid --enable-libuuid

 to compile only libs.

 The best way is probably do it in two steps, in the first step
 without dependencies, and in the second step rebuild all with
 dependencies. For example:

 stage 1:
    ./configure  --without-ncurses --without-tinfo \
                 --without-python --without-systemd \
                 --without-udev

    make install

    ... compile udev, install libudev ... 

 stage 2:
    ./configure
    make install


 If I good remember distro bootstrap with util-linux is nothing unique
 and it's used by Fedora, Suse, linuxfromscratch.org, ...


 IMHO distro bootstrap is very special situation. For regular updates
 is probably better to build util-linux in build root where are
 already installed all dependencies (e.g. libudev) from previous
 versions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
