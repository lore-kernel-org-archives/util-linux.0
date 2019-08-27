Return-Path: <SRS0=xJlx=WX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A04C3A5A3
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118A7206BF
	for <util-linux@archiver.kernel.org>; Tue, 27 Aug 2019 12:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfH0MbI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:31:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfH0MbH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Aug 2019 08:31:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA76410C6355;
        Tue, 27 Aug 2019 12:31:07 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECAD16092D;
        Tue, 27 Aug 2019 12:31:06 +0000 (UTC)
Date:   Tue, 27 Aug 2019 14:31:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tests: remove reliance on buffer behaviour of
 stderr/stdout streams
Message-ID: <20190827123104.vnokwyotwudpjqlp@10.255.255.10>
References: <cover.1566555078.git.ps@pks.im>
 <cover.1566566906.git.ps@pks.im>
 <d503b30d13c847040a8343f0e7299ae1bf7cb120.1566566906.git.ps@pks.im>
 <20190827111748.g4o375ya2shfrivs@10.255.255.10>
 <20190827115512.GB131601@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827115512.GB131601@ncase>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Tue, 27 Aug 2019 12:31:07 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 27, 2019 at 01:55:12PM +0200, Patrick Steinhardt wrote:
> Noticed one more thing. In the parameter parsing step, we check
> `type stdbuf` while we actually use unbuffer later. I guess the
> first check should now be `type unbuffer`, right?

Fixed. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
