Return-Path: <SRS0=Em1C=T6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73654C46460
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 10:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5778125776
	for <util-linux@archiver.kernel.org>; Thu, 30 May 2019 10:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfE3Kfh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 30 May 2019 06:35:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3Kfh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 30 May 2019 06:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5083EF9E85;
        Thu, 30 May 2019 10:35:37 +0000 (UTC)
Received: from ws (unknown [10.40.205.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA0F19748;
        Thu, 30 May 2019 10:35:36 +0000 (UTC)
Date:   Thu, 30 May 2019 12:35:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.34-rc2
Message-ID: <20190530103533.ttiwfhkv4nw7mokx@ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 30 May 2019 10:35:37 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux release v2.34-rc2 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.34/

Feedback and bug reports, as always, are welcomed.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
