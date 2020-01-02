Return-Path: <SRS0=BVA9=2X=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EEC2D0DE
	for <util-linux@archiver.kernel.org>; Thu,  2 Jan 2020 00:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4197E20672
	for <util-linux@archiver.kernel.org>; Thu,  2 Jan 2020 00:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgABARY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Jan 2020 19:17:24 -0500
Received: from inpost.hi.is ([130.208.165.62]:37166 "EHLO inpost.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgABARY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Jan 2020 19:17:24 -0500
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 0020HGDV020958
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Jan 2020 00:17:16 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 0020HGDV020958
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 0020HGI7031524;
        Thu, 2 Jan 2020 00:17:16 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 0020HF0A031523;
        Thu, 2 Jan 2020 00:17:15 GMT
Date:   Thu, 2 Jan 2020 00:17:15 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     J William Piggott <elseifthen@gmx.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: howto-man-page.txt: Use font macros instead of font
 escapes
Message-ID: <20200102001715.GA30885@rhi.hi.is>
References: <20191216222032.GA25430@rhi.hi.is>
 <nycvar.YAK.7.76.1912171449170.1929@zhn.tzk.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YAK.7.76.1912171449170.1929@zhn.tzk.pbz>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Dec 17, 2019 at 03:43:15PM -0500, J William Piggott wrote:
> 
> 
> On Mon, 16 Dec 2019, Bjarni Ingi Gislason wrote:
> 
> > Use font macros instead of font escapes (\f[BIPR]).
> >
[...]
> I wish you luck. I tried to convince this project that inline escapes should be
> avoided, but everyone here seems to be in love with them. I had them all
> stripped out of hwclock(8), but another contributor kept insisting on putting
> them back. I finally gave up and started using them too.
> 

  No reason to give up.
Comment the font-escape line and
add the font-macro line after it.
People need to see the difference easily.

> >
> >###
> > Changes based on:
> >
> > Use a macro to change to the italic font,
> >instead of \fI [1], if possible.
> > The macros have the italic corrections,
> >but "\c" removes the "\/" part.
> >
> > Or
> >
> >add the italic corrections.
> >[1] man-pages(7) [Debian package "manpages"]
> 
> That must be Debian hack, but Michael should adopt a no inline-escape policy
> for the man page project, IMO. Although it shouldn't limited to italic.
> 

  My pointing to reference [1] is wrong,
as there is no instruction about using a macro
instead of a font escape request.

> >
[...]
> >.SH OPTIONS
> >.TP
> >-\fB\-n\fR, \fB\-\-no\-argument\fR
> >+.BR \-n ,\  \-\-no\-argument
> >+.\" \fB\-n\fR, \fB\-\-no\-argument\fR
> 
> Remove the old, don't comment it.
> Same for below.
> 

  Showing the commented out font-escape line is better,
so that the reader sees the difference and
how the transformation is made.
  The commented old line should come first
to prepare the user for the changed (maybe strange) line.

  I find now the use of escaped space (,\ ) worse
than using a quotation (", ").

[...]

-- 
Bjarni I. Gislason
