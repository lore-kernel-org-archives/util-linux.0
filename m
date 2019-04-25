Return-Path: <SRS0=oRo1=S3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E26EC43219
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A49220717
	for <util-linux@archiver.kernel.org>; Thu, 25 Apr 2019 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfDYUOO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:14:14 -0400
Received: from fieldses.org ([173.255.197.46]:51468 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfDYUON (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 25 Apr 2019 16:14:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 61C5B1C9D; Thu, 25 Apr 2019 16:14:13 -0400 (EDT)
Date:   Thu, 25 Apr 2019 16:14:13 -0400
To:     Jeff Layton <jlayton@redhat.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, abe@purdue.edu,
        lsof-l@lists.purdue.edu, util-linux@vger.kernel.org
Subject: Re: [PATCH 08/10] nfsd4: add file to display list of client's opens
Message-ID: <20190425201413.GB9889@fieldses.org>
References: <1556201060-7947-1-git-send-email-bfields@redhat.com>
 <1556201060-7947-9-git-send-email-bfields@redhat.com>
 <d26e7611f4e610bff81a16abbb88ca1c5ed70c91.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26e7611f4e610bff81a16abbb88ca1c5ed70c91.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 25, 2019 at 02:04:59PM -0400, Jeff Layton wrote:
> More bikeshedding: should we have a "states" file instead of an "opens"
> file and print a different set of output for each stateid type?

Sure.  The format of the file could be something like

	<stateid> open rw -- <openowner>...
	<stateid> lock r 0-EOF <lockowner>...
	<stateid> deleg r

I wonder if we could put owners on separate lines and do some
heirarchical thing to show owner-stateid relationships?  Hm.  That's
kind of appealing but more work.

I was only planning to do opens for the first iteration, and I think
extending later in separate files is slightly safer.

More trivial, but: it'd lengthen lines and make columns line up less
often.  But if we include a lot of long variable-length fields then
that's kinda hopeless anyway.

--b.
