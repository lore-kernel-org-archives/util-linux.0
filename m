Return-Path: dsterba@suse.cz
Date: Fri, 22 Jan 2016 09:42:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
Message-ID: <20160122084245.GR4227@suse.cz>
Reply-To: dsterba@suse.cz
References: <569FEF38.9010102@suse.cz>
 <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz>
 <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A0F847.5000000@suse.cz>
 <20160121153713.erxzeieqtnsf2wsu@ws.net.home>
 <20160121154529.hpv3ycl2syptemp4@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160121154529.hpv3ycl2syptemp4@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 21, 2016 at 04:45:29PM +0100, Karel Zak wrote:
> On Thu, Jan 21, 2016 at 04:37:13PM +0100, Karel Zak wrote:
> > > David also wrote btrfs_get_default_subvolume_path(), but then we found,
> > > that there is probably better to use subvolid and path saved in
> > > procinfo:
> > 
> > Do you mean /proc/self/mountinfo ?
> > 
> > > 
> > > + The tab.c patch would be much smaller and straightforward.
> > > - Kernel evaluates it when creating procinfo entries, this would
> > >   duplicate it.
> > > x Both subvol and subvolid in procinfo were introduced together in the
> > >   mainline kernel, and btrfs_get_default_subvolume_path() needs more
> > >   ioctl() calls.
> > 
> > No sure if I follow.
> 
> Read it and the patch again, and now it makes sense. Yes, the ioctl and 
> subvolid= from mountinfo seems better than dependence on libbtrfs.

Also because util-linux is a build dependency for btrfs-progs.
