Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbbEZNwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 May 2015 09:52:16 -0400
Date: Tue, 26 May 2015 11:40:40 +0200
From: Karel Zak <kzak@redhat.com>
To: 784709@bugs.debian.org, util-linux <util-linux@vger.kernel.org>
Subject: Re: when would blkid success but not filesystem type?
Message-ID: <20150526094040.GA11308@ws.net.home>
References: <20150520145904.3e4645dd@patagonia>
 <1432196678.28686.58.camel@debian.org>
 <20150521110735.GA4730@ws.net.home>
 <1432614096.2154.33.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432614096.2154.33.camel@debian.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 26, 2015 at 12:21:36PM +0800, Paul Wise wrote:
> On Thu, 21 May 2015 13:07:35 +0200 Karel Zak wrote:
> 
> > The option '-s' does not affect return code ...  we have information
> > about all (including empty) partitions!
> 
> Ok, I see. Sounds like the proposed patch is appropriate then.
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?msg=12;filename=0001-Fix-by-forcing-fs-type-to-not-detected-if-not-named.patch;att=1;bug=784709
> 
> >  Note that my recommendation is to use lsblk, for example:
> 
> That has the same issue:
> 
> $ sudo lsblk --noheading --output FSTYPE /dev/sda2 ; echo $?
> 
> 0

 Why do you want rely on return code? It is not error when 
 FS type is undefined/unknown. All you need is to check result.

  FSTYPE=$(lsblk --nodeps --noheading --output FSTYPE /dev/sda2)
  [ -n "$FSTYPE" ] && echo $FSTYPE

> I think for our purposes we would need --nodeps too.

 Yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
