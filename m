Return-Path: util-linux-owner@vger.kernel.org
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:47786 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbaBKLcK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Feb 2014 06:32:10 -0500
Date: Tue, 11 Feb 2014 11:31:39 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: util-linux@vger.kernel.org, kzak@redhat.com
Subject: Re: fallocate: Add "--dig-holes" options and minor fixes
Message-ID: <20140211113139.GA19087@sdfg.com.ar>
References: <1390677448-7173-1-git-send-email-rodrigo@sdfg.com.ar>
 <20140125192303.GA7455@sdfg.com.ar>
 <20140201040414.GA23360@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140201040414.GA23360@sdfg.com.ar>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 01, 2014 at 04:04:14AM +0000, Rodrigo Campos wrote:
> On Sat, Jan 25, 2014 at 07:23:03PM +0000, Rodrigo Campos wrote:
> > On Sat, Jan 25, 2014 at 07:17:25PM +0000, Rodrigo Campos wrote:
> > > Hi,
> > > 
> > > As discussed in this[1] gmane thread, I'm submitting the funtionality to dig
> > > holes as part of the fallocate(1) command.
> > 
> > Ohh, forgot to tell, but I tried to re-use already used strings in _("")
> > contructors and make "perror" just print the function name, as that is what I
> > observed in other util-linux tools.
> > 
> > If I missed something, please let me know :)
> 
> Ping ? :)

Re-ping ? Any comments on this ?





Thanks,
Rodrigo
