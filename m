Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C0E1B983F
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765185014; cv=none; b=b+MxdE2T6ZtNmx3TXQs2PpEtsESZSvqy+KRPZ3ZjTMf9x5GTYzMMoTuBB+e7nX5Pm+IilmEhfXQOXF6tynSlIOsG/wJ9KlO4CFm4in9EdmQhdNvaF3NBYZWcWC8I/ipWAGjFOUpbd7ltm8bUofMlpmk82MX6X10E8jHMkZH7bzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765185014; c=relaxed/simple;
	bh=L2CxSdbO7PBdiIkjsOYHMF3R8DzdHuJoAZS4vw6EAmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hfYl924+y4hBqXvLJIxGoMvuFZao1xCs7Cjb61/JfeZWMgq6E6il4oyMvJOQeOsFLrUMHniC+3IYj1zSYMGJYgtDenNu3E+bg4f5NkYgIIy6YCiNgC3MDxsCF0n5ChegQa1U9zf0Ive9KBhiue1qFKwX6jx9lN4KYcqTeT38AMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZ5jUJQK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZ5jUJQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765185011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f6fwxrSqA41RIJBfPeg6XGZWk5xirQ5kkcARcZBouK0=;
	b=MZ5jUJQKZa4kz8QEBttv98l3pz/Li2DXp4dWyB2Guv0mh+J7lmrHVFNAdF6IdRTfrZsVyi
	7wdQFO8R69slwEinDB+4GIZgpnuY0SzDCX7TXkyzMGmloSSNckayo3e+2tXe2Zvzt9XnTq
	KsNRm2eHOM10YA9j5aLwa9h1jY0BbXY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-cYVPKD6aOKGBowKYRjLYxw-1; Mon,
 08 Dec 2025 04:10:07 -0500
X-MC-Unique: cYVPKD6aOKGBowKYRjLYxw-1
X-Mimecast-MFC-AGG-ID: cYVPKD6aOKGBowKYRjLYxw_1765185006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8DD91956058;
	Mon,  8 Dec 2025 09:10:05 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5E351956095;
	Mon,  8 Dec 2025 09:10:02 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,  Alejandro
 Colomar <alx@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>,
  util-linux@vger.kernel.org,  Xi Ruoyao <xry111@xry111.site>,  GNU C
 Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH v2] x32: Implement prctl in assembly
In-Reply-To: <CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
	(H. J. Lu's message of "Mon, 8 Dec 2025 17:01:14 +0800")
References: <20240601093150.16912-1-alx@kernel.org>
	<460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
	<mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
	<5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
	<CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
	<lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
	<CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
	<lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
	<CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
Date: Mon, 08 Dec 2025 10:09:59 +0100
Message-ID: <lhuqzt5l4pk.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* H. J. Lu:

> On Mon, Dec 8, 2025 at 4:11=E2=80=AFPM Florian Weimer <fweimer@redhat.com=
> wrote:
>>
>> * H. J. Lu:
>> > Here is the v2 patch to implement prctl in assembly for x32.
>> >
>> > Since the variadic prctl function takes at most 5 integer arguments wh=
ich
>> > are passed in the same integer registers on x32 as the function with 5
>> > integer arguments, we can use assembly for prctl.  Since upper 32-bits=
 in
>> > the last 4 arguments of prctl must be cleared to match the x32 prctl
>> > syscall interface where the last 4 arguments are unsigned 64 bit longs,
>> > implement prctl in assembly to clear upper 32-bits in the last 4 argum=
ents
>> > and add a test to verify it.
>>
>> What's the advantage of the assembler implementation over the C
>> implementation?  I'm missing the context for this change.
>>
>
> It is inspired by
>
> commit 6a04404521ac4119ae36827eeb288ea84eee7cf6
> Author: Florian Weimer <fweimer@redhat.com>
> Date:   Sat Feb 17 09:17:04 2024 +0100
>
>     Linux: Switch back to assembly syscall wrapper for prctl (bug 29770)

The justification for that does not apply to x32, though, because prctl
doesn't take floating point arguments.  I don't have a strong opinion,
the C and assembler versions are of similar complexity.

Thanks,
Florian

