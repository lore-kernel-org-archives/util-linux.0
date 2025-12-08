Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD87322768
	for <util-linux@vger.kernel.org>; Mon,  8 Dec 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203921; cv=none; b=s9oDCqWCoaPYmtOugmfDRVIvHbbOW8mkw8VPsBmcmRtrERbgoLfF/AoGsk8bnY5CdeFRLQ8hJDRTqiGltL2bo/3Pwty5FhChl1RS3kOHH0qinWymYT7GHv1iRLv1n8EQcLUCxAxDLoDxPZRE+i3Ew7vtavt6iwx9QpudOPpy4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203921; c=relaxed/simple;
	bh=KgyVPoqliG/gWqyg8jhYLpl6NznpepV/smDgn/Heh3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XsTPdDS+csM0fvNMilFQxNNivnFSPuvSJy3a8CM9Ak9pVPpL8ulX/VIQa1a+9mqMozFiWfSHs+1k6/jiwEAEwbuRX8sALhH1w1A4rk5Pq1l+CTS3nV5s/PvwpFccnNhAFCfPoLNJa+kqK+ca89rNgc5mCl93MyrNi6zXBvtQ32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFI9oi6Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFI9oi6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765203918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nBtmiGgUM7iA0TQld2qhDrlJsUkOlYjTz5JVV/BRnw=;
	b=EFI9oi6YpsDplp3SKhBhQFehUX0k2HQ3CMbaAlT3ONV2tWhvtHMAEAlDgu6znqUiUM9Rbv
	bnrkAZWjdoNxZs/lQyo6kTK6gKpX2pZ5GMPqvqEqG/QdwmIPDKtWGHbdTE/TOzdHcSQrgz
	peewe0P27DUfgzcJ/Bu+rXNUbhqlZyM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-JfzgP6lwPVKSS_NZa9TvqA-1; Mon,
 08 Dec 2025 09:25:12 -0500
X-MC-Unique: JfzgP6lwPVKSS_NZa9TvqA-1
X-Mimecast-MFC-AGG-ID: JfzgP6lwPVKSS_NZa9TvqA_1765203911
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D98BE1956046;
	Mon,  8 Dec 2025 14:25:10 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 259391800367;
	Mon,  8 Dec 2025 14:25:07 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>,  Alejandro Colomar <alx@kernel.org>,
  Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
  util-linux@vger.kernel.org,  Xi
 Ruoyao <xry111@xry111.site>,  GNU C Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH v2] x32: Implement prctl in assembly
In-Reply-To: <ad7ac28b-fa81-48a1-b3f5-e2ab21f83c51@linaro.org> (Adhemerval
	Zanella Netto's message of "Mon, 8 Dec 2025 08:47:27 -0300")
References: <20240601093150.16912-1-alx@kernel.org>
	<460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
	<mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
	<5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
	<CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
	<lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
	<CAMe9rOqMGabug88Qm7p22Qk+oMOk9YdbAQeyb77rL3ot4HS1UA@mail.gmail.com>
	<lhuzf7tl7fz.fsf@oldenburg.str.redhat.com>
	<CAMe9rOq6mx_ZQs_z2QazC2pbvJZDZzD7kLCo=_o9eTj3cUh8nA@mail.gmail.com>
	<lhuqzt5l4pk.fsf@oldenburg.str.redhat.com>
	<ad7ac28b-fa81-48a1-b3f5-e2ab21f83c51@linaro.org>
Date: Mon, 08 Dec 2025 15:25:05 +0100
Message-ID: <lhujyyxjbjy.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Adhemerval Zanella Netto:

> On 08/12/25 06:09, Florian Weimer wrote:
>> * H. J. Lu:
>>=20
>>> On Mon, Dec 8, 2025 at 4:11=E2=80=AFPM Florian Weimer <fweimer@redhat.c=
om> wrote:
>>>>
>>>> * H. J. Lu:
>>>>> Here is the v2 patch to implement prctl in assembly for x32.
>>>>>
>>>>> Since the variadic prctl function takes at most 5 integer arguments w=
hich
>>>>> are passed in the same integer registers on x32 as the function with 5
>>>>> integer arguments, we can use assembly for prctl.  Since upper 32-bit=
s in
>>>>> the last 4 arguments of prctl must be cleared to match the x32 prctl
>>>>> syscall interface where the last 4 arguments are unsigned 64 bit long=
s,
>>>>> implement prctl in assembly to clear upper 32-bits in the last 4 argu=
ments
>>>>> and add a test to verify it.
>>>>
>>>> What's the advantage of the assembler implementation over the C
>>>> implementation?  I'm missing the context for this change.
>>>>
>>>
>>> It is inspired by
>>>
>>> commit 6a04404521ac4119ae36827eeb288ea84eee7cf6
>>> Author: Florian Weimer <fweimer@redhat.com>
>>> Date:   Sat Feb 17 09:17:04 2024 +0100
>>>
>>>     Linux: Switch back to assembly syscall wrapper for prctl (bug 29770)
>>=20
>> The justification for that does not apply to x32, though, because prctl
>> doesn't take floating point arguments.  I don't have a strong opinion,
>> the C and assembler versions are of similar complexity.
>
> The main justification is UB to va_args *all* the arguments without taking
> in the consideration which option is passed.  If x32 requires additional
> argument handling to clear the upper 32-bits, there is no advantage of
> using the assembly wrapper.

I'm okay with making this change to avoid UB.

Patch looks okay to me.

Reviewed-by: Florian Weimer <fweimer@redhat.com>

Minor nit:

+weak_alias (__prctl, __prctl_time64)
+hidden_weak (__prctl_time64)

This isn't necessary because there is no __prctl_time64 on x32.

Thanks,
Florian

