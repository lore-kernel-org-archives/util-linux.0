Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875603F87E9
	for <util-linux@vger.kernel.org>; Wed,  1 Apr 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043017; cv=none; b=MPzS362/TLzLgBe/0LutEJq/t231s1SxDxmwgGC5gSZAGss5KMeg0JWswKB08H8d7JnZ5VF9Sk254XsGyfgFDG+hvVrkybLAz8anf1RnU40H14SxN7WzByMhCz3b3Ixdvhn3XpJ+Sv881Fu//cQFgvUnvlQiTb+HtpmvgxniLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043017; c=relaxed/simple;
	bh=Tf/y7HOfzIL/bmHCHCcc8KhMBozX9RjCRDnqrQkuV6Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JGWRC1iJPOCE88GW6fA9i9DJFhAAgOs5eviEiAF8fM9oTJAFfxhDDP14KG4RgtJLBGmblZ7JZ3aPNUQphzY50CbY2t4NCcoxDM8b6tme3H1nT5N23TospNtzom6kZQno0dlZEp8WmI9GPZMJg2MsOtmZr2Bl1JHSzgUXKnohYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E7U3OPVu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7U3OPVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775043015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=lXZFFN4PTU5dwKkERyMyy65GK294Adg5feh92/l4Ats=;
	b=E7U3OPVuuRtTBSyND5gSCNyW6ADGegm0Onl8iDIt6aZgIoJHRThnm8b10TUlvQn5intH1R
	VDXRSOh+UZySdQ5cie7Rj4m4wa9KEuFEf95xWkdKl6bKym7IHEXeqY/ETlIsnvlZ16Veee
	ONhsBbXmyw+D3xrdalGi+ox28jl59NI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-OCBSWbucOxGnMO21nQcUGQ-1; Wed,
 01 Apr 2026 07:30:12 -0400
X-MC-Unique: OCBSWbucOxGnMO21nQcUGQ-1
X-Mimecast-MFC-AGG-ID: OCBSWbucOxGnMO21nQcUGQ_1775043011
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48910195608C;
	Wed,  1 Apr 2026 11:30:11 +0000 (UTC)
Received: from ws.localdomain (unknown [10.44.34.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F7821954102;
	Wed,  1 Apr 2026 11:30:08 +0000 (UTC)
Date: Wed, 1 Apr 2026 13:30:06 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41.4
Message-ID: <r6bqqytbylypey4kvj3fspb7l3o7im6dlamht5s6v2bfjs55b5@q666gfswirs6>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


The util-linux release v2.41.4 is now available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.41

This is a security maintenance release addressing:

 CVE-2026-27456 - mount(8) TOCTOU symlink attack via loop device.
   The SUID mount follows symlinks when resolving loop backing file
   paths. On systems where non-root users are permitted to mount loop
   devices (via 'user' option in fstab), this allows access to
   arbitrary files.

 CWE-190 - Integer overflow in libblkid parse_dos_extended().
   A crafted MBR disk image can cause uint32_t wraparound in EBR
   chain processing, causing reported partitions to not match the
   on-disk layout. Tools like udisks may then register a partition
   at logical sector 0.

Feedback and bug reports, as always, are welcomed.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

