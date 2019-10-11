Return-Path: <SRS0=VVbZ=YE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A797C47404
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3D21D7A
	for <util-linux@archiver.kernel.org>; Fri, 11 Oct 2019 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfJKIbL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfJKIbL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 11 Oct 2019 04:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 73FF66B;
        Fri, 11 Oct 2019 08:31:11 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B070510495C2;
        Fri, 11 Oct 2019 08:31:10 +0000 (UTC)
Date:   Fri, 11 Oct 2019 10:31:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [BUGFIX PATCH] libmount: Add libselinux dependency to pkgconfig
 file
Message-ID: <20191011083108.rg2zlzadhfwakmfo@10.255.255.10>
References: <157077813529.32660.383807974560795120.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157077813529.32660.383807974560795120.stgit@devnote2>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Oct 2019 08:31:11 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Oct 11, 2019 at 04:15:35PM +0900, Masami Hiramatsu wrote:
>  Makefile.am          |    6 ++++++
>  libmount/mount.pc.in |    2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)

Oh, really good catch. It seems libselinux is missing there for years.

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
