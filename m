Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAE1B951
	for <util-linux@vger.kernel.org>; Thu, 15 Feb 2024 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989884; cv=none; b=q6Rgo0g+NhjAdZAezL99+q8308HWL300zfS+tRlaxzL4LyyeePUOQbSV6SQ56rZnofWksvYZnjRDP3hMeGISzkDtvp/x08IBL9XcXXaktHzg9vwaicvOa/O+RiYWqGGNXfe+Iqiv9YaqsRZssL+Mvdu3Yredfr26tQcmKwXmPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989884; c=relaxed/simple;
	bh=89p/XNXS4/pEzcmoUeHQoXSo5MStWGRtQ7t1T7Jk5i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifTmILFXfmPWMzALXTzvDl0S3jOzMHETflOY4qVA+PoqYti3jkGz1nQT9EySKqwvOtbsMUCXJU40Ze8HVZ6/UHdiE0Z1nmqFEr4rdFjXAbsVbiYoPlX05oQl4rzHO2Ic+DzT72L0dpLYDMBlycrq+h/PfquoBpFtz1088ClZQSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMih3fo3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMih3fo3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707989881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hpmhvWjnnWZlccQLq87V5krRO65Ic9Fdur4hmJ1aMRI=;
	b=RMih3fo3vZmkQ3e1IwzCZVnrF9+bTQUa5lmBqt6sgUiC28xbP1rl/TYrKTNh9PZtU8VgL/
	RpkTT0cKanF2smUNB2QAF2pnSbwA9mMkHscxSeiuCSLpGkaKnxrnv/wXGqwYeRuKmALwRz
	OMLTLZgfeBcf6SvT+M9W9hLd8Eo9Fk8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-bM8y525BPtudIBqCd8pjuQ-1; Thu, 15 Feb 2024 04:37:58 -0500
X-MC-Unique: bM8y525BPtudIBqCd8pjuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1308185A596;
	Thu, 15 Feb 2024 09:37:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93D522166B36;
	Thu, 15 Feb 2024 09:37:57 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:37:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Mention systemd implementation of fsck
Message-ID: <20240215093755.557tkkvtcnshaot4@ws.net.home>
References: <adf1f630-a264-4db7-9777-d4e2de2bad3b@suse.cz>
 <20240214142342.x24dioosah2i27na@ws.net.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214142342.x24dioosah2i27na@ws.net.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Wed, Feb 14, 2024 at 03:23:45PM +0100, Karel Zak wrote:
> On Wed, Feb 14, 2024 at 01:17:46PM +0100, Stanislav Brabec wrote:
> > systemd uses its own implementation of fsck with a slightly different
> > behavior (e. g. fsck -A checks noauto volumes, systemd-fsck does not).
> 
> systemd calls fsck from util-linux, but a new instance (with -l) for each device.
> It would be nice to be more explicit and explain it, because "it has its
> own implementation" sounds like fsck from util-linux is completely out
> of game :-)
> 
> > +== NOTES
> > +*systemd* does not call *fsck -A*, but it has its own implementation
> > *systemd-fsck*(8).
> 
> What about:
> 
> systemd does not invoke fsck -A to check all devices; instead, it
> calls fsck individually for devices selected based on the logic
> implemented in systemd-fsck.

I had short discussion about it with Lennart, and he suggested not to
document anywhere systemd-fsck as it's private systemd stuff. I have
pushed to repository:

  https://github.com/util-linux/util-linux/commit/9cb7b7671d903573d6c3b9d8112ec13953cdcdc6

Hope it good enough :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

