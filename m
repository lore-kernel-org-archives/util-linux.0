Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0326AD3
	for <util-linux@vger.kernel.org>; Tue, 23 Jul 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721739426; cv=none; b=aRoMGxxkB3qgNAGJhNtvja5A2IvgVcrrPqSFqvFDcXjJ+AJetM6h6BkDN05lRV0wz9Jhnr08+S4WbnnWmlDLzm6LF4tly2eVLi8WxaKfATTffLhNsp6UKb8FoufPTcbW/AlAquc8gSNx4/RZqY1RCf3Wut4Ws41PTdOSfJK/bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721739426; c=relaxed/simple;
	bh=1HaAd4LOwDbYEhax/Gf5KyxVtWNR9ueAiCPFALY57KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+abVn3dkkPgN+QeKcpP5axqA6SG4QDrfKSxGnI4JJ8U45YU+4x13d7eZf0Le4DWiImKsN1nj6xYLL+ELUs/uBC5GK+55vjXfbXMBIg+PFiuL7YpxBKc11TnLXQ8MMGsNKnkFe7+pnNfK5tIKX2xfp376ywtKDplT/bKNl0SqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze/20GAh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze/20GAh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721739423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3sn20G6RsLUjB8mrn4XlC/kXlZyZRCBkjzqFXrnjc8=;
	b=Ze/20GAhcQ5My+6995XDKKYjVoVzdjmXZgtiQZ1MuHGNwVbRiy1jAszpZm16oWtxiOZOPj
	2XCcUbBrp4OyEH884h2xov4zBSUB+byjDmf1kL8NHbiUYFBpVCwta2dVvu4FPZOEZSbPVE
	LGJvsrtaXifqBE/yxeCFMzwfPTECpz4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-pIdEpEhbO-SfvZ2MMBnjtg-1; Tue,
 23 Jul 2024 08:57:01 -0400
X-MC-Unique: pIdEpEhbO-SfvZ2MMBnjtg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5593B1955F6A;
	Tue, 23 Jul 2024 12:57:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.177])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 585B11955E80;
	Tue, 23 Jul 2024 12:56:59 +0000 (UTC)
Date: Tue, 23 Jul 2024 14:56:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Prevent cursor escape
Message-ID: <kbdtjvbk6d7tazpqblki75tjatmqvq54hzxyybrb4uh4kjwevl@rzsfd2cofobp>
References: <20240721130142.468136-1-sbrabec@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240721130142.468136-1-sbrabec@suse.cz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Jul 21, 2024 at 03:01:42PM GMT, Stanislav Brabec wrote:
>  term-utils/agetty.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

> +						write_all(1, "^[", 2);

Not sure if we need anything more robust here. If you have access to
the terminal, you can write whatever you want and it will be interpreted
as a username (meaning non-terminal code will interpret it).

There is include/carefulputc.h:fputs_careful(), but it's currently
based on FILE streams rather than file descriptors.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

