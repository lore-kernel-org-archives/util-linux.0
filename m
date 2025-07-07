Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646B275AFB
	for <util-linux@vger.kernel.org>; Mon,  7 Jul 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887501; cv=none; b=A7pRlP6ebRewajkxjR21qzD/7PAr2SsoOgo5WDIjnRRNdlyqhpboy6A6bFxNK/bGp9MSCf6XY8opawohxH9oaQbHW70R6gn4ou8PpeOt8FQ2XU7gHe2Vmy7t39xmmr/SpV9kmeW+O54meEZTvcPnoG3UjOU4lj3zhkFRAI6ZSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887501; c=relaxed/simple;
	bh=hneO2iObLRMSzXdLsVgOsCR1JtxkOsqutV3O1Fd2qYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4dNa33La9O5r7fz7R9vyjPNc0efPIexi5b73ezmNmcXEowAfLEO7nSfgY8bFChtk57I1nD+09tkKyb8GdMU90eOHbe2WRaBNPRcp0ElMEnHbx+WJezFiCRc5hq//TWxeApN1TqWglspmqkZL/MsOsCgwq9J9UGbkJ3ug/QS63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WH2YRsWv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WH2YRsWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751887498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9lsTKdLSIfM0IQhwDpZh371M9HEefhNrYWHWnGmn7gY=;
	b=WH2YRsWva7DROOsLCDHLQwd7SkEGs17f9wvY+/dheE0txK6glkOlRUkH3VjIMPHH0/rdQh
	RCRl3c6zpkszp+PGkipyPiCZyhTYClOITIanmgA8kcdHKhRKfwvRtnx8zcgHYA30lULbba
	CBYQXeN+2/rnIzaZdmhWb6cR1s2rWCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-oxWA5hmgNGKSDmZgndp2ZA-1; Mon,
 07 Jul 2025 07:24:55 -0400
X-MC-Unique: oxWA5hmgNGKSDmZgndp2ZA-1
X-Mimecast-MFC-AGG-ID: oxWA5hmgNGKSDmZgndp2ZA_1751887494
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEE71180028D;
	Mon,  7 Jul 2025 11:24:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC91C19560AD;
	Mon,  7 Jul 2025 11:24:53 +0000 (UTC)
Date: Mon, 7 Jul 2025 13:24:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Mio <mio-19@outlook.com>
Cc: util-linux@vger.kernel.org
Subject: Re: btrfs device detection bug util-linux 2.39.4 to 2.41
Message-ID: <s23tlsariqhzuo6zstmuuaoya64y5jehhtgzrbpkbynbmlwpix@hdbxx4cd4bgq>
References: <TY4PR01MB1385345D7813E44642723316E9243A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY4PR01MB1385345D7813E44642723316E9243A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


HI Mio,

On Thu, Jul 03, 2025 at 03:05:52PM +1200, Mio wrote:
> I found a bug affecting device detection of my btrfs filesystem with 3
> devices. My test system is currently running NixOS 25.05 with util-linux
> 2.41. I am able to run a older version of util-linux with the command `nix
> shell github:NixOS/nixpkgs/nixos-24.11#util-linux` which doesn't have the
> bug.

It would be nice to make your bug report a little more detailed.

The command "blkid" without any option can return cached information, 
etc. The ideal is to call "blkid -p <devname>" and provide output from 
the command. You can also use "LIBBLKID_DEBUG=all blkid -p <devname>" 
to get debug output.

Were your disks used for ZFS before btrfs? If yes, you're probably 
affected by https://github.com/util-linux/util-linux/issues/3613

Try "wipefs <device>" to get more information (don't worry, it does 
not wipe anything from the device by default).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

