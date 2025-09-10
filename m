Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA5F25A32E
	for <util-linux@vger.kernel.org>; Wed, 10 Sep 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493627; cv=none; b=EMpqkFXfZsBPqg45ByAw2Nti6Z0sUgl80fVD60Qp5cKDa6ydF4HMTXYuZt8W0k8Tzp6UZYvZdtBVI95iX261cvGYoUudiqNtWGdvFCnroAyX0vtzzeo0pMH8BPaHjtlo0NwQlB7prWtsN+DOi+JEr0sSY5jAbwGkaYUx4snI4XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493627; c=relaxed/simple;
	bh=mMhxZ2TsIOqb0TPMaoZEQ7/KJ4bdjUhxGIDxXB5QJcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dju5xgZbx2mvD//DOxk8UpP2kxz71Ys8F9FZJc+gNy0bNBC9JyN7cbc/xbNKVWdFW8ziTRUzLmNdBA+AJWSbvjK226FdFXBA++Nn3T+I7v/gnZIQEwc/GXTzh6PkltagEpr2Hw5hThcoTfq84C9wF0TexmsCuVe0ST6nUZVYtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOvpms8n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOvpms8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757493624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3tfn0Lhv8kfVPzLkWUkNRfGEMcJyF9qfRFRpAKBWo8=;
	b=MOvpms8nyNJWvFwNsqPZPM6LxuEDwdZOLKhOL/UzOTOxubTpvzceTkAC7VvNDjnjcI50qR
	MASsouvlSTI+GADCitX1S4X8pEA8LOrkSC3YQNjUu3ndAIUJHaFO40UBdf0rXFnOdoN0fX
	l+lbgvr55QnG+E9UfP1DeX74ls31ULk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-m1ISsYz_PoOf6qYRXYJieg-1; Wed,
 10 Sep 2025 04:40:21 -0400
X-MC-Unique: m1ISsYz_PoOf6qYRXYJieg-1
X-Mimecast-MFC-AGG-ID: m1ISsYz_PoOf6qYRXYJieg_1757493620
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4700180034F;
	Wed, 10 Sep 2025 08:40:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.53])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADECC1800447;
	Wed, 10 Sep 2025 08:40:18 +0000 (UTC)
Date: Wed, 10 Sep 2025 10:40:15 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, 
	Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Subject: Re: [PATCH V2] sfdisk: (man) do not use the common 'include' for
 --help and --version
Message-ID: <prtt3qvlnsee3ag67qob6qxhyhgrs5nysqssyfabdtihx6jtff@34hgyxnbnsoe>
References: <20250909151208.81179-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909151208.81179-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Sep 09, 2025 at 05:12:08PM +0200, Benno Schulenberg wrote:
>  disk-utils/sfdisk.8.adoc | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

