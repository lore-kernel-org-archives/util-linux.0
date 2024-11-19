Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568431D14E2
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038631; cv=none; b=tEPyA3xdX4F12cDChFvPy4zVzYW1IFQvVVGJLTSU7SAmynvStoEQ0JJex1ne1zOHJtE25byvbAOCPdTzvqA+zyUcOjq6gv+4inw+b8VSLyjAnPHgY47ubaJSofTc13xxtRvxKs6uwF7k3Auo1Jkien0KMmtWnKXWFjMDEv6pdJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038631; c=relaxed/simple;
	bh=zPG1oeFjQEojWqRTatYms9PiU5uufrMX3hsBiUV5f78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbSZnASX6aJcCWOU/bW9eoeMfNXiuZrNw35s5W0SO93QzFrUhpfcF0pGR0q99BjYpBaGwTl28ts8HztxfURYWZ5Lgj0hlfajNL3zJDbZn/M6HZ3xfMdWucNcQjY+M5ssazTj4kSMPULiasVMz1mXr1nSd8JtFoGswTVUyXH9LrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=kdsfM8Sk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="kdsfM8Sk"
Received: from macsyma.thunk.org ([50.204.137.16])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AJHnvQP007667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 12:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732038601; bh=TgNdenoYz7kqkgkpYYYAooEzfNGCR2HMmgVMFDPOXtU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=kdsfM8Sk0p8bLMYB7XI9B9uh18ZoKr3VPDvRAbMgzHzQseMHJehXSbPzZYCQcBzrR
	 juExl1WClqmEGeBCpNA678BKeaOYZX4eJwdIKkFpCNQrvh7PXK1TzFP415+u33E1zn
	 L7Su9+Mr5ZC1VATg0L7SG1ATC2kydqVnZxca/AyO7QCUtped177viOsda15oz4TnX5
	 /IJ/ZweaVxXs7Tn+RgD80IzBrtbxagcWhpPorm7xDsvBCa8qRSDaO8bhucRoqfOREN
	 M1rbp8C9sXdBAeSBrMRUQhUMYV1v04pyzpTWgdyTUjostD6n+J1D11axlnPq4yqzIm
	 +oxjh3J8Ffl7A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 8A99D3408AD; Tue, 19 Nov 2024 12:49:57 -0500 (EST)
Date: Tue, 19 Nov 2024 09:49:57 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: Krister Johansen <kjlx@templeofstupid.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>,
        "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>,
        David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <20241119174957.GA3484088@mit.edu>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc43689ca4249f18c60fa4b063822ea@ukr.de>

On Tue, Nov 19, 2024 at 08:15:29AM +0000, Windl, Ulrich wrote:
> > Reads of ext superblocks can race with updates.  If libblkid observes a
> [Windl, Ulrich] 
> 
> I really wonder:
> 
> Can one single block be inconsistent when read, considering that the
> block on disk is not inconsistent?  That would mean that the block
> buffer you are reading is being modified by another process.  AFAIK
> the basic UNIX semantic guarantee that a block is read atomically;
> if it's not, something is severely broken, and I don't think that
> O_DIRECT fixes that.

Yes, this can happen if the file system is mounted.  The reason for
this is that the kernel updates metadata blocks via the block buffer
cache, with the jbd2 (journaled block layer v2) subsystem managing the
atomic updates.  The jbd2 layer will block buffer cache writebacks
until the changes are committed in a jbd2 transaction.  So the version
on disk is guaranteed to be consistent.

However, a buffer cache read does not have any consistency guarantees,
and if the file system is being actively modified, it is possible that
you could a superblock where the checksum hasn't yet been updated.

The O_DIRECT read isn't a magic bullet.  For example, if you have a
scratch file system which is guaranteed not to survive a Kubernetes or
Borg container getting aborted, you might decide to format the file
system without a jbd2 journal, since that would be more efficient, and
by definition you don't care about the contents of the file system
after a crash.  So there are millions of ext4 file systems in
hyperscale computing environments that are created without a journal;
and in that case, O_DIRECT will not be sufficient for guaranteeing a
consistent read of the superblock.

In the long term, I'll probably be adding an ioctl which will allow
userspace to read the superblock consistently for a mounted file
system.  We actually already have ioctls, EXT4_IOC_GETFSUUID and
FS_IOC_GETFSLABEL which will allow userspace to fetch the UUID and
Label for a mounted file system.  So eventually, I'll probably end
up adding EXT4_IOC_GET_SUPERBLOCK.  Let me know if this is something
that util-linux would very much want.

Note: this does require figuring out (a) whether the file system is
mounted, and (b) if so, where is it mounted.  So if blkid wants to use
this, it would need to have something like the function
ext2fs_check_mount_point[1].

Cheers,

					- Ted
					
[1] https://github.com/tytso/e2fsprogs/blob/950a0d69c82b585aba30118f01bf80151deffe8c/lib/ext2fs/ismounted.c#L363
