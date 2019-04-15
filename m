Return-Path: <SRS0=jIJg=SR=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B0C10F0E
	for <util-linux@archiver.kernel.org>; Mon, 15 Apr 2019 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FF220656
	for <util-linux@archiver.kernel.org>; Mon, 15 Apr 2019 09:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfDOJP4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfDOJPz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Apr 2019 05:15:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0AE5308404C;
        Mon, 15 Apr 2019 09:15:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 581CE19C57;
        Mon, 15 Apr 2019 09:15:54 +0000 (UTC)
Date:   Mon, 15 Apr 2019 11:15:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     util-linux@vger.kernel.org, Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Shuichi Ihara <sihara@ddn.com>
Subject: Re: [PATCH] fstrim: get realpath before trim ioctl
Message-ID: <20190415091551.edz4tboc6jsklgaq@ws.net.home>
References: <1555212716-22911-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555212716-22911-1-git-send-email-wshilong1991@gmail.com>
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 15 Apr 2019 09:15:55 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Apr 14, 2019 at 12:31:56PM +0900, Wang Shilong wrote:
>  sys-utils/fstrim.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
