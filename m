Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEE22FF2E
	for <util-linux@vger.kernel.org>; Mon, 17 Mar 2025 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206077; cv=none; b=TWiHrJyVBHtAEgx097t7b6tMzonoXJGElG/+TX1BpbOv1wQ/PzCSrN8Cu7KGhq8oAssYEQPaggOrC/QpQevV4YIpaZS5XtB229cWC1zUryyNOTXZiq2dNhfpci+OuOdMsxSTGAYEnA0kL7y8arBo81t+Ur5MtxFPbG3e74keuRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206077; c=relaxed/simple;
	bh=oyxZCpUjZ1zctINhGwQF9TMiGl6usRibNfFgIvoUeA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSq/bOB8RhJKqiJow6rtN3b//55/EEzqqXnFrso7vgL8bzPUyd8EJDjWqY+rYjN9sAJRD7DXkqFfl2NGXMS25B2jUcD7PIIBdCmvixfqjqG/kUTSVsmo4x3apZERU+OhbtKXX/Hma+mNjaYoyOtGegEt7b2YC3f+5VYRAUwPSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMfRhkdm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMfRhkdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742206073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5MEb1F4V1cUEebTi+DwqnaFOWVXKK4Miap/VvkNHps=;
	b=FMfRhkdmI2ebXxFbxrGYLXyREzdBlSRL9tXMADWzj1MHuVPVtk3vLfeGaxpOrqKcY9L/xu
	PIo8LHKQBkJTmKHMUimf97kN+upNkeukIpel56+DfkmQKnDk3X1R5hduhJkArxrfxiw2Rd
	dDwHt9HY5f4BRPDljLovJaV39qf9H9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-LmcU6S1-Nce3ys5h8ldFQg-1; Mon,
 17 Mar 2025 06:07:50 -0400
X-MC-Unique: LmcU6S1-Nce3ys5h8ldFQg-1
X-Mimecast-MFC-AGG-ID: LmcU6S1-Nce3ys5h8ldFQg_1742206068
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A6C51800259;
	Mon, 17 Mar 2025 10:07:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3658218001F6;
	Mon, 17 Mar 2025 10:07:43 +0000 (UTC)
Date: Mon, 17 Mar 2025 11:07:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: util-linux@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <apatel@ventanamicro.com>, Conor Dooley <conor@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2] lscpu: RISC-V: Print ISA information in summary
Message-ID: <ealqdnt3qhmdfnar6i7fzm3gnlngnrp2awp6uatfmohijcd3tp@drftuhs6c6xv>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Mar 11, 2025 at 09:36:46PM GMT, Sunil V L wrote:
>  sys-utils/Makemodule.am   |  1 +
>  sys-utils/lscpu-cputype.c |  1 +
>  sys-utils/lscpu-riscv.c   | 57 +++++++++++++++++++++++++++++++++++++++
>  sys-utils/lscpu.c         |  5 ++++
>  sys-utils/lscpu.h         |  2 ++
>  sys-utils/meson.build     |  1 +
>  6 files changed, 67 insertions(+)
>  create mode 100644 sys-utils/lscpu-riscv.c

Thank you, it looks good. I have created a PR from this patch to test
it with our tests: https://github.com/util-linux/util-linux/pull/3465

I have also updated the tests/expected/lscpu/lscpu-rv64-* files:
https://github.com/util-linux/util-linux/pull/3465/commits/659dcaa76fae256de9323b00d40cd6b0df61ff6d

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

