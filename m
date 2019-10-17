Return-Path: <SRS0=BLRm=YK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF6ECE58E
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9720869
	for <util-linux@archiver.kernel.org>; Thu, 17 Oct 2019 10:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391534AbfJQK5R (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbfJQK5R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Oct 2019 06:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 523133083363;
        Thu, 17 Oct 2019 10:57:17 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C93219C68;
        Thu, 17 Oct 2019 10:57:15 +0000 (UTC)
Date:   Thu, 17 Oct 2019 12:57:13 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/path: fix missing header for `struct stat`
Message-ID: <20191017105713.wvssg3y777d566kc@10.255.255.10>
References: <60c4df91a86c6d4a1f7c811d931030b9b2f5efdb.1571292019.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c4df91a86c6d4a1f7c811d931030b9b2f5efdb.1571292019.git.ps@pks.im>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 17 Oct 2019 10:57:17 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Oct 17, 2019 at 08:00:31AM +0200, Patrick Steinhardt wrote:
>  include/path.h | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
