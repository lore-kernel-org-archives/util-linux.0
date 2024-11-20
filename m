Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F215746E
	for <util-linux@vger.kernel.org>; Wed, 20 Nov 2024 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732082861; cv=none; b=K4cZR16HwYqrlqJ2JpARnhX59dIW1Nk4Fgg2QFAQdHuYbMMIyZ0dAkwn4u/0xkjthf8Zs0QE6Iuwv6czv1qBucoekQg5fT7jJ2WSeZ63KwbwPI1oHTKeBmxX3pQarUYpgUUWKjYTdb4fbItr2vaGISON79RJORVPfDzQTIvk1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732082861; c=relaxed/simple;
	bh=U3Q0l685IMKh7LZZ7gMddWUPv7DQy3g5KnKqzoG58F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti8F2gZzluNMjbJlkLZPnEHY2QurFi1ANWblw6W7/Z3ZfZOWphyBBt3TkXBq6eGMPBwmyZa24MyXE9HbtEdYV5YAyNjZ91AX+x53lC/QGGhow3zO+Ps4kArFAgbp5xjWzSkcDii44RDiidxO5yL2Kw7HgGp2I+nsroKs/a2Sxu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=ctunM9Zz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ctunM9Zz"
Received: from macsyma.thunk.org ([50.202.35.157])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AK67Ekr005662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 01:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732082841; bh=nAoeIozBdxsV5gIpkYGXOVVfas1OMk6Y7HMEdqY9qBA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ctunM9ZzbwB7/7Re4kvm60vU1PpRadx/Mwm+u0KfvYu8zHCyhqQowtA2XIhnIQd1v
	 LZ1qSGnowTqgVhi1FhVKV6Rz/u+16Qj7+0saRHzQ96JBEx0LwcovdaM9EGkgiHQTty
	 C5BkQn8cAzitrdi9jh4Nyy13LlCWf/02yidvsgEP9cOB7WUWfm6sidCCObOxeVn/j1
	 YP6a8Acm37i9xQ4T+jfvuI0BH62R7eTAs7hJoNhGbt7qMdG1TUWkzhTz/ztXqSK3v0
	 tkmM3mlrNA9mkouszJmSC27VzyIRLQG2mEAjPFA3bo8psrGvlxJtbO3eUJRTM4s0XH
	 mNkODhGNB8fMA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9676B340857; Wed, 20 Nov 2024 01:07:13 -0500 (EST)
Date: Tue, 19 Nov 2024 22:07:13 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>,
        "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>,
        David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <20241120060713.GE3484088@mit.edu>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
 <20241119174957.GA3484088@mit.edu>
 <20241119235953.GA1865@templeofstupid.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119235953.GA1865@templeofstupid.com>

On Tue, Nov 19, 2024 at 03:59:53PM -0800, Krister Johansen wrote:
> 
> Thanks for the additional detail on jbd2's involvement.  When I
> originally encountered this, it was on a 5.15 kernel where
> ext4_commit_super() was still using mark_buffer_dirty() prior to
> submitting the IO for the superblock write. I had managed to convince
> myself that ext4_commit_super() holding the BH_lock combined with
> O_DIRECT waiting for the dirty buffers associated with the superblock to
> get written was sufficient to get a consistent read of the superblock.
> I missed that this was changed as part of another bugfix[1].

Actually, even in 5.15, ext4_commit_super() only gets used (a) during
the mount paths before the journal has been initialized, (b) in the
umount code paths after the journal has been shutdown, (c) for file
systems without a journal, or (d) when the journal update has failed ---
for example, if the journal was aborted due to catastrophic failure.

Most of the time during normal operation, say, when the file system is
being resized, or the orphan list is being actively manipulated during
a huge number of unlinks or truncates, or changing the UUID using
EXT4_IOC_SETFSUUID, etc., the kernel updates the superblock using a
jbd2 transaction, and not ext4_commit_super().  So the change which
you cited in [1] doesn't make a change in practice unless the journal
can't be used for some reason.

If I remember correctly, the patch submitter for [1] hit the problem
they were trying to fix after a journal abort while they were doing
fault injection to test I/O error handling.  (In other words, case (d)
above.)

						- Ted

> [1] https://lore.kernel.org/all/20220520023216.3065073-1-yi.zhang@huawei.com/

