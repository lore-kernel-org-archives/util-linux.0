Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F02822A80E
	for <util-linux@vger.kernel.org>; Wed,  5 Mar 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177777; cv=none; b=TVeSX4HocqhiVcruXboq6j9hfYJ9j41xKdwkx98zmZydU8OiVHMqjD8K+5EE7o6KLzOX/YwVKYDZfLwTM8E+09hNQNJpDYdu7JHmomSCrANOU4CIs2U8bfiFfvykOVCAxxp4O+Gc189X7d96TbyQyaUQZbsqXli97e7wijwCG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177777; c=relaxed/simple;
	bh=amuaWEkS65slCc+5HSzprCJvJ8W1gvk0KsOiGYntKDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiQUpgWea9gahkCPBe1G8PtPHibFxUHSKSfkRAl4zho9h3EvCmPALsBDyVcSmehafEBb8GMwMqnRGamaqVw43rK9ixaUjnFjzoljFDoy4aaZJyOFdEkI75H8VVrNn0t7dslCmIx1icXqIy3jjKWMZjew9prwm3RfocRNdFD8UpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VH8QrmnB; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VH8QrmnB"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6003b679812so37826eaf.3
        for <util-linux@vger.kernel.org>; Wed, 05 Mar 2025 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1741177774; x=1741782574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1gwhFd5Nffok/w5skbwSAlzeQjfCK00/lGRM2UIkF4=;
        b=VH8QrmnBNsSE1Q9Mbmt7URfyoKKXD6vrtCD04fbt7W/nffKvDcSO5+2QyLSKYJ1AC9
         r/TFe1Mp2lsnOITtQiOpfrcyhxv+ZWh0T8Pl9I45hBTa0nDscV6/wJAjmXxZXkOx72bj
         VfuygXmUCTPaO2xyOZbVBYHhQbpASoFalWpcNrNPJ0g1IStZIxzqF4n/3VRhImh/X3Pl
         +tJzKCfyvrlfLn8NEzjBRUzd+1nREwNLXJARLy/X04R8I4KmRG4XeU085Vr1AkKkEnWn
         JPjJJ1xtie3gLIcsDOHmJcNzRYE0V79i26PEbnV9tYyRQIpjEwVQW10nQvJrIjqMjf0p
         FZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741177774; x=1741782574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1gwhFd5Nffok/w5skbwSAlzeQjfCK00/lGRM2UIkF4=;
        b=cKZ0OXQo2N6v8vdjwbzQeMQFarBjPpZL8g9cX4Q7PKEDPfQeCESnw7UnwxLL4Pwj2X
         6On92oLCxArJZRRx8bHs+harFWKg6PCd3wQt0DIBuCfSrtRmZFnaxzeEGIgO3iQ953e6
         zK9ds3caNN+SBhrvGsDRsZ6iOEp6+8p2n3XHpmbR+3/HTmbADWt3PN1+mtolzRg0j9+p
         WdLLXc7S/77p5HwjM4TJ+T8g6rXKP3KN1oRkSFgcExnZ7ZugPThMtaHe/HQSiDXvIEEP
         5zDjaNRb2G4yPf3MYAteb+9vt1tfdlRMFjiQ2EBXhtGXzUbSOzacfMSnVojndRyffZT9
         HcmQ==
X-Gm-Message-State: AOJu0YxZklQz+pg/PZQk7XAgZ+J9jywHgKzTDFzhCrrbGQcttF8SzMMI
	KUZYcB2/sIVqg/P/vD9dSIlSzU5t5NpYB9nn2VcsrUbDeChfW3qegzW1Jed3XZNpdBtmQQCOhil
	e2T0=
X-Gm-Gg: ASbGncsLDUuxMnInN4nuaOdI11Co4JfbkKvmLKPTJKE9eJQ1kENdo6z92O0zWMbpuXn
	ONEKlRNHiUq4sqs1hig+ltpkoFrIeuvI967wm6JnT+dcEdFDs2FrRS15iRpD/xqQe5+1zIeaeKp
	kl+xNZcjIjzJWK5vgwQWk3GRw18FTpnJWAcB+Quoy2nY1Xi5budgzsTu6mVGLQb9W6+0OfiVpBu
	k5eVNknr1z4hCBV94+gQD5CHsJhGCp5050aQUureH4tmyOlRWt1QK+Fs+gU6mRbPRERPTzd5Ze4
	36XwaMDpi8pTGBdxvTjHxdvrSNBdyao9b0T4v2MsqG3/dSVlyX8Q
X-Google-Smtp-Source: AGHT+IE/brnQMlirqBcYMgN9MgC/KUvX9ND46omiffn3H853mEFSLEf55U54vYdKS500j5Pydu8aaw==
X-Received: by 2002:a05:6820:1795:b0:5fe:b66d:6b1c with SMTP id 006d021491bc7-600332da304mr1541097eaf.0.1741177774440;
        Wed, 05 Mar 2025 04:29:34 -0800 (PST)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6001072a5dasm1162575eaf.0.2025.03.05.04.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:29:33 -0800 (PST)
Date: Wed, 5 Mar 2025 17:59:27 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: util-linux@vger.kernel.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: Re: [PATCH] lscpu: Print ISA information in summary
Message-ID: <Z8hDp817iqQhhRui@sunil-laptop>
References: <20250304144210.182961-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304144210.182961-1-sunilvl@ventanamicro.com>

On Tue, Mar 04, 2025 at 08:12:10PM +0530, Sunil V L wrote:
> The ISA information for RISC-V is an important information to understand
> the different extensions supported by the CPU. Print this information in
> the summary.
> 

Hi,

I had some offline conversation with Drew and Anup regarding the
formatting of the ISA. I will send v2 of this patch to address the
feedback from them. So, please ignore this version for now.

Thanks,
Sunil
