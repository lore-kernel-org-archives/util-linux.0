Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0E1E3DD1
	for <util-linux@vger.kernel.org>; Fri, 13 Dec 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105952; cv=none; b=lDF5NJ9t10eS+8GAhPFWVKAOcCN8IYewCfflB/KGV9hqEY6xM7aZ2/1C041Ihv/kFoGbtm15VtYrxK/wOP0yp6ePyIX6YJ5UI9/OP7kcm38ZBNieS7xZgSIQ6DDleG+WjTxuuNSI4/nBxtrkpXBNu+efw+fJbFGcorhiGAhscpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105952; c=relaxed/simple;
	bh=B32myiCdH9Byb7cyOmgE1VJx2PkjuX9dpLHjTw0V7bU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UA05l9DUZpXlnnr1lAXlCqz3K4PqrNYPfuJB6lvqAmrJ6FnXQMGsxRHz7L3tyv+6fC/Sba5FBDgibhT/lB1HNApDj4Aht0Uut1vMqYR11KMA6cYwhEkRKbrILzxeoVoHLYJs91p2ieeOoSnzgwjYiK1vD0S2vEOeSd/7JmycIyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpDrhzD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpDrhzD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734105949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKmba6bKv73tndQEtjDAiVXSJ4IQ31bWgXH1V5bkmVc=;
	b=CpDrhzD0WWF6bYTIVLDm5EcM6o4iosSe5+3Ry/Np45OxED1YjiFYbkAcXJLVeuCkOFbopf
	9CPLl7GU90HSt8JuI9TO06tOWS2naG8yM01v6BFR2N9YpQ0wCYWnPpZpkIABpBpnurjfqZ
	CcHFMxS89SNEcKKepIxuKWaAE19Q2Lw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-ekvhShQpNNOqd7_T4uexDQ-1; Fri,
 13 Dec 2024 11:05:47 -0500
X-MC-Unique: ekvhShQpNNOqd7_T4uexDQ-1
X-Mimecast-MFC-AGG-ID: ekvhShQpNNOqd7_T4uexDQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D2A01956087;
	Fri, 13 Dec 2024 16:05:46 +0000 (UTC)
Received: from localhost (unknown [10.64.240.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 086CB195394B;
	Fri, 13 Dec 2024 16:05:43 +0000 (UTC)
Date: Sat, 14 Dec 2024 01:05:41 +0900 (JST)
Message-Id: <20241214.010541.1426212040217092854.yamato@redhat.com>
To: 9@cirno.name
Cc: util-linux@vger.kernel.org, livia@cirno.name
Subject: Re: [PATCH] tests: add skips when IPv6 is not supported
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <2097ed76-2ed6-40da-9912-01774316370f@cirno.name>
References: <2097ed76-2ed6-40da-9912-01774316370f@cirno.name>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: LiviaMedeiros <9@cirno.name>
Subject: [PATCH] tests: add skips when IPv6 is not supported
Date: Fri, 13 Dec 2024 20:38:27 +0800

> From: LiviaMedeiros <livia@cirno.name>
> 
> Before this change on systems with disabled IPv6 (e.g. `CONFIG_IPV6 is
> not set` in kernel config), `lsfd/mkfds-tcp6` and `lsfd/mkfds-udp6`
> were failing, and `lsfd/option-inet` was hanging forever, making it
> impossible to complete the tests.
> 
> Signed-off-by: LiviaMedeiros <livia@cirno.name>
> ---
>  tests/functions.sh        | 6 ++++++
>  tests/ts/lsfd/mkfds-tcp6  | 1 +
>  tests/ts/lsfd/mkfds-udp6  | 1 +
>  tests/ts/lsfd/option-inet | 1 +
>  4 files changed, 9 insertions(+)
> 
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 630166871..add50440b 100644
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -1195,3 +1195,9 @@ function ts_check_enosys_syscalls {
>  function ts_skip_docker {
>         test -e /.dockerenv && ts_skip "unsupported in docker environment"
>  }
> +
> +function ts_check_ipv6 {
> +       if [ ! -e /proc/net/if_inet6 ]; then
> +               ts_skip "IPv6 is not supported"
> +       fi
> +}
> diff --git a/tests/ts/lsfd/mkfds-tcp6 b/tests/ts/lsfd/mkfds-tcp6
> index bffa630c4..414777f4a 100755
> --- a/tests/ts/lsfd/mkfds-tcp6
> +++ b/tests/ts/lsfd/mkfds-tcp6
> @@ -23,6 +23,7 @@ ts_init "$*"
>  ts_check_test_command "$TS_CMD_LSFD"
>  ts_check_test_command "$TS_HELPER_MKFDS"
>  ts_check_native_byteorder
> +ts_check_ipv6
>  ts_skip_docker
> 
>  ts_cd "$TS_OUTDIR"
> diff --git a/tests/ts/lsfd/mkfds-udp6 b/tests/ts/lsfd/mkfds-udp6
> index 26bdacd7c..59b1c06a2 100755
> --- a/tests/ts/lsfd/mkfds-udp6
> +++ b/tests/ts/lsfd/mkfds-udp6
> @@ -23,6 +23,7 @@ ts_init "$*"
>  ts_check_test_command "$TS_CMD_LSFD"
>  ts_check_test_command "$TS_HELPER_MKFDS"
>  ts_check_native_byteorder
> +ts_check_ipv6
>  ts_skip_docker
> 
>  ts_cd "$TS_OUTDIR"
> diff --git a/tests/ts/lsfd/option-inet b/tests/ts/lsfd/option-inet
> index 7ca883751..f679f121d 100755
> --- a/tests/ts/lsfd/option-inet
> +++ b/tests/ts/lsfd/option-inet
> @@ -24,6 +24,7 @@ ts_skip_docker
> 
>  ts_check_test_command "$TS_CMD_LSFD"
>  ts_check_test_command "$TS_HELPER_MKFDS"
> +ts_check_ipv6
> 
>  ts_check_prog "mkfifo"
> 
> --
> 2.47.1
> 

Looks good to me.
Reviewed-by: Masatake YAMATO <yamato@redhat.com>

