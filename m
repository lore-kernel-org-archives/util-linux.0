Return-Path: <SRS0=Z60+=UN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86941C31E44
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 07:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F57B2084E
	for <util-linux@archiver.kernel.org>; Fri, 14 Jun 2019 07:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbfFNHsd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNHsc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 14 Jun 2019 03:48:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0D1F308624B;
        Fri, 14 Jun 2019 07:48:32 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C5761001E60;
        Fri, 14 Jun 2019 07:48:31 +0000 (UTC)
Date:   Fri, 14 Jun 2019 09:48:28 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Jakowski, Andrzej" <andrzej.jakowski@intel.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [RFC] utility for SED management
Message-ID: <20190614074828.iqgomebc6gilprkn@ws.net.home>
References: <548EA37F71F6AC4BB746F459732504FF7F1810E3@FMSMSX119.amr.corp.intel.com>
 <20190612134005.cb7m2qhgf2aolrf6@ws.net.home>
 <548EA37F71F6AC4BB746F459732504FF7F184907@FMSMSX119.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548EA37F71F6AC4BB746F459732504FF7F184907@FMSMSX119.amr.corp.intel.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 07:48:32 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 13, 2019 at 01:51:12PM +0000, Jakowski, Andrzej wrote:
> On Wed, Jun 12, 2019 at 01:40:08PM +0000, Karel Zak wrote:
> > From my point of view (and maybe I'm wrong ;-)) it seems complex enough to keep it as an independent stand-alone project ("sed-utils").
> > Not sure if it makes sense to push it to generic util-linux package.
> 
> It sounds to me that your major concern for inclusion sedcli into util-linux is
> its complexity. What would be the best method to understand if sedcli fits into
> util-linux?

Do you have the current code/repo with sedcli accessible anywhere? It
would be nice to see it.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
