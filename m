Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CF1DB551
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996992; cv=none; b=XBs86ErxCvDCrCHlFo4UflRQm1q3AfWThGIPGcmEPMQN9yHmLjuRkEbGf6TJ8tqiUQEGc4+Hk6pX5fi16e+TggCdOesIkmQg0D7myLOdKZ+SgMyi+MPSKuV7dNMJqs5or5/S/bdN1dQP3KZvR3cJQ6mCUbqaEkpZXKMnuiPvmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996992; c=relaxed/simple;
	bh=7l1KgWUiIOrwnFRBPPr4L0T1gvLPc8FN6BTTx0A07tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaZ2Lrq+lRXgSj/rjCZ81WkmBK0FzbV/HsCQaplsDpnKx/kIwSneK1GZ/eUEBml3pQW0mnhC53R0a0dWzEzUqbhKFnPHQd2n/NVsQrOQbcvRFUTs9zI5bI9nfuM65bRzFwxnCjK9PAx8JjFacpe2rGgO9G6UU6BIreD+8bjSV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4ebmjB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4ebmjB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740996989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LUCqY1R3XQS75EKfuHpAk0eVk4opgAahkpnb5A64eI8=;
	b=d4ebmjB5sb7LeNeQqAKnRvqsDdUx+s2dxbVjPdt1qx8pNMFXm34YouO77wj0w6GcRsDFu0
	ccImWK234ECG4WBTQQQBtcw5KnkERyLltpnUI8lXngmk7V4uV8iXa2FDB9kd0kzABXLY9g
	RAVL/LnEGQ02qeQtwZXux+V3KyRGmXg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-UbP-o8RoNo6hQJSqk9Vg2g-1; Mon,
 03 Mar 2025 05:16:16 -0500
X-MC-Unique: UbP-o8RoNo6hQJSqk9Vg2g-1
X-Mimecast-MFC-AGG-ID: UbP-o8RoNo6hQJSqk9Vg2g_1740996975
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E319319137A2;
	Mon,  3 Mar 2025 10:16:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D9B180035E;
	Mon,  3 Mar 2025 10:16:11 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:16:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>, 
	util-linux@vger.kernel.org
Subject: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
Message-ID: <ycaevmuxkamyr6m2um4kqxhx5xh7jtcr2xoeadfz2v6cmcmrrf@lgpkcja4h7rk>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Feb 28, 2025 at 08:13:30AM GMT, Joe Jin wrote:
> This patchset add below new options for irqtop:
>  '-b|--batch' : Batch mode
>  '-n|--iter'  : Specifies the maximum number of iterations
>  '-J|--json'  : Json ouput format
> 
> Add below for lsirq:
>  '-i|--input' : Read data from file
> 
> v2:
>   - Removed macro irqtop_batch_mode.
>   - Replaced macro irqtop_printf() to inline function
>   - Changed option '--number' to '--iter'
>   - Replace strdup() to xstrdup()
>   - Added json output format for irqtop.
>   - Remove irqtop input file support.
> 
> Joe Jin (4):
>   irqtop: add batch mode support
>   irqtop: add max iteration support
>   irqtop: support json output format
>   lsirq: add support for reading data from given file
> 
>  bash-completion/irqtop  |  12 +++-
>  bash-completion/lsirq   |   4 ++
>  sys-utils/irq-common.c  |  19 +++---
>  sys-utils/irq-common.h  |   3 +-
>  sys-utils/irqtop.1.adoc |   9 +++
>  sys-utils/irqtop.c      | 124 +++++++++++++++++++++++++++++++---------
>  sys-utils/lsirq.1.adoc  |   3 +
>  sys-utils/lsirq.c       |  24 ++++++--
>  8 files changed, 155 insertions(+), 43 deletions(-)

Thanks for the update. I have created a PR
(https://github.com/util-linux/util-linux/pull/3435) to test it with
CI tests.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

