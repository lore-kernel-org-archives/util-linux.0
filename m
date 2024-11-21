Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6213C695
	for <util-linux@vger.kernel.org>; Thu, 21 Nov 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185869; cv=none; b=Wo4xa3UgifG1KIMOCKkHXGrHz4Ogti0Rd7dg8PPiAbyC97Z3pw7IAJ78cEXEYY8S3ttr9OPlj/0Zs5pEdBsJYDLdZghtnyDVr9wEo7qRBRLPoTh9twseqJ2v6wNOoU/kCqFH96qSv/sot3nPB4vtWc5Sr1ErJ7870aNPfRxPsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185869; c=relaxed/simple;
	bh=hZgrsdhSY6GE6Xcsg5h16S/hJ5LQ3LD5OvnKQOBXfFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0fopLapS2z4WdUjtVuGO13G6+/4mAmcJ8/2gOBmT6AHxr4J499j+lmRxu7SE1oBKiR1JQ/PgYgsbkijtBDIweKRdCaKgYiGNaAzM3B6oAXD6fsRSVkyhXriYdY/BCn7LUytKTgX0FPobRDkk8MBnWSJFO6+7H8jLgqtt5hpUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2iyiHfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2iyiHfH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732185865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vgewLvx+r52T9mKMcv02z6c0MzmmVSOoq8KfrbOONoY=;
	b=C2iyiHfHndb4vEKS3k4bOIl/S9blFT1O7H1U8A32FbI46DOxWie0IJS1riwHyuDtjjAoPp
	wyar3EwplIsTuap56bXd6C0RArJTTqhFOgO1vVx9gjqHiNKR9RgdGEFadaT3GrnyQdZu7A
	5qQDKa/+rTP0RlXM9X88RxjaGdeKokM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-VgX8Xqb_N1WffRWZ32ZPJw-1; Thu,
 21 Nov 2024 05:44:21 -0500
X-MC-Unique: VgX8Xqb_N1WffRWZ32ZPJw-1
X-Mimecast-MFC-AGG-ID: VgX8Xqb_N1WffRWZ32ZPJw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB2D019560B5;
	Thu, 21 Nov 2024 10:44:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D3F81956086;
	Thu, 21 Nov 2024 10:44:17 +0000 (UTC)
Date: Thu, 21 Nov 2024 11:44:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Windl, Ulrich" <u.windl@ukr.de>, 
	Krister Johansen <kjlx@templeofstupid.com>, "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, 
	"systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, David Reaver <me@davidreaver.com>
Subject: Re: [EXT] [systemd-devel] [PATCH] libblkid: fix spurious ext
 superblock checksum mismatches
Message-ID: <cu2l7alrme6y7mm3kjmdnszyc7ka4a6zh5lw3ps3vj7igzjpkv@t7pgmn4aztkj>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Nov 19, 2024 at 09:49:57AM GMT, Theodore Ts'o wrote:
> The O_DIRECT read isn't a magic bullet. 

Hmm... the nice thing about this patch is that it only uses O_DIRECT
when necessary (if the ordinary method fails). This means that it does
not add complexity or overhead to regular FS probing.

> For example, if you have a
> scratch file system which is guaranteed not to survive a Kubernetes or
> Borg container getting aborted, you might decide to format the file
> system without a jbd2 journal, since that would be more efficient, and
> by definition you don't care about the contents of the file system
> after a crash.  So there are millions of ext4 file systems in
> hyperscale computing environments that are created without a journal;
> and in that case, O_DIRECT will not be sufficient for guaranteeing a
> consistent read of the superblock.
> 
> In the long term, I'll probably be adding an ioctl which will allow
> userspace to read the superblock consistently for a mounted file
> system.  We actually already have ioctls, EXT4_IOC_GETFSUUID and
> FS_IOC_GETFSLABEL which will allow userspace to fetch the UUID and
> Label for a mounted file system.  So eventually, I'll probably end
> up adding EXT4_IOC_GET_SUPERBLOCK.  Let me know if this is something
> that util-linux would very much want.

I doubt it will be helpful for us.

I believe that EXT4_IOC_GET_SUPERBLOCK will be used with a mountpoint
file descriptor, but libblkid works directly with the block device
(e.g. open(/dev/sda1)) where it searches for valid filesystems.

Another issue is that libblkid does not check if the device is
mounted, so the FS prober can be triggered in all cases. It simply
calls seek()+read() and tries to be smart.

Ideally, we would have a generic ioctl (for block devices) to ask the
kernel if a superblock at a specific location is valid.

  ioctl(fd, BLKVERIFYFS, { .fsname="ext4", .offset=123456 }) 

This would greatly simplify the complex processes currently in
userspace, and it would remove duplicity. Currently, we have many file
system checks in libblkid to verify that the on-disk data are not
random bytes. These same checks are also present in file system
drivers when reading the superblock.

Another userspace dream ... :-)

> Note: this does require figuring out (a) whether the file system is
> mounted, and (b) if so, where is it mounted.  So if blkid wants to use
> this, it would need to have something like the function
> ext2fs_check_mount_point[1].

Yes, that's not good.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

