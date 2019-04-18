Return-Path: <SRS0=6ps2=SU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E9C10F0E
	for <util-linux@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5519E206B6
	for <util-linux@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbfDRJJk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:09:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388526AbfDRJJi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Apr 2019 05:09:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0225309EFFC;
        Thu, 18 Apr 2019 09:09:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3644F19C79;
        Thu, 18 Apr 2019 09:09:37 +0000 (UTC)
Date:   Thu, 18 Apr 2019 11:09:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     StuartIanNaylor <rolyantrauts@gmail.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20190418090934.y7jp7ii4l72hhlgz@ws.net.home>
References: <92179e5f-d73e-974c-774e-09c2813434c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92179e5f-d73e-974c-774e-09c2813434c0@gmail.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 09:09:38 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 18, 2019 at 08:59:54AM +0100, StuartIanNaylor wrote:
> A strange thing happens with zramctl as if all services where running the
> high order zram device of zramdrive is no longer visible after removing
> lower order devices.

Sounds like https://github.com/karelzak/util-linux/issues/521, fixed
in version 2.31

> Its Raspbian 4.14 with util-linux 2.29.2

The current upstream is 2.33.2 :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
