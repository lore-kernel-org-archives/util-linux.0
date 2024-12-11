Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F0232368
	for <util-linux@vger.kernel.org>; Wed, 11 Dec 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924297; cv=none; b=DxP/wwGfqNd0kPI80MGMxEB2XHLQoo+UWHghrS7oUZ3jFUuU4NiTvfyu+xlzAMLjhqbrjUpu+1KEDVh0p6kDw4/EOm/3ZfWH1/jJxp0iEY+2sgIQV0nzqMaqHKga1X0smF3Z4Z/Ji4hoR98qPvsqVVjLjWQtvOzgF+dDbJcn9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924297; c=relaxed/simple;
	bh=osGBye6tJLKL+ZDkE3Wv3GgOTxdraBC8Vhz0+zTNL5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dztg3tjZvow0K6W1CceM5yknZ3YFVlY+d15q+AGx7SRgWxb2+bndfhJ+9sgZhP6ReoNaBT3TuWXIKTYJcFTEWbctZCCdNOjbEvo7lzJzhxiy/V4AAGu8s63l+LPSTOUf+3p7/S9I3VkGOI9EqsoUJ85uvtEh0953QHLL0bs69Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=E4Qc0OgE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="E4Qc0OgE"
Received: from cwcc.thunk.org (pool-173-48-102-3.bstnma.fios.verizon.net [173.48.102.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BBDc8Uc028229
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733924290; bh=JbVS1XOq60Ot3/L/otHGoCNXB33Vd7ZA/YAqrQ2pLFM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=E4Qc0OgE0qkdAUvxPbqtC3fJGt4szDEtkF6tmzBTt92C21EpNx8PDdvLUT36AzNyY
	 8miWnlAJ4VIFAenH0AO0/yW4UW88+Fsbg4wcqBdMw7tMqX+1Mw5UtCw2tycqfxv/49
	 2d20VRTwmgY5sM4WyUXTBnZqPsnTy/aMY9a3tepksa4amsCDklc6hPDanBCReAlk17
	 h30gi5Jp5sqL9ByqFt+ptbyYbx6LbQhEl5qpQRo9KL+9Iu3ockuUoVvWk8yFim5Vyp
	 JHguFSYQZ2j0wZEuqTfHWlYBP10ev3c/l4BHUv7Cl2toiDuuC1sMJCRmTPwd3Au320
	 XvZ1p/klWJ7QA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8EA2D15C6796; Wed, 11 Dec 2024 08:38:08 -0500 (EST)
Date: Wed, 11 Dec 2024 08:38:08 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Ensuring that mount(8) will always interpret a filesystem
 correctly
Message-ID: <20241211133808.GB1912640@mit.edu>
References: <6f939e2c-7d86-4b3d-885b-2c171c944079@gmail.com>
 <zxqdvuyhtmas5apcnop7kleh2b24sboscyaosgkyqqfz4nlsdf@rmgdzivamwdw>
 <114fa16d-5908-4300-96a0-23203c7470af@gmail.com>
 <y7tl6b7pviy7ubstwprmw57ubquf777orkp56h45r7ab3xjfek@t3qjqzehfwnp>
 <155cef10-48b4-42f0-bacf-b9e1d7394206@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155cef10-48b4-42f0-bacf-b9e1d7394206@gmail.com>

On Tue, Dec 10, 2024 at 06:28:28PM -0500, Demi Marie Obenour wrote:
> >> Was https://github.com/util-linux/util-linux/issues/1305 a
> >> collision between ZFS and ext4?
> > 
> > Yes, but in this case, ZFS was incorrectly detected. As you can see
> > from the bug report, blkid ended with an "ambiguous result" error.

mke2fs (mkfs.ext4) does attempt to zero the typical locations where
conflicting superblocks might be found.  The ext4 metadata is located
at the beginning of the file system, except for the first 1k, which we
leave zero out on all platforms except for Sparc (the exact reason is
lost in the midsts of time, since it pre-exists git, but as I recall
Sparc had something critical that would cause its BIOS to lose its
marbles if we zeroed it out), and we also zero out the very end of the
disk where the MD superblock is located.

It sounds like ZFS is putting its superblock someplace random that
mke2fs ext4 doesn't know about.  If someone wants to do the research
to let me know what needs to be zeroed out to zap the ZFS superblock,
please feel to file a bug against e2fsck (or better yet, send me a
patch :-P ) and I'll be happy to add support for it.

> >> /etc/fstab provides an explicit filesystem type.  The Discoverable
> >> Partition Specification doesn't.

From what I can tell, the Discoverable Partition Table specification,
at least as defined here[1] only supports explicit file system types
supplied by the GPT partition table.

[1] https://uapi-group.org/specifications/specs/discoverable_partitions_specification/

My personal preference is this *is* the best way to do things; the
main reason why we have blkid is because of the disaster which is the
MSDOS FAT partition table, where there was only a single byte used for
the partition type, that (a) was largely ignored by other x86
operating systems, and (b) wasn't under our control, so we couldn't
define a new partition type each time we introduced a new Linux file
system.

In general, having explicit file system types, whether it is in
/etc/fstab, or in the GPT partition table, is the better way to go.
Using blkid is ideally the fallback when the best possible way doesn't
work, since it will ultimately always be a "best efforts" sort of
thing.

That being said, I suspect that if you ask, file system maintainers
will be happy to try to make things work better --- just send us a
patch or tell us what we need to do.  ZFS is not a native Linux file
system, and blkid pre-dates ZFS, so it's not something that I bothered
testing.  It doesn't help that I had absolutely zero interest in
dealing with Sun deliberately making the CDDL incompatible with the
GPL, and Larry Elison potentially trying to sue us into the ground.  :-)

Cheers,

						- Ted
