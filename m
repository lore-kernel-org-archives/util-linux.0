Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F65713DB9F
	for <util-linux@vger.kernel.org>; Tue, 11 Mar 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709996; cv=none; b=MN507mjEXWCV9sPzsdvsd1/KHfV2eWnohj3bxmRzFDD5cNt8GC7wE9wkRJyY7hkEgzxJAuDajb8z4rl64Y5CrhkAWRgJPXdOpfSiqaKsGOCYC15ZBOLAeO9O8ULLu2uji121ivw8shuWxjkHc5a98jyb7xcCe6e7cIujJ+EI29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709996; c=relaxed/simple;
	bh=MkAy9yhCysfvW2McIeZYVpBsX8+XVDVxFhC2Mzhuak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sObDnX18X23JfYI71Vmjya3vaEQ5gogx/UNP1sN23kk0bTxRRK577yzKLVhlHYWmybXIid7dNcycIHam1Ob4wAu+oxdPdhU/aacnVDTDDBz42Ej6AyFU4AEkviYT1nomsbQrVpnDt1MbAu1/s3c5xASQdyy2Ow8JuepxCSyuHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gPUWkHLw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gPUWkHLw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf848528aso21225985e9.2
        for <util-linux@vger.kernel.org>; Tue, 11 Mar 2025 09:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741709993; x=1742314793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgEwtRUIIB7MxtiA0x5bGfjMlMEQGJJ38BuzXcPRg0s=;
        b=gPUWkHLwznlrjcXUmPAcyegf2Gh4l4Hzn7rnZJRuQuZVXQR5HucPF+QsuQcpgTIrAd
         QilDepe4jL4cdtHkL3sBdx5U+AnYjlJhG99l8B37Od2W4byCsB9RWG2DMeRaR8FEhFOk
         lbYzGOoGzcE6Rvl0qMBAq9ayhGZyQ6AvYpJ3HxtgeQsUpbmf82W1uyEkGmJiYQgyUaoS
         3HseCddmnseTD7VloLZR49Id2/92ZjGZy2rFa6RXYlL26nag+bhl9UJjIrGrTazlTSoJ
         F2CEUoMtzIhbW2Dqla2hP2vuG7N441bBS8YUNh6ub/uwfmf6sVkJxm0ByGbBl+/XhWDo
         mswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709993; x=1742314793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgEwtRUIIB7MxtiA0x5bGfjMlMEQGJJ38BuzXcPRg0s=;
        b=cz+um4j+fyEpC4rfuZMeg8bWd2l0nzVYahgsXv4YNroOZzUGD3aktrkOvc/ClB2P7v
         GOVKEAY0xdlIlswKz0OjweTzsdT6BpiUHNgkIsEDr9DsX2ZQGhqRt/TfI90pWZQcKqn1
         8P90h0vxeRvlzs9yA1SeWLQ5fWPYBU2sevlrn1nQmCHn792d1/vsy8aT4eozYZatwPP6
         KcGfmzUfhQlxKFPFjPYEu61KSTLC5zOCldfaEu7nFcHLBAFWeLtOJ+Uy22yQDVkdGanG
         8ZDpFFFpfqVqVXEjR7+tAuhZeMRn2Kb1vcvA8PKY5KQlsH14MUu72eqfuunzRSe2KDF/
         Hptw==
X-Gm-Message-State: AOJu0Yz3JoU+vBXFrfCHe7k/9Fxf5eRxYHzY8QnGAppbREllWTbrrlzP
	BNvkXXf7LM0qo7Vmm2dl8X+VfWT9Q4Moxu56AxJBqew1+ZeQNngq+5GEK1O7uVo=
X-Gm-Gg: ASbGncuVLZ0IV8GrCoJV8QYlmAmXz6HggkxRivct7EcKCnvRlioB2WC3NA0137AUKOX
	R6EC7KPZ2gDz5esR9TzyusNSlqL+Vr7X/wdD0okAIbbk9eFJ6IuaLCMgS0hIC5XEbH882fsEV0Y
	l0pRpywPEU9+6Qzx9Akrte0HkO/OeQr+/KaebxfEgB7GedVNXYRvTplR/ECM88srlweLxMXSkES
	5RsUOj3OKMcQAuH4cKAFWwf06aTjM9ndDU4nzcqUOHB0EYmgSL5lSeLP0KiPL8A934SZwO4Mp7Y
	h38dk3bJidMCvOBlv25QlfuC+76SwTZhg5MiiBCyC00WR6Fpt4a0p++3FGjaNUJcg5erwthyTJf
	c+Ub+p3y8
X-Google-Smtp-Source: AGHT+IHWeeh77ERbAWjr+Sq4vJextBa/SMz65J/6VS4n/1LybEStmKYCKMwmadRn6iHBZjcPv5S0kA==
X-Received: by 2002:a05:600c:198e:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-43d01b875dfmr65086615e9.0.1741709993350;
        Tue, 11 Mar 2025 09:19:53 -0700 (PDT)
Received: from localhost (cst2-173-28.cust.vodafone.cz. [31.30.173.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm124655735e9.1.2025.03.11.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:19:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 17:19:52 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: util-linux@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>, 
	Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Atish Patra <atishp@rivosinc.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] lscpu: RISC-V: Print ISA information in summary
Message-ID: <20250311-8617d8509ac9d1ed6a3dbc82@orel>
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

On Tue, Mar 11, 2025 at 09:36:46PM +0530, Sunil V L wrote:
> The ISA information for RISC-V is important for understanding the
> different extensions supported by the CPU. Print the ISA information in
> the summary, with the Base ISA and single-letter extensions at the
> beginning, followed by multi-letter extensions sorted in alphabetical
> order. The information is the same as the cpuinfo information, except
> that underscores are replaced by spaces and multi-letter extensions are
> simply sorted instead of following any ISA string ordering rule.
> 
> The sample output below shows the difference between cpuinfo and lscpu.
> 
> cpuinfo output:
> isa             : rv64imafdch_zicbom_zicboz_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zawrs_zfa_zba_zbb_zbc_zbs_smaia_ssaia_sstc
> 
> lscpu output:
> ISA:                rv64imafdch smaia ssaia sstc zawrs zba zbb zbc zbs zfa zicbom zicboz zicntr zicsr zifencei zihintntl zihintpause zihpm
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
> Changes in v2:
> 	1) Format the ISA string instead of simply printing the same
> 	   from cpuinfo. (Feedback from Andrew Jones).
> ---
>  sys-utils/Makemodule.am   |  1 +
>  sys-utils/lscpu-cputype.c |  1 +
>  sys-utils/lscpu-riscv.c   | 57 +++++++++++++++++++++++++++++++++++++++
>  sys-utils/lscpu.c         |  5 ++++
>  sys-utils/lscpu.h         |  2 ++
>  sys-utils/meson.build     |  1 +
>  6 files changed, 67 insertions(+)
>  create mode 100644 sys-utils/lscpu-riscv.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
