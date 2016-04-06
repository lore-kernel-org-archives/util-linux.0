Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33630 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbcDFQk7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2016 12:40:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so4840249pfe.0
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 09:40:58 -0700 (PDT)
Date: Wed, 6 Apr 2016 09:40:55 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] tests: test_md5 prints md5sum only
Message-ID: <20160406164054.GA5851@newbook>
References: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
 <20160406122615.foxdi772wqthsxfc@ws.net.home>
 <201604061433.59553.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201604061433.59553.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 06, 2016 at 01:33:58PM +0100, Ruediger Meier wrote:
> On Wednesday 06 April 2016, Karel Zak wrote:
> > On Wed, Apr 06, 2016 at 12:30:17PM +0200, Ruediger Meier wrote:
> > > We want to to use it for other tests without depending on
> > > gnu md5sum and without cut or awk.
> >
> > It does not seem like anything critical, both patches applied to the
> > next branch (will be in v2.29). Thanks.
> 
> That's ok. These patches do not fix any existing problem yet. They are 
> just one minor step to remove coreutils dependency from out tests. We 
> would still need to fix usage of readlink, seq and truncate. 

Is this for the sake of something where you cannot expect *any*
coreutils-equivalent to be installed?
If you can't expect that, can you expect the build scripts to work?

I ask because md5sum, seq, and readlink are included in every set of
base utilities I'm aware of, including coreutils, busybox, toybox,
and even sbase (the 'suckless' base utilities).
That said, seq and md5sum are only specified in the LSB, and readlink
isn't even there.

Thanks,
Isaac Dunham

