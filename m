Return-Path: <SRS0=EPkY=UG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791EFC2BCA1
	for <util-linux@archiver.kernel.org>; Fri,  7 Jun 2019 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713E208C3
	for <util-linux@archiver.kernel.org>; Fri,  7 Jun 2019 13:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbfFGN1i (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:27:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55839 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728444AbfFGN1h (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 7 Jun 2019 09:27:37 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x57DQbr3015958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jun 2019 09:26:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C359420481; Fri,  7 Jun 2019 09:26:37 -0400 (EDT)
Date:   Fri, 7 Jun 2019 09:26:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Karel Zak <kzak@redhat.com>
Cc:     Harald Dunkel <harald.dunkel@aixigo.com>,
        util-linux@vger.kernel.org
Subject: Re: careful with that umount options, Eugene
Message-ID: <20190607132636.GA19820@mit.edu>
References: <6c72d034-e172-9beb-e61b-bb74807ded0a@aixigo.com>
 <20190606125947.6rrdlkhioxx7adwl@ws.net.home>
 <20190606233147.GB23169@mit.edu>
 <20190607072003.ykquv57n3bpf2yf2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607072003.ykquv57n3bpf2yf2@ws.net.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 07, 2019 at 09:20:03AM +0200, Karel Zak wrote:
> > Hmm...  Should we also prevent a lazy unmount of the root file system?
> 
> Not sure if we want to maintain extra rule/restriction in userspace.
> Is there any reason why this feature is supported by kernel?

I certainly can't think of one.  I'll raise on linux-fsdevel; if
there's no good reason ever, I agree that it's probably better to
restrict in the kernel.

					- Ted
					
