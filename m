Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397CF23B63E
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446882; cv=none; b=F3fNkfHPGjUsvAElc0z90Dpaq6/ZerGQhvCoY+Bu30ncDczcPjM1ziDnMGjFPJcLRxDn0OEECXviz4TW1UJEW2RmDAauuZawg4373Gh1HAnOSgh37u+1Q95+K8+SCoYbwuH8doUPKv/qQ57nMl/F2q0OTS0fenvmLbMyJTEZztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446882; c=relaxed/simple;
	bh=fUfSSXb3Yuz7+X51rnMpxDN3y7jEtgCreuP/rtrTKAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7afIdWdWorIWwBUYiDvHF7rqsOd5TJQandCtJnt0v+DMY6Cz6tblTjWhnndsamEsaPofXnzdkQwhyreEtpEum+BVUJbSQtZHWwmnVIdzlMWyqdAlGZd3w7QRBVjmpwB0Y8z347CQshJ8ljAVPXwC02pQ3ycuk98oIwMXFW4uSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLC24Emr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLC24Emr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751446879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uXn2Hk8xWs3JH3N9QhE7cymQrVdufoFGezc2hEwxKos=;
	b=KLC24EmrdDckDlzjioUDUSwhNyBtR8wUVzNp39ztypOkz5SJ0zzs5m9+7cyRvrYfOfFloG
	1p4v0dh/ku1KvruXjze5YcZ1LZ2XcIxnFpWLEutcyPkPsKD8z6PSE5X2RS91uzPcao9zhU
	hnz0S1CSTFVUxIl+Memet9PDB/7kg8Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-NY3pVjHLOmuRbztrDoMVpg-1; Wed,
 02 Jul 2025 05:01:18 -0400
X-MC-Unique: NY3pVjHLOmuRbztrDoMVpg-1
X-Mimecast-MFC-AGG-ID: NY3pVjHLOmuRbztrDoMVpg_1751446877
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9B21955EC3;
	Wed,  2 Jul 2025 09:01:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7D021956087;
	Wed,  2 Jul 2025 09:01:15 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:01:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
Message-ID: <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
 <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jul 01, 2025 at 03:39:57PM +0200, Benno Schulenberg wrote:
> 
> Op 01-07-2025 om 07:16 schreef Madadi Vineeth Reddy:
> > Nit: I think we could still have "Try 'chrt --help' for more information."
> > along with your "too few arguments" so that user knows exactly how
> > many arguments are needed.
> 
> The reason I don't want to see "Try 'chrt --help' for more information."
> when I make a mistake is that it means that I have to read two lines:

We should be consistent. The `errtryhelp()` function is usually used as the  
default error for an unknown option or when the user is "lost" on the command  
line, for example, if not all required arguments are used.

  warnx(_("too few arguments"));  
  errtryhelp(EXIT_FAILURE);

(or "bad usage") is consistent with the rest of util-linux.

I can imagine a new  function `errclimess(EXIT_FAILURE)` (or a better
name ;-) for exactly this case  to avoid creativity in code. We can
use it everywhere and keep the error message  on one line

    "unexpected number of arguments, try chrt --help"

or so. Would this be a good compromise?

> the error message plus the "Try...".  It takes me more time, _and_ the
> second line doesn't add any information -- it just states the obvious.

It does not have to be obvious to all users, -? -h, -H, --help, sometimes
nothing, etc. 

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

