Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457013939D9
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053486; cv=none; b=NhPC/yM11YGx14VJnfoExOdURPN+mDhWELSJtzGRYBcQfvcJAIvcYyssANRsEHkpjZmhrzxHrXJlMT/K1oCXMohHcVKrfW9yuIPHcv2dunrIaYE9szkBQO/5Q/B4n3SGusQi0vw1o+I7ifkakVvVGJK9VImBYTVqpPDiBa9dAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053486; c=relaxed/simple;
	bh=jXf3yOnFO2K5Y5BJgZMVYupPk1wlKGVQ/OObNXCx8bM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M0kNoZynNNWBPgg6q+AVXoCi0wzu84anrVWceBnhGfprpWNPZrxSPpmzGaF8ZWhRsB3bPvL6qRUprqTrrs4yPTg+6LKuIkg4OY1rw5YB5aIpd48OlsZryvCO3/woEebUq2OejswFUYKX19hPYCBKYSUvW2ZY9knP5l3NsIV+qb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP8vbpxG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP8vbpxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773053481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=v+szJVdYcfO1TwwHdOAs9/Wlx0CQCdVxGTEgNiyaKLk=;
	b=iP8vbpxGh4vi7QiS8PEP5rowFam/O5QRD1osbed/1v9sI5WBxYokTi0PuHSaopf7IloEm0
	I3Q94fuLVPPKZ8JZd8G8i8sgy++IO5rbBHuOwqLphBybcB+5ne8cuV6NpvuC/37WIa5MW3
	GDDAA/kgfFOsJJEX4qovIFivCf0Mmfc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-UyEEE-fhOGu3IIFmOXvXvg-1; Mon,
 09 Mar 2026 06:51:18 -0400
X-MC-Unique: UyEEE-fhOGu3IIFmOXvXvg-1
X-Mimecast-MFC-AGG-ID: UyEEE-fhOGu3IIFmOXvXvg_1773053478
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC29C1800283;
	Mon,  9 Mar 2026 10:51:17 +0000 (UTC)
Received: from ws (unknown [10.44.34.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEEAB30001BB;
	Mon,  9 Mar 2026 10:51:15 +0000 (UTC)
Date: Mon, 9 Mar 2026 11:51:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] findfs: (man) improve the markup, the layout, and the
 wording
Message-ID: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228115245.9553-1-bensberg@telfort.nl>
 <20260301164505.24409-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Feb 28, 2026 at 12:52:45PM +0100, Benno Schulenberg wrote:
>  misc-utils/findfs.8.adoc | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)

>  lib/terminal-colors.d.5.adoc | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)

Both patches have been applied. Thank you, and sorry for the delay.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

