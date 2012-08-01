Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47799 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab2HAKcv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 06:32:51 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q71AWoRX028261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 06:32:51 -0400
Date: Wed, 1 Aug 2012 12:32:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Niels de Vos <ndevos@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] mount: overwrite options from /etc/fstab when given on the
 commandline
Message-ID: <20120801103248.GA7670@x2.net.home>
References: <1343812301-24896-1-git-send-email-ndevos@redhat.com>
 <20120801094833.GC1019@x2.net.home>
 <20120801100316.GD1019@x2.net.home>
 <5019017E.4050704@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5019017E.4050704@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 01, 2012 at 12:14:22PM +0200, Niels de Vos wrote:
> On 08/01/2012 12:03 PM, Karel Zak wrote:
> > On Wed, Aug 01, 2012 at 11:48:33AM +0200, Karel Zak wrote:
> >>> Some options are not allowed to be
> >>> passed multiple times (like the SElinux context options) and mounting will fail
> >>> if options are present in both /etc/fstab and on the commandline.
> >>
> >> This is stupid SELinux disadvantage and SELinux should be fixed.
> >
> > Note that mount(8) and libmount removes all selinux context options on
> > remount for kernels<  2.6.39 because SELinux context remount was
> > unsupported, so this SELinux disadvantage should be hidden for usual
> > use case.
> >
> > Maybe we can also add another exception for SELinux to de-duplicate
> > the SELinux context options in the options string. It's not perfect,
> > but probably acceptable for SELinux -- I can do this for 2.22-rc2.
> 
> That would be great. What is your opinion on getting the SElinux options
> handled differently in the kernel instead or in addition? 

SELinux is no filesystem and we already have (must have) SELinux
specific code in mount(8) (and many others utils;-).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
