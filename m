Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A71A83E4
	for <util-linux@vger.kernel.org>; Tue,  1 Apr 2025 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496524; cv=none; b=oHpKs0GfNMX5TCnYR1HIrsnYFBniXW12b+qxKOFcWJ76JSluNpYS3yNuaLvS9xp4SduWtvnkoyXcUR8qyJi0P3kMumNNS2Pyvd7asNviQagkxrEeQVfp/q61J/GH4Rr7FdjqJmvaUZBcK4dAgQ5aaZ+XXE9kpMDddaElN32eWGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496524; c=relaxed/simple;
	bh=5ON74j/25z81FITlNItlvqj7F3H6leBFJaWdnmqLBhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L64AWIFLVd26ac5ha2ZQo2zrcyPt6wbr4jjHb31X8YXZ0TdY6Z0bog7P9RseCjqDJ6woAEnNik3OkgqK3fkor3dn39foGK6ffNvHoHkfpCgpEN4OCIxR1JAWiOAThNn1WhmMfQi41FZIgcYMSxzAenu0fxJikU9cMvzBi2h1hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXdijnnI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXdijnnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743496521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MzBS+nCEHR2+kwHc4Ui/M7iw2HRhu+Stm7t7yPhFzgo=;
	b=eXdijnnID3Q8KePqtGaL2fkQH1wu5t+fs58YwGr4zakgGRRXatZJNhZK7GDW11dU//mhRY
	KkLKntpSdLwQ4TNJIEQdCJFx+7hgR1fxTKH2EFf6QbRaD9F/EWJNrta9RLBTBFtiLUlFB0
	zg7btm6PqK4GCIB9Xc7D7oMxcxdgyP4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-FZeHpjRFP_2YeusAaTPgrQ-1; Tue,
 01 Apr 2025 04:35:19 -0400
X-MC-Unique: FZeHpjRFP_2YeusAaTPgrQ-1
X-Mimecast-MFC-AGG-ID: FZeHpjRFP_2YeusAaTPgrQ_1743496518
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAD31180049D;
	Tue,  1 Apr 2025 08:35:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00B861956094;
	Tue,  1 Apr 2025 08:35:16 +0000 (UTC)
Date: Tue, 1 Apr 2025 10:35:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org, 
	Thijs Raymakers <thijs@raymakers.nl>
Subject: Re: [PATCH 10/10] coresched: rename option '--dest-type' to just
 '--type'
Message-ID: <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-10-bensberg@telfort.nl>
 <20250331110902.GB120637@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331110902.GB120637@pauld.westford.csb>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Mar 31, 2025 at 07:09:02AM -0400, Phil Auld wrote:
> Hi Benno,
> 
> On Mon, Mar 31, 2025 at 11:44:43AM +0200 Benno Schulenberg wrote:
> > Long options are nice, but they should be as different from each other
> > as possible, so that one can abbreviate them to just a few letters.
> > (Not that abbreviating matters here, but that is the general idea.)
> > 
> > The side effect of this change is that the usage text becomes more
> > readable.
> >
> 
> This one seems a bit more like bike-shedding. We did go around a bit
> during development.  I don't remember if a version of util-linux has
> shipped with this in it or not yet but this could break users. There
> may not be that many yet anyway, of course.

It's already released, so it is truly a backward-incompatible change.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

