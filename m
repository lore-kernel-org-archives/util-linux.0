Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1522FF17A
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659784; cv=none; b=mID8nkp/4d7MlKUt1lkVkw+Bd+JP77nAEctO+tjKesHj7+vrlYk9dtlvdzsOvFEDj5Vx/2vO+ff1W6fO0WgKL4DcMG7b5wot7+E8QCoQqq50nAWIYDlVdrKz1YLj9jaABX9ujaQvRMbd2Hie+xAxNaJzqobVFw1WPVW/Q82nRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659784; c=relaxed/simple;
	bh=uEOPkpJdBlevVCJalAqLFvL9Q7U35O7ZcpqG+gaR1aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hominZAit08484sr0ql8s+tjPRBn+PGIh0as79PNMrH05JMq1t5/+ad3bYmxsFIw3D2xroQQiX6ONhWPimKRXrHo0zXL5O1Yaygoc1tNVvtHsgkQn4OqEtL2hNXITvP22Nx9Im6DRM7t3UmqTYhXSQCc/+mJR9xqb1LyOlDppjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps7IHEDK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps7IHEDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84091C19424;
	Wed,  8 Apr 2026 14:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775659783;
	bh=uEOPkpJdBlevVCJalAqLFvL9Q7U35O7ZcpqG+gaR1aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ps7IHEDKKmV1Jk9zoh7OWidmaHj2D8NkQmVH1XAMaAbnBAyXKboslLPMp8l6AnRBI
	 ObElx6a8H/dis3+k3zEQF58nN8SBJUaTeqxPujw2lXe83My1oKF2V+PU8ma2UDpeeK
	 LSnc+Wl3VjMMgw/qmGWsXjHb8AghzrvMW3/nlzl7gQSv4MZgrdFEUVGUjVQQ5tih69
	 huyitI2QX+b8no8z4Hku8dvLOtniF07khnLDQ0apGvcyplq2Bp8NDshZ5krqVMFgR+
	 JRb0r6RSLxVCUBAM2jTX/va5IukbKB88s6blNmrp8OKJYnTH3EcNrTXoOUtsDP7iw9
	 yVwCuZpE4+ZtA==
Date: Wed, 8 Apr 2026 16:49:39 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Zdenek Kabelac <zkabelac@redhat.com>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, amulhern@redhat.com
Subject: Re: [PATCH RFC 0/2] Fix API breakage in libblkid
Message-ID: <adZnDrqOXWtV9nUB@nidhogg.toxiclabs.cc>
References: <20260408103538.134308-1-cem@kernel.org>
 <bdb82d3c-f7b9-4d38-9a6e-8ed921c33ab9@redhat.com>
 <adZMp4mazAAc9iFZ@nidhogg.toxiclabs.cc>
 <94e57a5d-2f49-4e16-8328-5cf30b41d7ff@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e57a5d-2f49-4e16-8328-5cf30b41d7ff@redhat.com>

On Wed, Apr 08, 2026 at 03:32:14PM +0200, Zdenek Kabelac wrote:
> Dne 08. 04. 26 v 15:19 Carlos Maiolino napsal(a):
> > On Wed, Apr 08, 2026 at 01:47:27PM +0200, Zdenek Kabelac wrote:
> > > Dne 08. 04. 26 v 12:35 cem@kernel.org napsal(a):
> > > > From: Carlos Maiolino <cem@kernel.org>
> > > > 
> > So, although I agree with you that Stratis is using libblkid incorrectly,
> > I still think this patch is wrong, as it changes the library's behavior
> > to fix a problem in LVM (if there is where the race was), and not some
> > inherent library problem. If, no user can use libblkid to query into a
> > private device, then the above lib call sequence wasn't supposed to work
> > either, and perhaps then, blkid_probe_set_device() should actually fail
> > in a private device.
> > 
> > Again, I just looked into the libblkid low-level implementation today,
> > but it doesn't seem to be the library's job to be responsible for a race
> > between open() and ioctl(DM_DEVICE_REMOVE).
> > 
> 
> Hi
> 
> The main missed concept here is  -  this is not breaking any API.

I disagree... Same lib call, same device, works before your patch, does
not after... You may call it a bug that shouldn't be relied on, but
that's for sure an API breakage.

> 
> The concept of private DM device is to be a device that is not being touched
> by libblkid.  So this was a pure bug in the libblkid code when there was a
> code path skipping check (and actually doing this check after opening
> private device).

Ok, you told me from where it comes from.

How different is it of any other tool that uses libblkid doing
open(); blkid_new_probe(); blkid_probe_set_device();

Instead of calling blkid_new_probe_from_filename() directly?

Because this still can easily access a private device.

> 
> And actually IMHO there is a bigger issue -  xfs tools are actually relying
> too much on content of udev DB - this DB is by design unreliable - so it's
> likely good for some quick checking - but i.e. in lvm2 - we always do a real
> disk read -  udevDB is only advisory.

We don't do anything with udev. We use libblkid to query device's
geometry to properly configure the filesystem to be initialized there.
If blkid_new_probe_from_filename() fails, mkfs abort. It's up to the
user to pass the right device.

> 
> 
> Regards
> 
> Zdenek
> 
