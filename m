Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx11-mx.siemens-enterprise.com ([62.134.46.9]:60474 "EHLO
	senmx11-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030254Ab2EPLS5 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 May 2012 07:18:57 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Date: Wed, 16 May 2012 13:18:54 +0200
Subject: RE: [PATCH 2/2] blkid: introduce symbolic names for different blkid
 exit codes
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F1E5D23A6@MCHP058A.global-ad.net>
References: <1337157512-31920-1-git-send-email-petr.uzel@suse.cz>
 <1337157512-31920-2-git-send-email-petr.uzel@suse.cz>
 <7856072A9D04C24B82DFE2B1112FE38A0F1E5D2336@MCHP058A.global-ad.net>
 <20120516092408.GA3670@foxbat.suse.cz> <20120516101346.GR8268@x2.net.home>
In-Reply-To: <20120516101346.GR8268@x2.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Wed, May 16, 2012 at 11:24:09AM +0200, Petr Uzel wrote:
> > Hmm, the return value depends only on the last argument (device). I
> > don't think this is intentional. Karel?
> > 
> >         # blkid -p /dev/sda /dev/sdb ; echo $?
> >         /dev/sda: PTTYPE="gpt" 
> >         error: /dev/sdb: No such file or directory
> >         2
> >         
> >         # blkid -p /dev/sdb /dev/sda ; echo $?
> >         error: /dev/sdb: No such file or directory
> >         /dev/sda: PTTYPE="gpt" 
> >         0
> 
>  It would be better to break the loop and exit after first error.

Then we can already exit() from lowprobe_device(),
and thus BLKID_EXIT_* will have become pure "exit codes" ... ;-)

Have a nice day,
Berny