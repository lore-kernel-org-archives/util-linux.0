Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33476 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbcBVKMf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Feb 2016 05:12:35 -0500
Date: Mon, 22 Feb 2016 11:12:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add test for loop option in fstab
Message-ID: <20160222101233.imyhujomel6ydin3@ws.net.home>
References: <56BCE4F4.6020409@suse.cz>
 <201602151242.10369.sweet_f_a@gmx.de>
 <20160216144918.iqmvz27qggxfnjng@ws.net.home>
 <56C75E7B.60407@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56C75E7B.60407@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 19, 2016 at 07:27:07PM +0100, Stanislav Brabec wrote:
> On Feb 16 2016 at 15:49 Karel Zak wrote:
> > On Mon, Feb 15, 2016 at 12:42:10PM +0100, Ruediger Meier wrote:
> >> On Thursday 11 February 2016, Stanislav Brabec wrote:
> >>> Add a new fstab tests which check loop mount of the same source
> >>> multiple times in multiple steps.
> >>
> >> This test still fails if /etc/mtab is a regular file.
> > 
> > The problem should be fixed now. Thanks!
> > 
> Well, not for btrfs. See the new testcase below (ready for inclusion to the
> GIT).

Do you mean when /etc/mtab is a regular file? For btrfs we need fs
root and this information is nowhere in mtab (and maybe another
information related to subvolumes which we have in mountinfo).

Not sure if we really need to support this complicated use-case with
deprecated mtab.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
