Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48839 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab2KTPlK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Nov 2012 10:41:10 -0500
Date: Tue, 20 Nov 2012 15:41:06 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] wipefs: Add --force option
Message-ID: <20121120154106.GQ1444@rhmail.home.annexia.org>
References: <20121119154116.GA28909@rhmail.home.annexia.org>
 <20121120111634.GH20338@x2.net.home>
 <20121120135246.GB2006@x2.net.home>
 <20121120144111.GN1444@rhmail.home.annexia.org>
 <50AB9CB9.3040104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50AB9CB9.3040104@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 20, 2012 at 04:07:37PM +0100, Milan Broz wrote:
> On 11/20/2012 03:41 PM, Richard W.M. Jones wrote:
> 
> > In fact the problem case is where you try to wipe a device which
> > contains a volume groups and a logical volume; note the LVs don't
> > contain filesystems, and nothing is mounted.
> 
> Well there is a problem. While you can wipe part table, kernel will
> reload it and destroy all obsolete partitions.
> There should not be problem if it contains lvm, only if it contains
> active LVs mapped.
> 
> If there are active device-mapper devices (either created by kpartx,
> lvm, crypt, ...) you will lost metadata and cannot remove them
> using standard tools, you are forced to do it with dmsetup later.

I guess this is not a problem for libguestfs (virt-format in this
case), since we throw away the appliance completely after each run.
We only care about what gets written to the disk.

But yes, I see your point.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
New in Fedora 11: Fedora Windows cross-compiler. Compile Windows
programs, test, and build Windows installers. Over 70 libraries supprt'd
http://fedoraproject.org/wiki/MinGW http://www.annexia.org/fedora_mingw
