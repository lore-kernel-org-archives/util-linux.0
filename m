Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbaB1JEb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 28 Feb 2014 04:04:31 -0500
Date: Fri, 28 Feb 2014 10:04:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: chcpu exit code?
Message-ID: <20140228090418.GA2783@x2.net.home>
References: <530F0972.3040205@bernhard-voelker.de>
 <20140228075355.GB4216@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140228075355.GB4216@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 28, 2014 at 08:53:55AM +0100, Heiko Carstens wrote:
> On Thu, Feb 27, 2014 at 10:46:26AM +0100, Bernhard Voelker wrote:
> > Although the man page does not mention the exit status, I think
> > it's wrong that 'chcpu' exits OK when an action failed or
> > when a bad CPU number was specified:
> > 
> >   $ ./chcpu -d 0 ; echo $?
> >   CPU 0 is not hot pluggable
> >   0
> > 
> >   $ ./chcpu -g 3 ; echo $?
> >   CPU 3 is not configurable
> >   0
> > 
> >   $ ./chcpu -e 4 ; echo $?
> >   CPU 4 does not exist
> >   0
> > 
> > WDYT?
> 
> The question is: what should chcpu return if it partially succeeded?
> 
> # chcpu -d 3-4
> CPU 3 disabled
> CPU 4 does not exist

 This is not so unusual situation, we have for example the same thing
 in mount -a where

   0 - success
  32 - mount failure
  64 - some mount succeeded

I think we can do something like this with chcpu, my suggestion is

   0 - success
   1 - failure
  64 - partial success

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
