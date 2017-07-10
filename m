Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbdGJLwl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Jul 2017 07:52:41 -0400
Date: Mon, 10 Jul 2017 13:52:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: ID_FS_VERSION
Message-ID: <20170710115236.c45ivf43w5cjvfxm@ws.net.home>
References: <201707051349.26662@pali>
 <20170710110828.r6dr6buolw4xtgpm@ws.net.home>
 <20170710111509.GB560@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170710111509.GB560@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 10, 2017 at 01:15:09PM +0200, Pali Rohár wrote:
> On Monday 10 July 2017 13:08:28 Karel Zak wrote:
> > On Wed, Jul 05, 2017 at 01:49:26PM +0200, Pali Rohár wrote:
> > > Hi! What is the meaning of the ID_FS_VERSION attribute? I'm trying to 
> > > find documentation about libblkid attributes, but seems there is none.
> > 
> > libblkid/src/superblocks/superblocks.c
> > 
> >    * @VERSION: filesystem version
> > 
> > :-)
> 
> That does not provide more information :-)
> 
> > Well, the field is to provide more details about the filesystem, for
> > example we have VERSION="FAT16" TYPE="vfat", and so on. Note that TYPE
> > is usually name used by kernel (to be usable for "mount -t <type>").
> > 
> > I guess the VERSION is used by some userspace stuff (udisks?) to get
> > more information (or provide more details to end-users). It's probably
> > nothing critical.
> 
> I'm thinking if we can provide UDF revision/version of UDF filesystem to
> userspace and looks like ID_FS_VERSION is good candidate for it...
> 
> What do you think?

It seems blkid_probe_set_version() is nowhere used for UD now, so we have
absolute freedom to use it in some way.

> E.g. Linux kernel is able to read UDF filesystem up to revision 2.50 and
> has read-write support up to revision 2.01. So for userspace this
> information can be useful.

Yes, sounds good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
