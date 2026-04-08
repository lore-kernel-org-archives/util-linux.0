Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9532D0CC
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654353; cv=none; b=o2B/jMxhT/8LkewBhyo64j1FckXhZVfUruQGt7WAElWPtngvVALnzl+SnWmXzpWtAvjhW22qp9L7ihxIpJ9OnQygMFqWlOUo6GiYhQTDN+zXmAAz41IdnXDS6GMVkS+H/L1VjkyuhKXe2FtEhrpQ7srhG6MQpwbvnvOfK4E25Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654353; c=relaxed/simple;
	bh=DcJskTmSV2bpu5xyQdrJdPWAzGaYway9KpMY7BFNgOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/T41BFm4oNV3EYChAK1fKe58FD3xosvjZBDoxoHoCD/6Q9u0VTdRdu1nHJ8EnK+GNcOvP2FrDMuZmdsyPUXO9Wzj0OxPYml/WJFDTW64hcqhKMDU3S3xApsM6GYhSgYdw/xdE3s5MgC3OijeFS0faAZqW5U0P3awxseTq25GbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHmnswNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHmnswNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3328BC2BCB2;
	Wed,  8 Apr 2026 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775654353;
	bh=DcJskTmSV2bpu5xyQdrJdPWAzGaYway9KpMY7BFNgOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHmnswNKM99zkz0KGcRq8Z61abrwhJh2gzJ9do97K4yKXCDi2dJqPZjBiHu3GCBPI
	 ZSIyZp/3i0pW9mhMzA1IgD2600pYP/t8wFTZhU5+kknoxWEtrtB+/aWGLYgfThJsDQ
	 uE3S6bUp0sfs1c2OtaIXsPLxL71pGDBXNYFUV+2sXZOh+vBhhIXXPpMVcp5AntIbfR
	 5fCFWzCn09Gm1uGeiTLl+gTAe1zt1+qMCfuyB/zipWLcs6tdUgjKQclHl+fMjnIQzX
	 Qyztas/SvoEacUp8amPy1/FCYNJoNu5W1PUyy9v2I8pfDuVHqGPM19xWxCwjx97r4R
	 jhaI0oe/KQh2Q==
Date: Wed, 8 Apr 2026 15:19:09 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Zdenek Kabelac <zkabelac@redhat.com>
Cc: kzak@redhat.com, util-linux@vger.kernel.org, amulhern@redhat.com
Subject: Re: [PATCH RFC 0/2] Fix API breakage in libblkid
Message-ID: <adZMp4mazAAc9iFZ@nidhogg.toxiclabs.cc>
References: <20260408103538.134308-1-cem@kernel.org>
 <bdb82d3c-f7b9-4d38-9a6e-8ed921c33ab9@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdb82d3c-f7b9-4d38-9a6e-8ed921c33ab9@redhat.com>

