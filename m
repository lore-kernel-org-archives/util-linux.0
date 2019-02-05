Return-Path: <SRS0=v0jn=QM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68F0C282CB
	for <util-linux@archiver.kernel.org>; Tue,  5 Feb 2019 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7B22083B
	for <util-linux@archiver.kernel.org>; Tue,  5 Feb 2019 09:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfBEJAf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:00:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725952AbfBEJAf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 Feb 2019 04:00:35 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E641DC03BD54;
        Tue,  5 Feb 2019 09:00:34 +0000 (UTC)
Received: from ws.net.home (ovpn-204-77.brq.redhat.com [10.40.204.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 211B760CCE;
        Tue,  5 Feb 2019 09:00:33 +0000 (UTC)
Date:   Tue, 5 Feb 2019 10:00:31 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] refactor mnt_fstype_is_pseudofs()?
Message-ID: <20190205090031.llcsfd6b7wp43nu5@ws.net.home>
References: <dff8fba8-3a22-dd4a-1b75-6e636d15b2c9@suse.cz>
 <20190204140301.6oqezi7p26y2rewe@ws.net.home>
 <fefe499e-cef4-58f0-3620-59a7f5ee7324@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefe499e-cef4-58f0-3620-59a7f5ee7324@suse.cz>
User-Agent: NeoMutt/20180716-1023-ca4e12
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Feb 2019 09:00:35 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 04, 2019 at 05:38:56PM +0100, Stanislav Brabec wrote:
> > If we will keep the fstype lists in the code than we can use it as
> > the first attempt, if the name is not in the list than use your
> > heuristic.
> 
> It makes sense.

Note that source path may be a relative path without any '/'. It's
very unusual, but possible.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
