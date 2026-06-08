Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74379397682
	for <util-linux@vger.kernel.org>; Mon,  8 Jun 2026 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914765; cv=none; b=UteZRkKJLCk/92WxE01GRchIon26uysK8KQHobB7sVJEZnsu8aEHsiud+2tz0GlDiMkLt57oVzwEVe4zolYME09ebb7UDkPtVoBMFNzRWsLYeMZk3MUprS+uK0L1rzij69vMjkC8qIPPzJF+gmVHMzMxalHqJ7RuxjkSyBj0l2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914765; c=relaxed/simple;
	bh=D3E3eqXP+lv/BuXei7gzUIFlIGXwx01WOsEZOSfTUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5AZFWJRHQmg4KpL22q5ocUwXGE0CYK/qRHxbbTnOk0ZEPg+H5W7zyBfGRzue0JXTgKMGdb1LZUYGFnNuV/6tl88of7X3yJALG4O41GHOLJ33Pg43UrdABVkxBk1AuzpG4lcwyPPOa6cX3PldUG5lijf8QBYv0ErCfthvOKAvMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE/ao4Dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE/ao4Dt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780914763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/t8yIlsyRVZ1pMFKB7KsKV7Z+tsuGREQR09nQ2BbPJ0=;
	b=WE/ao4DtPOLoK7V+WeMPGE4kgUsjjw2GO4z9pboM6t3yeQNQI1payfGv9thc6VUwIeP9mO
	h2JILiQDokl7uQM0HHmLybwllYSfi2fy6blfDsa6r9/CkNqRFgj3Gd/kBobRI73K/z8QOv
	JJkuBUvK2vl4YCB5Kj7i9/mIRP4Indk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-Fbhn-hRsMuuRP2unnpzOEg-1; Mon,
 08 Jun 2026 06:32:41 -0400
X-MC-Unique: Fbhn-hRsMuuRP2unnpzOEg-1
X-Mimecast-MFC-AGG-ID: Fbhn-hRsMuuRP2unnpzOEg_1780914760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 471251955F17;
	Mon,  8 Jun 2026 10:32:40 +0000 (UTC)
Received: from ws (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA5D71800348;
	Mon,  8 Jun 2026 10:32:38 +0000 (UTC)
Date: Mon, 8 Jun 2026 12:32:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Ralph Ronnquist <ralph@selfhost.au>
Cc: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>, 
	Chris Hofstaedtler <zeha@debian.org>, "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, 
	"1134639@bugs.debian.org" <1134639@bugs.debian.org>
Subject: Re: Bug#1134639: nsenter -t 1 -m escapes mount and pid namespaces
Message-ID: <wbqlnunuamfw6jcksecbaqetk6r6iiufcvfwvqyxbnoghgjstu@3agofxhths4i>
References: <aejkWHDXmpCX7Gh7@smyga.hemma>
 <aiBvnWAjX7uu8ydx@per.namespace.at>
 <SJ0P220MB0541F8F40FD5C0E972BBD715E9102@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
 <aiFQRzblklN7Iv2I@smulan>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiFQRzblklN7Iv2I@smulan>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jun 04, 2026 at 08:15:35PM +1000, Ralph Ronnquist wrote:
> On Thu, Jun 04, 2026 at 04:03:44AM +0000, Christian Albrecht Goeschel Ndjomouo wrote:
> > $ unshare --mount --pid --fork
> > $ mount --bind FS FS/
> > $ cd FS/
> > $ mkdir -p old_root/
> > $ /sbin/pivot_root . old_root/
> > $ cd /
> > $ mount -t proc proc /proc
> > $ umount -l old_root/
> > $ rmdir old_root
> > 
> > You should then be able to see the exact same mnt namespace ID.
> > 
> > $ ls -l /proc/1/ns/mnt
> > [...] /proc/1/ns/mnt -> 'mnt:[4026533461]'
> > $ nsenter --mount --target 1 -- ls -l /proc/1/ns/mnt
> > [...] /proc/1/ns/mnt -> 'mnt:[4026533461]'
> > 
> > 
> > Maybe Karel has more to say about this.
> > 
> > Anyways I hope this cleared up at least some of the confusion.
> 
> Quite subtile, but I can confirm also in my actual setting (which is a
> simple and plain "overlay-boot" example).
> 
> I will need a couple of sleeps before I fully grasp that "absolute
> root" notion. However the recepie you outline does bring the desired
> effect of eliminating that namespace eascape for me.

I'd suggest using `unshare` to mount the proc:

    unshare --mount --pid --mount-proc

You might also want to add `--root dir`, otherwise `/proc` is mounted
privately in the current root.

Also, note that `nsenter --target 1 -m` enters only the mount
namespace, while `nsenter --target 1 --all` enters all namespaces.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

