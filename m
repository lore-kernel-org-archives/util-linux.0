Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407727F754
	for <util-linux@vger.kernel.org>; Mon,  6 Oct 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754031; cv=none; b=nEqqtW83QsBKaP67hZxNiz7iMDL8mlLDkWDKlRwrIPHBYYoaKuaHAH1lXxirv6yYS93GlR4nM0aM4f9EK1SVOUl6FrFCDucXC0xekZOxgLqABtxcGhTG/6esQdujWPDbPkfmWmR6aDx8yHLiiZ8yfWApHGO0F3B97zwWyP7TMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754031; c=relaxed/simple;
	bh=LCePs+IOgCSwaH0Tq9R5v6yVUxtaJtcHgqy7rbolp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofksk70a3nCuVt3c5h9tupoW8QT+iMrfduZ9SK11TPM1ko2PUYLHRnqhFVtBqxGrCG8rQEfkhVj96s051Opn8QJqzlm4477K3gjEBEufoLcj7JHzhk8kQbjrFeT9KSj3HppFuPYBQDzuEYFZkUUW5qFzpGxwAy/JzDTOFcYTK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOkxR6h8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOkxR6h8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759754027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aP0LfcxProMRM25y32O2CmK7+zrqa0rwpUfcM94oqS4=;
	b=EOkxR6h8qwNyTtTEsjBsWs7F3ZGTrydqE6cxm6qF45yMmGSCS0NpAeK6SHNdCbthR9Psnz
	R9vP9XK/kbonSsIebWJj2iWSwxzxAxhDdWwi2c2flUaahrDsrevynq/7OcaJpyUDAHlyXc
	DpEuSNRg3VgkzqBYYfx1Q0D4cMTc26o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-Pble-GzbNHWVpIDCWOj3qQ-1; Mon,
 06 Oct 2025 08:33:43 -0400
X-MC-Unique: Pble-GzbNHWVpIDCWOj3qQ-1
X-Mimecast-MFC-AGG-ID: Pble-GzbNHWVpIDCWOj3qQ_1759754022
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FC731956096;
	Mon,  6 Oct 2025 12:33:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED6811955F19;
	Mon,  6 Oct 2025 12:33:40 +0000 (UTC)
Date: Mon, 6 Oct 2025 14:33:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>, 
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] swapon: rename the new --annotation option to
 --annotate
Message-ID: <uigarzupkiecv6qzx3jpddmbx6g7exx3m3gk6jecahcdhm7zwv@qa6aymiykuhc>
References: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
 <fed873ef-7480-4f91-a5ea-a10fe5e61654@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fed873ef-7480-4f91-a5ea-a10fe5e61654@telfort.nl>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Oct 06, 2025 at 11:57:50AM +0200, Benno Schulenberg wrote:
> 
> Op 06-10-2025 om 04:02 schreef Christian Albrecht Goeschel Ndjomouo:
> > FYI, I added your patches to my pull request* on Github and for completeness
> > I renamed man-common/annotation.adoc to annotate.adoc and adapted the name
> > of some variables for clarity.

Applied all the patches, thanks guys!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

