Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AA184F
	for <util-linux@vger.kernel.org>; Wed, 20 Nov 2024 00:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061285; cv=pass; b=Hy8jl+BPOPnRG7/c3X0xIcRXVy05v143D75lxOzRslt4g3PJzGsg1swKFq66PcVtHJpiglviPbsJ9LIJ8JdsLaZigt3lyxxGthutmus4Twi9j/kgM0GAwZpYjggI1U+qeDWGvw2iYJsCB+0RwiqkeYdWECxBXus/9V/XVerUHzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061285; c=relaxed/simple;
	bh=oFXZSvyCqZe+BtvYJn3wWFkFO8AUPKw89oi/SAg8MOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf1fdOP2L7u4P8Inv2DVcRJqtCT7HSCVdqvnpMY44mbQXGwdIi7E+tv3bdgwMLMc58a1rI8Z6pE7l0dv0WCnP8Jc6qlNZfx0ouWwnBhT4D19c+3EzAy/RQK/BRER+j6zxmTSxlUv/Eqv4pSZrLAZxowXm95PuPfC6vgSWSKuukI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=NblHZ3TV; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="NblHZ3TV"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A154FC4540
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 23:59:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.111.97.42])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4D59DC4619
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 23:59:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1732060795; a=rsa-sha256;
	cv=none;
	b=v0kd2q+jcVH7SVCjy2yQgbaZPsSirl+cMHPMhghrYdWBCL0O9W2L1c3a7eQqD57NlNFpzG
	M/IWSG1Jt7EtcMO4LQzJ3GMw+lMrdpndBgSqQEzgKILYebhZTHV922c/9jMa0IAJLRDcoN
	z9+kAN89XdsbNgr1IlWK60Ci86ema880b7c2uSJvfqwUo19OwDFniIn5QXJftwAR1tAylv
	EctD0wQpFfnD9TTzoGWJSfInVz/ARFoexq3rWiNh9htcEWBUPsQQmFULVD0TaCmjb5OqBc
	5d+ncJ/qs1PApEki5j/B8rZ1T5F1H1zGUGzR7WVOIYKkX69LHPQd4oBzXMg/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1732060795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pbbt/gIXfIW2YACS9eYftaxUeh+lrXsLsaFcNdsfEY0=;
	b=cVQ1P8PsCjzqQ0Z4/W/VywKkt97o0GuDQbiY3KngZQ5ccCsXkvZe2zlIV+gyA9IxMjdZ54
	6KlUiNuShDj54afqlEAS4x65fwd5Lg86MZ66uxtqo30OhpqTpMBmZopPuWELtCrMsuRJzW
	g2NWO7oRbm0N7NXFApR7i2xid4ElYkw0BdgfmbX9IKp2ihU/j8PZyRvTK6hbB7LTyOE24B
	xhBhZbbz3tvC6ySk6q6ExAFjIWet7HJ+gdT3mlXYr+1OgNZZSSEZ/9lwd8e9QSxQIgGDu+
	CUJEkMXDo/8qnQvB2Gh+nIig3PLyme0MOtYmufemFYO6RZnQVG9eHu6NUxTpWg==
ARC-Authentication-Results: i=1;
	rspamd-645676964-tc78z;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Snatch: 366983bf1212981b_1732060795525_2535996791
X-MC-Loop-Signature: 1732060795525:1785504766
X-MC-Ingress-Time: 1732060795524
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.97.42 (trex/7.0.2);
	Tue, 19 Nov 2024 23:59:55 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4XtM1R0wLCzJX
	for <util-linux@vger.kernel.org>; Tue, 19 Nov 2024 15:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1732060795;
	bh=pbbt/gIXfIW2YACS9eYftaxUeh+lrXsLsaFcNdsfEY0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=NblHZ3TVqxviFmyPJzADUhheTEdnhFiLgXdgvgqPsbyu7Wn8tmkptTA/3vJzxzLA3
	 C4ylVFzlPNZ0FDT3Ym2rmBvk0O3MIYYEh8rsVVNH+EV4oADgVeGLZ+2q1YH2QaBfRi
	 h2SKwtRsDSNfTd01QenjWuB0w26cUimfZUH3NVCM25d2OfFJ95guHb1sHL0Bl03xWL
	 ZaOSY0EcVzMh6wI/7Y3WjkTm1WpIHH/TeiTwDH42yUaZpgPkHcCn+cbTO095TsRdmI
	 IyTfc2dEkKEKf5MTqR2rxzqc72Qud/DJWecNYmIy25UdfEosl0I9gfjVE5ssK/eB8O
	 KzOEHTQ3++eDg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e017c
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 19 Nov 2024 15:59:53 -0800
Date: Tue, 19 Nov 2024 15:59:53 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Windl, Ulrich" <u.windl@ukr.de>,
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
	Karel Zak <kzak@redhat.com>,
	"systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>,
	David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <20241119235953.GA1865@templeofstupid.com>
References: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
 <7bc43689ca4249f18c60fa4b063822ea@ukr.de>
 <20241119174957.GA3484088@mit.edu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119174957.GA3484088@mit.edu>

On Tue, Nov 19, 2024 at 09:49:57AM -0800, Theodore Ts'o wrote:
 
> Yes, this can happen if the file system is mounted.  The reason for
> this is that the kernel updates metadata blocks via the block buffer
> cache, with the jbd2 (journaled block layer v2) subsystem managing the
> atomic updates.  The jbd2 layer will block buffer cache writebacks
> until the changes are committed in a jbd2 transaction.  So the version
> on disk is guaranteed to be consistent.
> 
> However, a buffer cache read does not have any consistency guarantees,
> and if the file system is being actively modified, it is possible that
> you could a superblock where the checksum hasn't yet been updated.
> 
> The O_DIRECT read isn't a magic bullet.  For example, if you have a
> scratch file system which is guaranteed not to survive a Kubernetes or
> Borg container getting aborted, you might decide to format the file
> system without a jbd2 journal, since that would be more efficient, and
> by definition you don't care about the contents of the file system
> after a crash.  So there are millions of ext4 file systems in
> hyperscale computing environments that are created without a journal;
> and in that case, O_DIRECT will not be sufficient for guaranteeing a
> consistent read of the superblock.

Thanks for the additional detail on jbd2's involvement.  When I
originally encountered this, it was on a 5.15 kernel where
ext4_commit_super() was still using mark_buffer_dirty() prior to
submitting the IO for the superblock write. I had managed to convince
myself that ext4_commit_super() holding the BH_lock combined with
O_DIRECT waiting for the dirty buffers associated with the superblock to
get written was sufficient to get a consistent read of the superblock.
I missed that this was changed as part of another bugfix[1].

The version of this fix that you applied for resize2fs has resulted in
no re-occurence of the problem in the environments where we had been
previously encountering the problem.

With libblkid, it's resulted in systemd-udevd removing
/dev/disk/by-label and /dev/disk/by-uuid links for devices when the
superblock checksum can't be read.  This in turn has resulted in /boot
failing to mount (when it's on a separate filesystem), update-grub calls
failing because /boot isn't mounted, and we recently had a mkinitramfs
fail because the /dev/disk/by-uuid links were missing for the root
device.

The patch I sent has resolved the problems in our production
environments, and was also run through a battery of synthetic boot
tests.  We've seen no re-occurence with it applied.  I've also run the
change against the util-linux unit tests and observed no regressions.

I included systemd-devel on this in case other users were observing
disappearing /dev/disk/ links.  I hoped I might save somebody else from
having to debug this a second time.

-K


[1] https://lore.kernel.org/all/20220520023216.3065073-1-yi.zhang@huawei.com/

