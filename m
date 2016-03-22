Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbcCVQd6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 12:33:58 -0400
Date: Tue, 22 Mar 2016 17:33:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Serge van den Boom <serge+util-linux@vdboom.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Subject: Multiple issues with partx
Message-ID: <20160322163353.3w3nj5mh4f5eboq3@ws.net.home>
References: <alpine.BSF.2.00.1603151918560.60883@toad.stack.nl>
 <20160322145033.l6mus2ao7s7272ll@ws.net.home>
 <alpine.BSF.2.00.1603221648410.68855@toad.stack.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.BSF.2.00.1603221648410.68855@toad.stack.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 22, 2016 at 05:14:36PM +0100, Serge van den Boom wrote:
> Thanks. Fast resolution.
> 
> On Tue, 22 Mar 2016, Karel Zak wrote:
> > On Tue, Mar 22, 2016 at 01:17:42PM +0100, Serge van den Boom wrote:
> > > 
> > > 4. It is possible to specify a partition by the device name of a
> > >    partition on another block device.
> > > 
> > > The command 'partx /dev/sdb2 /dev/sda' makes no sense, but still
> > > produces output, namely the second partition of /dev/sda.
> > 
> >  Fixed,
> > 
> >  # partx --show /dev/sdx1 /dev/sdc
> >  partx: partition and disk name do not match
> 
> Strictly speaking, it should be the devices themselves which would need
> to match, not their names. I could create a few symlinks, and
> 'partx x0 x' would work, even when x0 and x refer to unrelated devices:
> 
>     ln -s /dev/sda x
>     ln -s /dev/sdb2 x0

This is about identification, partx does not use the device for
anything.... not sure if we have to make it more complicated.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
