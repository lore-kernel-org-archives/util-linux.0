Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F1236424
	for <util-linux@vger.kernel.org>; Wed,  2 Apr 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591530; cv=none; b=txgvsXeUQYMVpdS+WOzWDb5hQ4N8tMpiEH1VtZcGPIZC7bl5ByDx8JNTF3vgTrlojbt2EJL5s6X/wkg1YO/Lddv4vCBTxpsiOOcR79p96tLw+v8RIAnrZCammLEG3KDWFDWVLJRcNjjfY3ISdBGYT/2z0STPBzQ1gOQeTDMOX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591530; c=relaxed/simple;
	bh=ApDE5Dr0Ah2R0kEZfzlPXdpKGod1aJX2UIUjNWEmccE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7rqu+IMRd7eJtBFUHJ/OjVFyJTTTC31X5yJDoZZiyCz2RK3cKqn3HAtxOSZGEwoAufXX7i9alJseUvV50pbcUp+4rMFKrMBBsB4d/LvzK2+ZGvckuNWX0AsRP1GBTZgRm4abwwKAEDPlUrH4ItBPEpdBDT9R90/9WbWo0PARuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xkq7aNUA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xkq7aNUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743591527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pC5xM8jiNXyrc5QMNvASTg1o1aD9f/Etx0LKds1Rlo=;
	b=Xkq7aNUAUh/s5PtVMydFxwt/xuOD/c94bvTYvtWNyHq8LeJH79jXyIEV1wYin9byE/xPOP
	ey6V8UmubOxHe3DlZNvEmo9DnKAUMq8W1rUakn2IDAi1h0zh/ke9Yo9C43wLIveabT1Ogg
	MFPrQvjK/QBfJRngyaFoFfVOzKJlgKM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-BzdJdX4bM3SpWBg1eEVrDQ-1; Wed,
 02 Apr 2025 06:58:44 -0400
X-MC-Unique: BzdJdX4bM3SpWBg1eEVrDQ-1
X-Mimecast-MFC-AGG-ID: BzdJdX4bM3SpWBg1eEVrDQ_1743591523
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E1C19560B3;
	Wed,  2 Apr 2025 10:58:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51CC5180B48C;
	Wed,  2 Apr 2025 10:58:41 +0000 (UTC)
Date: Wed, 2 Apr 2025 12:58:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Joe Jin <joe.jin@oracle.com>, util-linux@vger.kernel.org, 
	Zhenwei Pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
Message-ID: <nvr7vxglqy3r5ody4gnuz5eouwo3j5d2w7edl2rtbemdnddjue@s5twzwylm4zf>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
 <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
 <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
 <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>
 <3b638c6f-e304-4771-b952-3f7172779966@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b638c6f-e304-4771-b952-3f7172779966@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Apr 01, 2025 at 11:17:47AM +0200, Benno Schulenberg wrote:
> 
> Op 31-03-2025 om 18:12 schreef Joe Jin:
> > > > Why remove the "Q"?
> > > 
> > > It looks ugly.  And why would the user want to hold Shift before pressing q,
> > > when just pressing q will do?  Holding Shift has no extra effect.
> > 
> > Then should it be removed from parse_input() as well?
> 
> No, there it should stay, to accommodate users that for some reason
> have CapsLock engaged.
> 
> I would propose the opposite change: to accept also the uppercase I,
> T, D, and N for sorting the table on the corresponding column.

I prefer your current version of the patch (keep Q usable for backward
compatibility, but don't announce it in the docs/help). I don't think
we need to extend support for uppercase letters. The letters are rare, so
save them for the future :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

