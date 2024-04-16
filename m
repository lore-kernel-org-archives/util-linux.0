Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A0A50
	for <util-linux@vger.kernel.org>; Tue, 16 Apr 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227407; cv=none; b=Y5dSouPugKdsXVmLRJBOIfDsj7ngSrve1/TjZuB+eKECOO7ZP/5vOEOw1B+lbgQakRyjDhM93Tieuhxu8tm63r+TSaxb3OwcV/v9inxZ7Slu2hrDaSyQGzLgCd75rWiTvzmR012S6Okms3Ah1ifLb0FhHIIUkEFWamNDvF3BkXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227407; c=relaxed/simple;
	bh=Ev8JXylTEVDCAwEK0fqB8O5eL+b22Lgu1RI3F2fdiKs=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D40bcTjnypyF0nOICWNoSdnZWmhxQ8awrO8DE7TQAi++omatfRABCbbomt79wl2Yq7GWjLWe2ZBwf2eSsr7CgfOOL1utZw6dlCfroojn9d+MoB0pdh7uCyjKwozsC3HRZSUsDevIkigCiV/+PNP210876FMjQ07AP45rzZILGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CY3waAZU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CY3waAZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713227404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGI9RjmccK7lbF7v+Gob68etoqveaD6aL32q+QaP2F0=;
	b=CY3waAZUCtLUAp0oM0g2i9GUz8KUCaznOsLho5GUrodFVL+AnEkkFTZgsnZtQT51P0POv3
	ggXO/0cYw3BOVqij1iN/c1+B+er4AO4r8TErCt10z/Pe6EciEh/BG5uAtXtYzL967f1iJO
	9warO7xfTznT35NGZEKsDoZlDRrQ++k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-CC1dqo2eO3SX3MdD2yuPxA-1; Mon, 15 Apr 2024 20:30:00 -0400
X-MC-Unique: CC1dqo2eO3SX3MdD2yuPxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41F1780021B;
	Tue, 16 Apr 2024 00:30:00 +0000 (UTC)
Received: from localhost (unknown [10.64.240.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4D81C060A6;
	Tue, 16 Apr 2024 00:29:59 +0000 (UTC)
Date: Tue, 16 Apr 2024 09:29:58 +0900 (JST)
Message-Id: <20240416.092958.1925095964872687612.yamato@redhat.com>
To: glaubitz@physik.fu-berlin.de
Cc: util-linux@vger.kernel.org
Subject: Re: lsfd/error-eperm test fails on git master
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
References: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi,

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: lsfd/error-eperm test fails on git master
Date: Mon, 15 Apr 2024 12:24:08 +0200

> Hello,
> 
> lsfd/error-eperm fails for me on git master. I have reproduced the issue
> on 32-bit PowerPC, 64-bit SPARC, 64-bit s390x and x86_64.
> 
> Is there a tentative fix for this failure?

Thank you for reporting.
This may be a bug in a build script.

> Thanks,
> Adrian
> 
> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$ ./run.sh lsfd/error-eperm
> 
> -------------------- util-linux regression tests --------------------
> 
>                     For development purpose only.
>                  Don't execute on production system!
> 
>        kernel: 6.6.15-powerpc64
> 
>       options: --srcdir=/home/glaubitz/util-linux-git/tests/.. \
>                --builddir=/home/glaubitz/util-linux-git/tests/..
> 
>          lsfd: fd opening a file cannot be stat(2)'ed ... FAILED (lsfd/error-eperm)
> 
> ---------------------------------------------------------------------
>   1 tests of 1 FAILED
> 
>       lsfd/error-eperm
> ---------------------------------------------------------------------
> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$
> 
> diff-{{{
> --- /home/glaubitz/util-linux-git/tests/expected/lsfd/error-eperm       2024-04-09 09:22:29.505017516 +0000
> +++ /home/glaubitz/util-linux-git/tests/output/lsfd/error-eperm 2024-04-15 08:37:38.326220593 +0000
> @@ -1,2 +1,2 @@
> -mem ERROR stat:EPERM
> +mem ERROR stat:unknown(1)

EPERM is defined as 1 in asm-generic/errno-base.h.
So `unknown(1)' should be decoded as EPERM.

lsns uses errnos.h generated at build-time for decoding the error numbers.

Can I see errnos.h at the top of the build directory ?
I guess the file is at ~/util-linux-git/errnos.h.


On my environment, the head of the file is:

    UL_ERRNO("E2BIG", E2BIG)
    UL_ERRNO("EACCES", EACCES)
    UL_ERRNO("EADDRINUSE", EADDRINUSE)
    UL_ERRNO("EADDRNOTAVAIL", EADDRNOTAVAIL)
    UL_ERRNO("EADV", EADV)
    UL_ERRNO("EAFNOSUPPORT", EAFNOSUPPORT)
    ...

Masatake YAMATO

>  ASSOC,TYPE,SOURCE:  0
> }}}-diff
> 
>  libsmartcols: fromfile: [15] wrap-tree                      ... OK
>          lsfd: fd opening a file cannot be stat(2)'ed        ... FAILED (lsfd/error-eperm)
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> 

