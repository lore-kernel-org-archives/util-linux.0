Return-Path: <SRS0=LbFG=PS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFDDC43387
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 11:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897A4214C6
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 11:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfAJLWx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:22:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfAJLWw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 Jan 2019 06:22:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B4C4A796E2;
        Thu, 10 Jan 2019 11:22:52 +0000 (UTC)
Received: from ws.net.home (ovpn-116-60.ams2.redhat.com [10.36.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00FC160139;
        Thu, 10 Jan 2019 11:22:51 +0000 (UTC)
Date:   Thu, 10 Jan 2019 12:22:49 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jonny Grant <jg@jguk.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: fdisk Ctrl+C
Message-ID: <20190110112249.hem6qvd7jqzzvhxg@ws.net.home>
References: <9bf2cc25-1b6a-88ae-c293-7a613b1255d8@jguk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf2cc25-1b6a-88ae-c293-7a613b1255d8@jguk.org>
User-Agent: NeoMutt/20180716-1022-6b9065-dirty
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 11:22:52 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jan 09, 2019 at 06:01:18PM +0000, Jonny Grant wrote:
> 1. Could Ctrl+C be added to get out of changing a partition type?

Implemented.

> 2 Could the partition code check that it is hex. At the moment if I type 'q'
> I get partition type 0.

Fixed.

> 3.
> For partition type 0, which is called "Empty" probably this message should
> say "Empty" and not 'unknown' ?

Works for me now.

Thanks for your report.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
