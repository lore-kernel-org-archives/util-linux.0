Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:47857 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaBKSoU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Feb 2014 13:44:20 -0500
Date: Tue, 11 Feb 2014 18:43:49 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fallocate: Add "--dig-holes" options and minor fixes
Message-ID: <20140211184349.GE19370@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140125192303.GA7455@sdfg.com.ar>
 <20140201040414.GA23360@sdfg.com.ar>
 <20140211113139.GA19087@sdfg.com.ar>
 <20140211183408.GV8506@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140211183408.GV8506@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 11, 2014 at 07:34:08PM +0100, Karel Zak wrote:
> On Tue, Feb 11, 2014 at 11:31:39AM +0000, Rodrigo Campos wrote:
> > On Sat, Feb 01, 2014 at 04:04:14AM +0000, Rodrigo Campos wrote:
> > > On Sat, Jan 25, 2014 at 07:23:03PM +0000, Rodrigo Campos wrote:
> > > > On Sat, Jan 25, 2014 at 07:17:25PM +0000, Rodrigo Campos wrote:
> > > > > Hi,
> > > > > 
> > > > > As discussed in this[1] gmane thread, I'm submitting the funtionality to dig
> > > > > holes as part of the fallocate(1) command.
> > > > 
> > > > Ohh, forgot to tell, but I tried to re-use already used strings in _("")
> > > > contructors and make "perror" just print the function name, as that is what I
> > > > observed in other util-linux tools.
> > > > 
> > > > If I missed something, please let me know :)
> > > 
> > > Ping ? :)
> > 
> > Re-ping ? Any comments on this ?
> 
>  Be patient, the patches seem good, I'm going to merge it this or next

Sure, no problem! :)

>  week. (I was busy with something else last weeks and now I have
>  vacation.)

Please, have a rest :)






Thanks a lot,
Rodrigo