On Wed, Apr 08, 2026 at 01:47:27PM +0200, Zdenek Kabelac wrote:
> Dne 08. 04. 26 v 12:35 cem@kernel.org napsal(a):
> > From: Carlos Maiolino <cem@kernel.org>
> > 
> > Patch d05a84b22e54 ("libblkid: check for private DM device before open")
> > broke blkid_new_probe_from_filename() API.
> > 
> > Before the patch users were able, via the low-level API, to open and
> > create blkid probes via the device's filename even from private
> > device-mapper devices.
> > 
> 
> Hi
> 
> So I'm not sure how it happened that Stratis kind of 'reuses'  libdm private
> logic we have embedded into util-linux - but something wrong is likely
> happening on Stratis side here.
> 
> For  libdm  & util-linux - there is basic principle - when udev should be
> scanning  a 'DM' device that is supposed to be private - in our case it's
> uuid with  "LVM-"  prefix and "-anysuffix:  - such device is supposed to be
> NOT touched by any udev rule logic - it's private - so nothing should be
> 'randomly' opening a device at unpredictable moments..
> 
> Somehow it seems Stratis selected to use similar notion (at least when I
> look there in  sysfs_devno_is_dm_private()  - there is check for uuid:
> "stratis-1-private"

Thanks for the details. Indeed I noticed sysfs_devno_is_dm_private()
skipping 'stratis-1-private' suffixed devices, but to be honest, their
functionality is opaque to me, I don't really know what they mean or how
they are used.
I got a report that mkfs.xfs stopped working for them, and my investigation
led to this subtle behavior change in blkid_new_probe_from_filename().

So, IIUC what you're saying, stratis shouldn't be using devices they
flag as private the way they are using, so I agree, and perhaps their
understanding of what a private device means is wrong and not using the
API properly.

On the other hand though -- playing The Devil's Advocate a bit --, this
is still a subtle API break and I don't think your patch is the right
way to fix the race you're seeing.

I honestly couldn't find any information about it, whether
blkid_new_probe_from_filename() could be used or not with private
devices, the only thing I really see (from a user perspective) was the
library call not working as before.

Also, reading what you explained above regarding the usage, I think I
was right when I said this is not the right way to fix the race you
mentioned. Because the race is still there, it is now just hidden for
LVM's specific use case.

Quoting libblkid documentation for blkid_new_probe_from_filename():

"
This function is same as call open(filename), blkid_new_probe()
and blkid_probe_set_device(pr, fd, 0, 0).
"

This was exactly how I "fixed" xfsprogs to allow Stratis behavior to
continue the way it is. Which by your explanation above is incorrect,
as is the same sequence call that you mentioned that should not be
allowed... open() the device then probe_set_device()... Which tells me
that any libblkid user following this same sequence is fundamentally
broken.

So, although I agree with you that Stratis is using libblkid incorrectly,
I still think this patch is wrong, as it changes the library's behavior
to fix a problem in LVM (if there is where the race was), and not some
inherent library problem. If, no user can use libblkid to query into a
private device, then the above lib call sequence wasn't supposed to work
either, and perhaps then, blkid_probe_set_device() should actually fail
in a private device.

Again, I just looked into the libblkid low-level implementation today,
but it doesn't seem to be the library's job to be responsible for a race
between open() and ioctl(DM_DEVICE_REMOVE).

Cheers,
Carlos

> 
> 
> > This change broke Stratis project and xfsprogs.
> > xfsprogs uses blkid_new_probe_from_filename() to gather topology
> > information from the device, and the above mentioned change now prevents
> 
> If the private is not meant to be private -  just drop:
> 
> 	} else if (strncmp(id, "stratis-1-private", 17) == 0) {
> 		rc = 1;
> 	}
> 
> from sysfs_devno_is_dm_private()
> 
> > it to be done on device-mapper private devices, as Stratis does by
> > attempting to initialize a XFS filesystem on it.
> > 
> > > I don't think the last statement here is correct.
> > blkid_probe_set_device() marks the probe as BLKID_FL_NOSCAN_DEV, but it
> > does not error out, so, for low-level API calls, we simply ended up
> > with a probe with BLKID_FL_NOSCAN_DEV set. But the call succeeded and we
> > ended up with a probe to use and query device's information.
> 
> Please don't try to break original LVM logic which was the main reason why
> sysfs_devno_is_dm_private() even exists in the first place.
> 
> > As far as I understood it, the patch aimed to close a possible race
> > window when issuing a DM_DEVICE_REMOVE ioctl() to the same device being
> > probed by blkid_new_probe_from_filename().
> > 
> 
> Yes - but there is higher logic behind - private  'device' is private and
> should not be randomly opened by any tool.
> 
> > As for xfsprogs, I have a patch which 'fixes' it replacing
> > blkid_new_probe_from_filename() by blkid_probe_set_device(), but this is
> > just taping over the root cause, which is the API breakage.
> 
> I think main problem is that Stratis  mangled  'private' meaning in some way.
> 
> So let's fix Stratis instead of breaking correct logic in util-linux made
> for lvm2.
> 

