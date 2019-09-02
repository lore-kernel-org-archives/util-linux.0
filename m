Return-Path: <SRS0=o1os=W5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA593C3A59E
	for <util-linux@archiver.kernel.org>; Mon,  2 Sep 2019 10:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA660217D7
	for <util-linux@archiver.kernel.org>; Mon,  2 Sep 2019 10:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfIBKB4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfIBKB4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 2 Sep 2019 06:01:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 079DA182D;
        Mon,  2 Sep 2019 10:01:56 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 545EB1001284;
        Mon,  2 Sep 2019 10:01:52 +0000 (UTC)
Date:   Mon, 2 Sep 2019 12:01:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     util-linux@vger.kernel.org, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v2] include/closestream: fix assignment to read-only
 standard streams
Message-ID: <20190902100150.mt2wwyxpmdpkn3w6@10.255.255.10>
References: <cover.1565800625.git.ps@pks.im>
 <3e5f8ff67edc6ae34ff67124c956a71dcf49ea98.1566466780.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e5f8ff67edc6ae34ff67124c956a71dcf49ea98.1566466780.git.ps@pks.im>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 02 Sep 2019 10:01:56 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 22, 2019 at 11:40:15AM +0200, Patrick Steinhardt wrote:
> Properly flushing standard streams without fclose(3P) proves to be more
> intricate than one may expect, though, as some filesystems like NFS may
> defer flushing until they see a close(3P) of the underlying descriptor.
> One may call fsync(3P) to remedy that, but this may incur a heavy
> performance penalty in some scenarios. To work around the issue and
> still get proper errors, we duplicate the stream's file descriptor and
> close that one instead, which is sufficient to cause a flush.

Applied, thanks. We'll see... :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
