Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338E2686A9
	for <util-linux@vger.kernel.org>; Tue, 25 Feb 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485271; cv=none; b=HqLagj6UPMTlpOaaUkKnezUjOpj/vrzlaYtSIm1faHzKeqfeTv5k9gCkaZGqLOfBPmGNyNnUkmagZOzkRGmZmsiIoNCfHhaLUVRIJhluxdlPWr1MllDICq2qP2adUNv0jCzDmQXRGLaKZaETonR5IPzTcTeeE8eKVECCd9uEUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485271; c=relaxed/simple;
	bh=unkdbu0OZOqWnCiDtNsYmL4PGHhUiup0c9IFtHEXoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5KQhe0zZgRNmIvw+L8yoWyOrJwK3a+2zVeaZ9UrOxU+lhCIW6mBJj56q8mWW0McxFlEP8QFGnmCFd0LqRSAHiUNmQYl9WiFKwX9+zZ7Zj5JuM3YJfySbpXU+FxawEenoq3szhyQzrSH44DWEDYW9zPcLXLTwRagonxo+0uT//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuKiVcCD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuKiVcCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740485268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SFow3b9aARMQbRO9/le4l0XgYn4mtNBEuj8bMrsQdmM=;
	b=DuKiVcCD0+LgFlDIeKHOT1eL8UaMk29s5FpOiq8RcOzyu6UMflXrmxEAcJ3wu6SCxtnAXC
	PdznUE/fO7gH83YjDuzAG+2yLj2COzkBLlk9VEQsF4ExQUDSxCE8BA9CYjx8GbVI+GmhKx
	apZA/d3/BitvJJZoDRs9vVViAU1rdLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-SgBPPZu2N4S-Y2R3neNbbQ-1; Tue,
 25 Feb 2025 07:07:44 -0500
X-MC-Unique: SgBPPZu2N4S-Y2R3neNbbQ-1
X-Mimecast-MFC-AGG-ID: SgBPPZu2N4S-Y2R3neNbbQ_1740485263
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B471800373;
	Tue, 25 Feb 2025 12:07:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75BD11954B00;
	Tue, 25 Feb 2025 12:07:41 +0000 (UTC)
Date: Tue, 25 Feb 2025 13:07:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: Thorsten Glaser <tg@mirbsd.de>, 1098638-quiet@bugs.debian.org, 
	util-linux@vger.kernel.org
Subject: Re: Bug#1098638: fdisk: creates partitions one sector too large
Message-ID: <7tyxu3bufdztsdkt4svgvz5ul4bzsnvbstndcopht36lklthbj@3kmnuyuwhtwp>
References: <5c513969-5e9f-cb0d-c62c-e153ca259915@mirbsd.de>
 <Z7shDWfLwHPMxT2C@per.namespace.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7shDWfLwHPMxT2C@per.namespace.at>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Feb 23, 2025 at 02:22:21PM GMT, Chris Hofstaedtler wrote:
> Control: tags -1 + upstream
> 
> Looping in upstream.
> 
> On Sat, Feb 22, 2025 at 12:57:38AM +0100, Thorsten Glaser wrote:
> > Package: fdisk
> > Version: 2.38.1-5+deb12u1
> > 
> > When I create a new partition with +sectors, fdisk creates one
> > that is one sector too large:
> > 
> > 
> > Command (m for help): n
> > Partition number (1-128, default 1):
> > First sector (2048-7814037134, default 2048):
> > Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-7814037134, default 7814035455): +2097152
> > 
> > Created a new partition 1 of type 'Linux filesystem' and of size 1 GiB.
> > 
> > Command (m for help): p
> > Disk /dev/sdb: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
> > Disk model: ST4000NM0245-1Z2
> > Units: sectors of 1 * 512 = 512 bytes
> > Sector size (logical/physical): 512 bytes / 4096 bytes
> > I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> > Disklabel type: gpt
> > Disk identifier: DDA88AFF-1E6A-7448-AB5A-85470938DBC7
> > 
> > Device       Start        End    Sectors  Size Type
> > /dev/sdb1     2048    2099200    2097153    1G Linux filesystem

This is how fdisk has functioned since its inception. I noticed this
in the v2.13 code and was able to replicate it with v2.14 (year 2008).

The convention of +<sectors> is strictly evaluated as <first> + <size>,
without subtracting 1. This is different from +<size>{M,G,T,..} where the final
size is reduced by 1 and aligned to the disk I/O limits.

I have doubts about changing this after 20 years due to backward
compatibility. Additionally, it should be noted that people use 'echo
"something" | fdisk' in scripts ...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

