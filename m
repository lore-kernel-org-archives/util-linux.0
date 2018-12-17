Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D98C43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2E2086C
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 09:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbeLQJsn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:48:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732057AbeLQJsn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 04:48:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4252F81F0F;
        Mon, 17 Dec 2018 09:48:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.118.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 826665C21C;
        Mon, 17 Dec 2018 09:48:42 +0000 (UTC)
Date:   Mon, 17 Dec 2018 10:48:39 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jean-Philippe ROMAIN <jean-philippe.romain@st.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: correct "-n, --console-level level" example in
 manual page
Message-ID: <20181217094839.tr2datbuqyjze54v@ws.net.home>
References: <1545035454-30986-1-git-send-email-jean-philippe.romain@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545035454-30986-1-git-send-email-jean-philippe.romain@st.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 09:48:43 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 17, 2018 at 09:30:54AM +0100, Jean-Philippe ROMAIN wrote:
> When providing an abbreviation of the level name with the option "-n, --console-level level",
> it corresponds to the level (included) up to which messages are displayed on the console.
> If a level number is given, this level is excluded.
> 
> So in the given example, "-n 1" is equivalent to "-n emerg".

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
