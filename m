Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BC248886
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765181470; cv=none; b=YbrtWtkNWUMVjPXAA1ErK4yrJCWpG0wSvWXdK4uIzBNL2QxF8i+HMAkQYV++4b3BCmBzHHYvQofMhKzxSp3aToXTE3PaNx0DYUbfuKtblXrnCMCI3PcLxVF5lUAQDo97iyoww5BD/tod60uCWGjxgJyE1YHsFlg+gZpVHFHXZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765181470; c=relaxed/simple;
	bh=i9hrmQMg60YD7q6sP1yUK5mBeiSffI+rKKXLUkcZO1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBvzQ9Tv51BCWGjaNyjF8+LRVDqsjrz2VfWC1FcU+Cy7KKxl3adzsw1nDDq4ufvdt7C1GV+bFTfN86AMRIoMwo8CjMol7+15LKJ/frjXin9AeUu9L6um6dkPujrD/FdfyHZ+P04QU/XJgwuUeIyN0n1kgaUgLJ0IpxW168alpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXafDCD+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXafDCD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765181465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/4h3Y/gcaGnCyMtv6uXSceTtUnXgyRIx8dr+bctoMo=;
	b=gXafDCD+6swR6ku5tbaWSZD9zTlg3DOPvKf2KALleW6eV4ZI9fl/LigY1IcNulrC+O3sUQ
	2dQ9D3A/ioiR8eqONM+MmLw3NNbeA5Z6FIciHLYYBK1YFx3wMQrr31FuOD2jSWlY4hT5D0
	lNO0fd01u1hwxLAbiX6PrDrb6OHP4hU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-Rln1VOvdPryub8Tqmp4dIg-1; Mon,
 08 Dec 2025 03:11:03 -0500
X-MC-Unique: Rln1VOvdPryub8Tqmp4dIg-1
X-Mimecast-MFC-AGG-ID: Rln1VOvdPryub8Tqmp4dIg_1765181462
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4E18180034C;
	Mon,  8 Dec 2025 08:11:01 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D01918004D8;
	Mon,  8 Dec 2025 08:10:58 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,  Alejandro
 Colomar <alx@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>,
  util-linux@vger.kernel.org,  Xi Ruoyao <xry111@xry111.site>,  GNU C
 Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH v2] x32: Implement prctl in assembly
In-Reply-To: <CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
	(H. J. Lu's message of "Mon, 8 Dec 2025 09:48:55 +0800")
References: <20240601093150.16912-1-alx@kernel.org>
	<460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
	<mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
	<5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
	<CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
	<lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
	<CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
Date: Mon, 08 Dec 2025 09:10:56 +0100
Message-ID: <lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* H. J. Lu:
> Here is the v2 patch to implement prctl in assembly for x32.
>
> Since the variadic prctl function takes at most 5 integer arguments which
> are passed in the same integer registers on x32 as the function with 5
> integer arguments, we can use assembly for prctl.  Since upper 32-bits in
> the last 4 arguments of prctl must be cleared to match the x32 prctl
> syscall interface where the last 4 arguments are unsigned 64 bit longs,
> implement prctl in assembly to clear upper 32-bits in the last 4 arguments
> and add a test to verify it.

What's the advantage of the assembler implementation over the C
implementation?  I'm missing the context for this change.

Thanks,
Florian

