Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F69475
	for <util-linux@vger.kernel.org>; Sun,  7 Dec 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765100506; cv=none; b=cicE4Jjrt+AjvsXQ0J6Ea7pW2D5BohYtSaQ2XuFeHepZ9R7K6IrQcCiYcqzCbfSQM3dQzydCJdP+H4zkwjfFETclO8f/bRhlzBBmKQa6qEt9dqWxTQfYjT0B9OcPVYsgJ5dMrpFIEV8UiBM1fBl29BeaPxNsw+P1RFSdMRBVz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765100506; c=relaxed/simple;
	bh=+HZlTm3G1FF09eogWky3G6Eq6GmzaCAmV3IIeRhqQOQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NVyPwwLhJxV8KhN0G/LGSVqbUKXY+BK2OKlKCOh087WtNfPsNbUOz29bJVpxwpHuCu/4gpF+uQ0bLFMeq/Owz8hGjH5UxpEcVlSgO5K65DLJC1wr+K/jaxMbMG3ckgME5FVO1Gf1ym58rsv5UCmOcag9Ulz9QRgLYxXn4uIgAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/TFtGGk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/TFtGGk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765100503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBTRUi7w3nfBxuGZrUJ42DmtBSoKx+IBIgTseBy+ycw=;
	b=M/TFtGGks3yE1LYWa23KWWBG1UkadbAPP/bwG5MBrio253mVwO80EH5nyFG77X2dBBNJfN
	U5togNskg3FB0tmHDkrGsTea5wLK5131eiFIF3Lg6YXDsvY+8fT5E2pdrFklP4x+0Ht2t6
	+QzU4qoc+MYQbXUGQrHZ3o/26WizkeM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-ChO6y95WNSOrtk9Wq1JqrA-1; Sun,
 07 Dec 2025 04:41:38 -0500
X-MC-Unique: ChO6y95WNSOrtk9Wq1JqrA-1
X-Mimecast-MFC-AGG-ID: ChO6y95WNSOrtk9Wq1JqrA_1765100497
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 360A11956095;
	Sun,  7 Dec 2025 09:41:37 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD4413011A86;
	Sun,  7 Dec 2025 09:41:34 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,  Alejandro
 Colomar <alx@kernel.org>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>,
  util-linux@vger.kernel.org,  Xi Ruoyao <xry111@xry111.site>,  GNU C
 Library <libc-alpha@sourceware.org>
Subject: Re: [PATCH] x32: Switch back to assembly syscall wrapper for prctl
In-Reply-To: <CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
	(H. J. Lu's message of "Sun, 7 Dec 2025 11:52:08 +0800")
References: <20240601093150.16912-1-alx@kernel.org>
	<460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
	<mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
	<5272b875-bec8-4b28-84e8-05606db83120@linaro.org>
	<CAMe9rOpqX9cdhvMneHnfvJFG8ixJsdAyd6iK8mh_Th1Lpv4ahQ@mail.gmail.com>
Date: Sun, 07 Dec 2025 10:41:31 +0100
Message-ID: <lhuh5u2aat0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

* H. J. Lu:

> On Thu, Dec 4, 2025 at 10:06=E2=80=AFPM Adhemerval Zanella Netto
> <adhemerval.zanella@linaro.org> wrote:
>>
>> The x32 and or1k (which also uses similar implementation) does seems bro=
ken
>> without checking the 'option' argument to see which arg we can va_arg.
>>
>> The problem is adding this logic on libc will add some forward-compatibi=
lity
>> that we try to avoid (newer kernel prctl additions might now work correc=
tly).
>>
>> I am not sure why we haven't switch x32 back to the assembly wrappers
>> with 6a04404521ac4119ae36827eeb288ea84eee7cf6 fix (BZ#29770).  H.J, can
>> use remove the x32 C version (and also or1k as well)?
>
> Since the variadic prctl function takes at most 5 integer arguments which
> are passed in the same integer registers on x32 as the function with 5
> integer arguments, we can safely use assembly syscall wrapper for prctl
> for x32.

The C implementation clears the upper 32 bits of registers.  Does the
assembler wrapper do the same?

Thanks,
Florian

