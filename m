Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034171C84B4
	for <util-linux@vger.kernel.org>; Sun, 23 Feb 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316947; cv=none; b=HppdGf+OnTLHTCHSTTQgP3UOoA2F++s4Km7Y+HJZEOxwH5MOxCIqVD+Yf1z/6gsq1Y+8KqBJv6SXawsY/DAAPS2StVYIj81uZjTA+gmgKpg+RgtkS8e2qxYaeWJG43+vl4X8M9j9aqy2SatTWQo8AcQhHT5eD0gAxBF+wjFXC5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316947; c=relaxed/simple;
	bh=gHU3lW0eAzMPAS2H7hNAuRmyar23+6FR8uWVPTBx4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7QNzFTEgah0wt4FeUhCJkMSaQFyk86WXGLdolJe/TcxaHNgGYARoD81UK12ntw5fgGTCt5qFHXJMe+XonFBCse1QthyBLhre8WjgmbHfCoK9wI3LrSd4lKXawJeiTKd7i4Q/LggftC1YVSlDOHf9E3x0nIN/BqgqWRXscinSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Xm6IC1S/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Xm6IC1S/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uX2mhveXom2zGXO+HFaUX+bp0Q6DM9ec5w6XD/5XQ+k=; b=Xm6IC1S/pJdN1zbvNxKpgLxkYs
	VrxwMpRRU5wrlchU4Oq7VBOmOF3LB4k2vjMomHgU2vODynTyGJbpqwffpHQzZ+ZehQ3BqH0r1MAmJ
	uP7d7CHrF6BBf0VH0y82lM9VHPuLfivwpLH0JfAccZebH5aprVxRSBgqsQu3IwmIuHOe9EL1Eb+sY
	+v+CsvSG3M04YLxJIBFf65KA4mCHG0jsox8a7szMz6bzVE6akrJZ0Yvvla6pSUBuP1/FzdGrQN9Sw
	S69VSZtTQ6d1k8EymHd9igR6sNzU0ydkIzIphgSMD13PXskZbaQwbiV9Ms1aqU24bFl1LSgQEc0Qw
	STHvAJAg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tmBw7-00H7Ck-GO; Sun, 23 Feb 2025 13:22:23 +0000
Date: Sun, 23 Feb 2025 14:22:21 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Thorsten Glaser <tg@mirbsd.de>, 1098638-quiet@bugs.debian.org
Cc: util-linux@vger.kernel.org
Subject: Re: Bug#1098638: fdisk: creates partitions one sector too large
Message-ID: <Z7shDWfLwHPMxT2C@per.namespace.at>
References: <5c513969-5e9f-cb0d-c62c-e153ca259915@mirbsd.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c513969-5e9f-cb0d-c62c-e153ca259915@mirbsd.de>
X-Debian-User: zeha

Control: tags -1 + upstream

Looping in upstream.

On Sat, Feb 22, 2025 at 12:57:38AM +0100, Thorsten Glaser wrote:
> Package: fdisk
> Version: 2.38.1-5+deb12u1
> 
> When I create a new partition with +sectors, fdisk creates one
> that is one sector too large:
> 
> 
> Command (m for help): n
> Partition number (1-128, default 1):
> First sector (2048-7814037134, default 2048):
> Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-7814037134, default 7814035455): +2097152
> 
> Created a new partition 1 of type 'Linux filesystem' and of size 1 GiB.
> 
> Command (m for help): p
> Disk /dev/sdb: 3.64 TiB, 4000787030016 bytes, 7814037168 sectors
> Disk model: ST4000NM0245-1Z2
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 4096 bytes
> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> Disklabel type: gpt
> Disk identifier: DDA88AFF-1E6A-7448-AB5A-85470938DBC7
> 
> Device       Start        End    Sectors  Size Type
> /dev/sdb1     2048    2099200    2097153    1G Linux filesystem

Also from Thorsten:
> Same for MBR:
> 
> 
> Command (m for help): n
> Partition type
>    p   primary (0 primary, 0 extended, 4 free)
>    e   extended (container for logical partitions)
> Select (default p): p
> Partition number (1-4, default 1): 1
> First sector (2048-1000215215, default 2048):
> Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-1000215215, default 1000215215): +2048
> 
> Created a new partition 1 of type 'Linux' and of size 1 MiB.
> 
> Command (m for help): p
> Disk /dev/nvme0n1: 476.94 GiB, 512110190592 bytes, 1000215216 sectors
> Disk model: SAMSUNG MZVLB512HBJQ-00000
> Units: sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x3cca69b4
> 
> Device         Boot Start   End Sectors Size Id Type
> /dev/nvme0n1p1       2048  4096    2049   1M 83 Linux

I've briefly reproduced this with util-linux 2.41-rc1 on a loopdev.

From what I understand Thorsten is saying, he would expect, for a
partition that starts at sector 2048, when its created with "+2048"
size, to have a number of 2048 sectors, not 2049 as shown above.

I haven't looked at the code if this is intentional or what the
reason could be.

Best,
Chris

