Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771823C8CB
	for <util-linux@vger.kernel.org>; Mon, 17 Mar 2025 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217769; cv=none; b=PYUgrrPvqm0N67Ni0Dd4J6ko0HqHXDpTPGv1tXkc+Me4N9Uwa+k5bsSmVJDBLCIi4mwhrPkUccL6QP4dBmGrx0Jo5y/cyzZEHfNA5lro515qYfc2Tmn+ecD8KNoibh7QLk2IJ1B2ucLSTOlOi5Jv9vI8+k2CAo4kvqwPLYX9KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217769; c=relaxed/simple;
	bh=SsyBUXCSTDnVj3sVkbZWdBbXkwpA227I0yUVekdSmfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdwlG/WgbUZneQhd0J8rrBqaqrs+t4cia21t779VNe6RTk7qadXWtcVHyarWgFkBGML3feL53EiYov3mSaSNY5A7q74TL08GNWDNjapBANDtLflxFkxCAYvefSxkkw3F5SvSTsfHMyIBjoZOiJIo39hvObiKnWtr8Wqmbyqct0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4TcPIcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4TcPIcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742217767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mS0dMANM2vuRTBns05Z6+/CfHcFqAt8A7bIWFCIgHtU=;
	b=T4TcPIcuuCr39Muel32oEaAKJD/IAIVgOBn/22uC7c3t+jF7WWmWkOI9spWv6BOd6k9lgo
	ZWziaurKsDOvwbXVnL9QhApkrMZD9c9Z1yERPjNs2o26Eg25cpzSuoFnyhzw6+moyrgg2X
	OASMivlZItqfEVAL99oaAG4BoEPDjpc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-dMBLrSYwNWG4frlnh4Jj5w-1; Mon,
 17 Mar 2025 09:22:41 -0400
X-MC-Unique: dMBLrSYwNWG4frlnh4Jj5w-1
X-Mimecast-MFC-AGG-ID: dMBLrSYwNWG4frlnh4Jj5w_1742217760
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDD391955DCF;
	Mon, 17 Mar 2025 13:22:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 392BA180175A;
	Mon, 17 Mar 2025 13:22:35 +0000 (UTC)
Date: Mon, 17 Mar 2025 14:22:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: util-linux@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Conor Dooley <conor@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2] lscpu: RISC-V: Print ISA information in summary
Message-ID: <e36ibfrmen2g3xuzumtjgibd5a52rjqv5gdtliormy24ldi5ec@dll5hcbedrho>
References: <20250311160646.1257131-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311160646.1257131-1-sunilvl@ventanamicro.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 11, 2025 at 09:36:46PM GMT, Sunil V L wrote:
>  sys-utils/Makemodule.am   |  1 +
>  sys-utils/lscpu-cputype.c |  1 +
>  sys-utils/lscpu-riscv.c   | 57 +++++++++++++++++++++++++++++++++++++++
>  sys-utils/lscpu.c         |  5 ++++
>  sys-utils/lscpu.h         |  2 ++
>  sys-utils/meson.build     |  1 +
>  6 files changed, 67 insertions(+)
>  create mode 100644 sys-utils/lscpu-riscv.c

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

