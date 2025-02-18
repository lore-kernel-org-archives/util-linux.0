Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6AD26FA5E
	for <util-linux@vger.kernel.org>; Tue, 18 Feb 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898909; cv=none; b=CFQEOz0KFqsmNjVW3KXZVfjcbn+zhzaj+X6TUHFDv0qRmcA0NCF4hbAdZJHVUDAGYNz9No/9Ym9DXAq09I6rXDYO4SvktCgdoJvsIdjpo7XvTX7xjBJ4K+vGoaeTgomogpAfS1rj/sbCjmLnz1PWaYJSlcIGopvTIDH5ZW52PmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898909; c=relaxed/simple;
	bh=U1mdHKhAf14Ple0hULeIaHIdS3xpeSk4whLud/eMpwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdEagmBhosDL6nnhVOJNInLwfirRjBWDia2oSuB7eeQHw31S03xrAmTcy/2sWTJkb7KKJwquPvNDBB8TXTw8M5pKbpH69muQ0/qjThmH5EaW1PxA0+Ksa0ln7y4sUI34JFvsalE+6gWqFkgBO+0O0PJKwUbIVM0iZwpCOGhzSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+GmxlYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+GmxlYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739898907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9KAOOdqTEzsgtWjJ2wlygTL9BKD6FO0b6+cb9tIkEo=;
	b=C+GmxlYsxNXuwPQUm4N3xNQ/2TkPT2KUn743GvQueybk8SO/NNhtZ4JU1nq5EgI0Ad5gx+
	hoH7fSY+WQbps7pS7xc+cAMcNQeCF4j/62gTETi35itJw4EQKjC2peH0Fi1jkCUebW6GnQ
	6uuunCsXuh9v8L5FAyafybWZXbutnpw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-HBbKqxSoMwaeZLZaJDqdIQ-1; Tue,
 18 Feb 2025 12:15:02 -0500
X-MC-Unique: HBbKqxSoMwaeZLZaJDqdIQ-1
X-Mimecast-MFC-AGG-ID: HBbKqxSoMwaeZLZaJDqdIQ_1739898901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 346E518E6952;
	Tue, 18 Feb 2025 17:15:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34C59180035F;
	Tue, 18 Feb 2025 17:14:59 +0000 (UTC)
Date: Tue, 18 Feb 2025 18:14:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] colrm: make the wording of the doc string
 analogous to that of `col`
Message-ID: <rue2kogvbmgegef2bw2lq2yj7il3zlnfir4pgzhdmzaylj6pni@i4n2i4ofjnpi>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Feb 15, 2025 at 05:18:34PM GMT, Benno Schulenberg wrote:
>  text-utils/colrm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied (with your other patches), thank you.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

