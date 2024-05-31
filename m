Received: from sosiego.soundray.org (sosiego.soundray.org [116.203.207.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258892E64B
	for <util-linux@vger.kernel.org>; Fri, 31 May 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.207.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165950; cv=none; b=OGbWnQe0q4Xc+2SOUrVFRyU+8OHT606wQs1v7J86gSwETrAlJumSsGCmoscAfDZHa4grheLSXgcDjh3XC5dDJU5ND3iC31VXCjezztZHA5QRUnrT3t77EXT0vgLYn3Efx8Icb3MTwfciv63fa85AvsjbdC3X3NrZLe2jZtTWCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165950; c=relaxed/simple;
	bh=BgiQSE7WRjxuUtFOGKYLe5+Q/rkCJE3zfrh1r8Ryxis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EJ8waFrBLb2WDfQnIFw1/sLrjiIN3xgCh0St5mjB2mPIWho1OOYYYhwHb+ZJ5rnzhxgKloMc3RGLDRif9AqCcckR8H/EOWjNzD55eMFNYb292LepDBOdyh+JmFwEEIXyLQH+gzb9djVUVIJjtVwsnSWFN1XMedO8slcYTOYFvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org; spf=pass smtp.mailfrom=sphalerite.org; dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b=jhtINXO7; arc=none smtp.client-ip=116.203.207.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sphalerite.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sphalerite.org header.i=@sphalerite.org header.b="jhtINXO7"
From: Linus Heckemann <git@sphalerite.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sphalerite.org;
	s=sosiego; t=1717165943;
	bh=7gOqkBcBF70wR9bSGoKD110Va497IjKTkWhkMG8W1A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=jhtINXO7zFLlk1+1Oploy76M0yYiwuo0yQChnC9cjUVnmPRxwuE7URzKNxupMrIYi
	 TGlSHavZch/4DAswCy6NGItBZdJjuXFIdhVjkesT4S5TDJwQcpeYagbWwXfH9AyctE
	 /aHoxexrq/Xfo04flKJeRSQl1n2z/xbHRSPrkPzQ=
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: provide tree fd even when a mount helper is used
In-Reply-To: <20240531094125.r2nvmio47itrtzep@ws.net.home>
References: <20240530180041.3447273-1-git@sphalerite.org>
 <20240531094125.r2nvmio47itrtzep@ws.net.home>
Date: Fri, 31 May 2024 16:32:21 +0200
Message-ID: <yga4jaenjbe.fsf@localhost>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karel Zak <kzak@redhat.com> writes:

> On Thu, May 30, 2024 at 08:00:34PM +0200, Linus Heckemann wrote:
>> Previously, the X-mount.subdir option would fail (mount exited with
>> code 0, but the target was not mounted) when a helper was used.
>
> Do you have any examples that can easily reproduce it?

I encountered this issue with bcachefs (create /foo in the root of a
bcachefs filesystem and then attempt to mount that same filesystem with
X-mount.subdir=foo) but the problem should be the same with any
other filesystem that uses a mount helper.

truncate -s 1G test.img
mkfs.bcachefs test.img
mount -o loop,X-mount.mkdir test.img /tmp/mnt
mkdir /tmp/mnt/foo
umount /tmp/mnt
mount -o loop,X-mount.subdir=foo test.img /tmp/mnt

Without my patch, this exits with status code 0 but does not result in
/tmp/mnt being mounted at all.


>> In addition to fixing X-mount.subdir, this allows dropping the
>> fallback behaviour previously implemented specifically by the
>> set_vfsflags and set_propagation hooks.
>> 
>> I realise this patch is not acceptable as is, since I just exported
>> the previously private open_mount_tree symbol from hook_mount.c
>
> Perhaps it is unnecessary to only keep the API file descriptors in
> hook_mount.c. It is a generic feature and we may see more use
> cases where it would make sense to use it in other places.
>
> I can imagine having the file descriptors in the libmnt_context
> structure and initializing them through functions in context.c (which
> would involve renaming open_mount_tree() to something more
> appropriate). It could potentially be a public library function so
> that libmount applications can also utilize it.
>
> I will think about it :-)

Thanks! That sounds like it would make sense, though I'd expect (naively
-- I'm not super familiar with the overall code) it's generally not
desirable to use that function as opposed to using the mount fd from the
context once it's become available through the mount step? I don't see a
particularly strong case for using that and not open_tree directly.
