Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from adsl-64-171-19-66.dsl.sntc01.pacbell.net ([64.171.19.66]:4232
	"EHLO giraffe.giraffe-data.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945999AbWLVHWF (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 02:22:05 -0500
Message-ID: <60569.bryanh@giraffe-data.com>
Date: 22 Dec 2006 07:13:47 +0000
From: bryanh@giraffe-data.com (Bryan Henderson)
To: acahalan@gmail.com
CC: kzak@redhat.com, ethanol@armory.com, ams@gnu.org, P@draigbrady.com,
        util-linux-ng@vger.kernel.org
In-reply-to: <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	(acahalan@gmail.com)
Subject: Re: splitting util-linux (was: kill)
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>
	 <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz>
	 <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
	 <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>I see rdev. If I remember right, that's used for the pre-2.6 kernels
>when you use "dd" to put a raw kernel image on a floppy.

Yeah, that's classic Unix.  I don't think it was ever actually used
much for floppy disks, because you can also just put a filesystem and
LILO on a floppy; that's what I've always done.  I didn't know they
eliminated the integrated boot loader in 2.6.

-- 
Bryan Henderson                                   San Jose, California
