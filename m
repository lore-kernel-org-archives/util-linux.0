Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963211C84B1
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865926; cv=none; b=dyumQykxeD0nQcrYnqX3GbqteZEB1uh8HzWWfNI08ql32j2VR1jb7GfSvF/VGmXxwVkWE4daXyhB06oCQnya1dY/ATiwMPm1gheVxr1NlSYShjhBYok9uy2+SoSJzRcrwYfjPM4dQG1euEy7CmitEI0iOf/AZCzFNYfIM3MUFZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865926; c=relaxed/simple;
	bh=bnOAMqSGebZSK0S/dDZaZLpk7JLMbPHTpyZzPX4b5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a64vMmBihy74WHbzFByTgPKRPC7zCzpHhI4eauBuvJlY3fevc6JOhH44ovUloNeYjy0QjfQsoUDxdxM61Epy6oxKH/hmrGYrYgAYdjTCVYX7DzVWVDR+55h/p5j6raO1gYMULJ7kdqnmTihBj4M3UUhxWMXyfJ/tXD7oKBIFEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8WMNNR5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8WMNNR5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748865923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gebFosh6Vgn0o2611QBfxe2a5PlUSo0x1B5g+YOSQs=;
	b=I8WMNNR546p1Rd041q/2GwfwxAj6eWg5Km/OwSAUYSGMnFa4wTbu3JzyisO6MfXdjy8OPi
	rKdcEJIKRM3tuMcIFfgWSFLluIyZ9lDGw5TvIzy7AK1YzExqQxCZCFFYSB9fQ8nApCS84B
	CWawd773wsoCWiXh5ME30cOWl4k2dqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-nwaVHiK5P5WSvgpoYBnf_g-1; Mon,
 02 Jun 2025 08:05:21 -0400
X-MC-Unique: nwaVHiK5P5WSvgpoYBnf_g-1
X-Mimecast-MFC-AGG-ID: nwaVHiK5P5WSvgpoYBnf_g_1748865921
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 278071800368;
	Mon,  2 Jun 2025 12:05:21 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B5681800368;
	Mon,  2 Jun 2025 12:05:18 +0000 (UTC)
Date: Mon, 2 Jun 2025 14:05:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/colors: call gettext() only when the argument of
 --color is invalid
Message-ID: <5sewijyumkskfpmjmusj57whvullfsv4c4ecsjzngkcfy762ve@gmvvwojwakqj>
References: <20250528093704.8896-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528093704.8896-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, May 28, 2025 at 11:37:01AM +0200, Benno Schulenberg wrote:
>  disk-utils/cfdisk.c  | 3 +--
>  disk-utils/fdisk.c   | 3 +--
>  disk-utils/sfdisk.c  | 3 +--
>  include/colors.h     | 2 +-
>  lib/colors.c         | 7 ++++---
>  misc-utils/cal.c     | 3 +--
>  sys-utils/dmesg.c    | 3 +--
>  text-utils/hexdump.c | 3 +--
>  8 files changed, 11 insertions(+), 16 deletions(-)

 Applied (all in set), thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

